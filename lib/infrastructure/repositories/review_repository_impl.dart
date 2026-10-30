import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../core/errors/app_error.dart';
import '../../domain/entities/review.dart';
import '../../domain/repositories/review_repository.dart';
import '../database/app_database.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  ReviewRepositoryImpl(this._db, this._scheduler);

  final AppDatabase _db;
  final ReviewScheduler _scheduler;
  static const _uuid = Uuid();

  @override
  Future<List<ReviewQueueItem>> dueQueue(int nowMs, {int limit = 100}) async {
    final query = _db.select(_db.reviewCards).join([
      innerJoin(
        _db.questions,
        _db.questions.id.equalsExp(_db.reviewCards.questionId),
      ),
    ]);
    query.where(_db.reviewCards.dueAt.isSmallerOrEqualValue(nowMs));
    query.where(_db.questions.deletedAt.isNull());
    query.orderBy([OrderingTerm(expression: _db.reviewCards.dueAt)]);
    query.limit(limit);
    final rows = await query.get();
    if (rows.isEmpty) return [];

    final questionIds =
        rows.map((row) => row.readTable(_db.reviewCards).questionId).toList();
    final knowledge = await _knowledgeInfo(questionIds);
    return rows.map((row) {
      final cardRow = row.readTable(_db.reviewCards);
      final questionRow = row.readTable(_db.questions);
      final known = knowledge[questionRow.id];
      return ReviewQueueItem(
        card: _mapCard(cardRow),
        promptLatex: questionRow.promptLatex,
        answerLatex: questionRow.answerLatex,
        solutionLatex: questionRow.solutionLatex,
        hintLatex: questionRow.hintLatex,
        knowledgeNames: known?.names ?? const [],
        knowledgeNodeIds: known?.ids ?? const [],
      );
    }).toList();
  }

  @override
  Future<ReviewCardState?> cardOf(String questionId) async {
    final row = await (_db.select(_db.reviewCards)
          ..where((t) => t.questionId.equals(questionId)))
        .getSingleOrNull();
    return row == null ? null : _mapCard(row);
  }

  @override
  Future<int> dueCount(int nowMs) => _db.countDue(nowMs);

  @override
  Future<void> submitReview({
    required ReviewCardState card,
    required ReviewRating rating,
    required int nowMs,
    int? durationMs,
    bool usedHint = false,
    bool viewedAnswer = false,
    bool independent = false,
    List<String> stuckNodeIds = const [],
    String? errorType,
    String? requestId,
  }) async {
    final logId = requestId ?? _uuid.v4();
    await _db.transaction(() async {
      final existing = await (_db.select(_db.reviewLogs)
            ..where((t) => t.id.equals(logId)))
          .getSingleOrNull();
      if (existing != null) return;
      final row = await (_db.select(_db.reviewCards)
            ..where((t) => t.questionId.equals(card.questionId)))
          .getSingleOrNull();
      if (row == null) {
        throw const AppError(AppErrorKind.consistency, '复习卡不存在');
      }
      final before = _mapCard(row);
      final updated = _scheduler.review(
        card: before,
        rating: rating,
        nowMs: nowMs,
      );
      final affected = await (_db.update(_db.reviewCards)
            ..where((t) => t.questionId.equals(card.questionId)))
          .write(
        ReviewCardsCompanion(
          state: Value(updated.state),
          step: Value(updated.step),
          dueAt: Value(updated.dueAt),
          stability: Value(updated.stability),
          difficulty: Value(updated.difficulty),
          elapsedDays: Value(updated.elapsedDays),
          scheduledDays: Value(updated.scheduledDays),
          reps: Value(updated.reps),
          lapses: Value(updated.lapses),
          lastReviewAt: Value(updated.lastReviewAt),
          updatedAt: Value(nowMs),
        ),
      );
      if (affected == 0) {
        throw const AppError(AppErrorKind.consistency, '复习卡更新失败');
      }
      await _db.into(_db.reviewLogs).insert(
            ReviewLogsCompanion.insert(
              id: logId,
              questionId: card.questionId,
              rating: Value(rating.value),
              reviewedAt: Value(nowMs),
              durationMs: Value(durationMs),
              usedHint: Value(usedHint),
              viewedAnswer: Value(viewedAnswer),
              independent: Value(independent),
              kind: const Value('review'),
              stuckNodeIdsJson: Value(
                stuckNodeIds.isEmpty ? null : jsonEncode(stuckNodeIds),
              ),
              errorType: Value(errorType),
              stateBeforeJson: Value(jsonEncode(_stateMap(before))),
              stateAfterJson: Value(jsonEncode(_stateMap(updated))),
              schedulerId: Value(row.schedulerId),
              paramsVersion: Value(row.paramsVersion),
              createdAt: Value(nowMs),
            ),
          );
    });
  }

  @override
  Future<void> skip({
    required String questionId,
    required int nowMs,
    int? durationMs,
    String? requestId,
  }) async {
    final logId = requestId ?? _uuid.v4();
    final card = await cardOf(questionId);
    if (card == null) {
      throw const AppError(AppErrorKind.consistency, '复习卡不存在');
    }
    final existing = await (_db.select(_db.reviewLogs)
          ..where((t) => t.id.equals(logId)))
        .getSingleOrNull();
    if (existing != null) return;
    await _db.into(_db.reviewLogs).insert(
          ReviewLogsCompanion.insert(
            id: logId,
            questionId: questionId,
            reviewedAt: Value(nowMs),
            durationMs: Value(durationMs),
            kind: const Value('skip'),
            schedulerId: const Value('fsrs-6'),
            paramsVersion: const Value('default-1'),
            createdAt: Value(nowMs),
          ),
        );
  }

  @override
  Future<int> historyCount() async {
    final count = _db.reviewLogs.id.count();
    final query = _db.selectOnly(_db.reviewLogs)..addColumns([count]);
    final row = await query.getSingle();
    return row.read(count) ?? 0;
  }

  ReviewCardState _mapCard(ReviewCardRow row) {
    return ReviewCardState(
      questionId: row.questionId,
      state: row.state,
      step: row.step,
      dueAt: row.dueAt,
      reps: row.reps,
      lapses: row.lapses,
      stability: row.stability,
      difficulty: row.difficulty,
      elapsedDays: row.elapsedDays,
      scheduledDays: row.scheduledDays,
      lastReviewAt: row.lastReviewAt,
    );
  }

  Map<String, Object?> _stateMap(ReviewCardState card) {
    return {
      'state': card.state,
      'step': card.step,
      'dueAt': card.dueAt,
      'stability': card.stability,
      'difficulty': card.difficulty,
      'reps': card.reps,
      'lapses': card.lapses,
      'elapsedDays': card.elapsedDays,
      'scheduledDays': card.scheduledDays,
      'lastReviewAt': card.lastReviewAt,
    };
  }

  Future<Map<String, ({List<String> ids, List<String> names})>>
      _knowledgeInfo(List<String> questionIds) async {
    final links = await (_db.select(_db.questionKnowledge)
          ..where((t) => t.questionId.isIn(questionIds)))
        .get();
    if (links.isEmpty) return const {};
    final nodeIds = links.map((link) => link.nodeId).toSet().toList();
    final nodes = await (_db.select(_db.knowledgeNodes)
          ..where((t) => t.id.isIn(nodeIds)))
        .get();
    final names = {for (final node in nodes) node.id: node.name};
    final ids = <String, List<String>>{};
    final namesByQuestion = <String, List<String>>{};
    for (final link in links) {
      final name = names[link.nodeId];
      if (name == null) continue;
      ids.putIfAbsent(link.questionId, () => []).add(link.nodeId);
      namesByQuestion.putIfAbsent(link.questionId, () => []).add(name);
    }
    return {
      for (final questionId in ids.keys)
        questionId: (ids: ids[questionId]!, names: namesByQuestion[questionId]!),
    };
  }
}
