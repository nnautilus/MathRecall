import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../core/errors/app_error.dart';
import '../../domain/entities/question.dart';
import '../../domain/repositories/question_repository.dart';
import '../database/app_database.dart';

class QuestionRepositoryImpl implements QuestionRepository {
  QuestionRepositoryImpl(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  int get _now => DateTime.now().toUtc().millisecondsSinceEpoch;

  @override
  Future<List<Question>> list({
    String keyword = '',
    bool onlyStarred = false,
    bool includeDeleted = false,
    String? knowledgeNodeId,
  }) async {
    final query = _db.select(_db.questions);
    if (includeDeleted) {
      query.where((t) => t.deletedAt.isNotNull());
    } else {
      query.where((t) => t.deletedAt.isNull());
    }
    if (onlyStarred) {
      query.where((t) => t.isStarred.equals(true));
    }
    final cleanKeyword = keyword.trim();
    if (cleanKeyword.isNotEmpty) {
      final like = '%$cleanKeyword%';
      query.where(
        (t) =>
            t.promptLatex.like(like) |
            t.answerLatex.like(like) |
            t.solutionLatex.like(like),
      );
    }
    query.orderBy([
      (t) => OrderingTerm(expression: t.updatedAt, mode: OrderingMode.desc),
    ]);

    var rows = await query.get();
    if (knowledgeNodeId != null) {
      final links = await (_db.select(_db.questionKnowledge)
            ..where((t) => t.nodeId.equals(knowledgeNodeId)))
          .get();
      final ids = links.map((link) => link.questionId).toSet();
      rows = rows.where((row) => ids.contains(row.id)).toList();
    }
    return _attachLinks(rows);
  }

  @override
  Future<Question?> findById(String id) async {
    final row = await (_db.select(_db.questions)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (row == null) {
      return null;
    }
    final list = await _attachLinks([row]);
    return list.single;
  }

  @override
  Future<List<Question>> recent({int limit = 3}) async {
    final rows = await (_db.select(_db.questions)
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([
            (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ])
          ..limit(limit))
        .get();
    return _attachLinks(rows);
  }

  @override
  Future<String> create({
    required String promptLatex,
    String? answerLatex,
    String? solutionLatex,
    String? hintLatex,
    int? difficulty,
    String? sourceText,
    List<String> knowledgeNodeIds = const [],
    List<String> tagIds = const [],
  }) async {
    if (promptLatex.trim().isEmpty) {
      throw const AppError(AppErrorKind.validation, '题目不能为空');
    }
    await _ensureKnowledgeExists(knowledgeNodeIds);
    final id = _uuid.v4();
    final now = _now;
    await _db.transaction(() async {
      await _db.into(_db.questions).insert(
            QuestionsCompanion.insert(
              id: id,
              promptLatex: promptLatex,
              answerLatex: Value(answerLatex),
              solutionLatex: Value(solutionLatex),
              hintLatex: Value(hintLatex),
              difficulty: Value(difficulty),
              sourceText: Value(sourceText),
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
          );
      for (final nodeId in knowledgeNodeIds) {
        await _db.into(_db.questionKnowledge).insert(
              QuestionKnowledgeCompanion.insert(
                questionId: id,
                nodeId: nodeId,
              ),
            );
      }
      for (final tagId in tagIds) {
        await _db.into(_db.questionTags).insert(
              QuestionTagsCompanion.insert(questionId: id, tagId: tagId),
            );
      }
      await _db.into(_db.reviewCards).insert(
            ReviewCardsCompanion.insert(
              questionId: id,
              step: const Value(0),
              dueAt: Value(now),
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
            mode: InsertMode.insertOrIgnore,
          );
    });
    return id;
  }

  @override
  Future<void> update({
    required String id,
    required String promptLatex,
    String? answerLatex,
    String? solutionLatex,
    String? hintLatex,
    int? difficulty,
    String? sourceText,
  }) async {
    if (promptLatex.trim().isEmpty) {
      throw const AppError(AppErrorKind.validation, '题目不能为空');
    }
    await (_db.update(_db.questions)..where((t) => t.id.equals(id))).write(
      QuestionsCompanion(
        promptLatex: Value(promptLatex),
        answerLatex: Value(answerLatex),
        solutionLatex: Value(solutionLatex),
        hintLatex: Value(hintLatex),
        difficulty: Value(difficulty),
        sourceText: Value(sourceText),
        updatedAt: Value(_now),
      ),
    );
  }

  @override
  Future<void> setKnowledge(String questionId, List<String> nodeIds) async {
    await _ensureKnowledgeExists(nodeIds);
    await _db.transaction(() async {
      await (_db.delete(_db.questionKnowledge)
            ..where((t) => t.questionId.equals(questionId)))
          .go();
      for (final nodeId in nodeIds) {
        await _db.into(_db.questionKnowledge).insert(
              QuestionKnowledgeCompanion.insert(
                questionId: questionId,
                nodeId: nodeId,
              ),
            );
      }
    });
  }

  @override
  Future<void> setStarred(String id, bool starred) async {
    await (_db.update(_db.questions)..where((t) => t.id.equals(id))).write(
      QuestionsCompanion(isStarred: Value(starred), updatedAt: Value(_now)),
    );
  }

  @override
  Future<void> setStarredMany(List<String> ids, bool starred) async {
    if (ids.isEmpty) return;
    await (_db.update(_db.questions)..where((t) => t.id.isIn(ids))).write(
      QuestionsCompanion(isStarred: Value(starred), updatedAt: Value(_now)),
    );
  }

  @override
  Future<void> softDelete(String id) async {
    final now = _now;
    await (_db.update(_db.questions)..where((t) => t.id.equals(id))).write(
      QuestionsCompanion(deletedAt: Value(now), updatedAt: Value(now)),
    );
  }

  @override
  Future<void> softDeleteMany(List<String> ids) async {
    if (ids.isEmpty) return;
    final now = _now;
    await (_db.update(_db.questions)..where((t) => t.id.isIn(ids))).write(
      QuestionsCompanion(deletedAt: Value(now), updatedAt: Value(now)),
    );
  }

  @override
  Future<void> restore(String id) async {
    await (_db.update(_db.questions)..where((t) => t.id.equals(id))).write(
      QuestionsCompanion(
        deletedAt: const Value(null),
        updatedAt: Value(_now),
      ),
    );
  }

  @override
  Future<void> restoreMany(List<String> ids) async {
    if (ids.isEmpty) return;
    await (_db.update(_db.questions)..where((t) => t.id.isIn(ids))).write(
      QuestionsCompanion(
        deletedAt: const Value(null),
        updatedAt: Value(_now),
      ),
    );
  }

  @override
  Future<int> purgeMany(List<String> ids) async {
    if (ids.isEmpty) return 0;
    return (_db.delete(_db.questions)..where((t) => t.id.isIn(ids))).go();
  }

  @override
  Future<int> count() async {
    final count = _db.questions.id.count();
    final query = _db.selectOnly(_db.questions)
      ..addColumns([count])
      ..where(_db.questions.deletedAt.isNull());
    final row = await query.getSingle();
    return row.read(count) ?? 0;
  }

  Future<void> _ensureKnowledgeExists(List<String> nodeIds) async {
    if (nodeIds.isEmpty) {
      return;
    }
    final rows = await (_db.select(_db.knowledgeNodes)
          ..where((t) => t.id.isIn(nodeIds)))
        .get();
    if (rows.length != nodeIds.toSet().length) {
      throw const AppError(AppErrorKind.validation, '存在无效的知识点');
    }
  }

  Future<List<Question>> _attachLinks(List<QuestionRow> rows) async {
    if (rows.isEmpty) {
      return [];
    }
    final ids = rows.map((row) => row.id).toList();
    final links = await (_db.select(_db.questionKnowledge)
          ..where((t) => t.questionId.isIn(ids)))
        .get();
    final nodeIds = links.map((link) => link.nodeId).toSet().toList();
    final nodes = nodeIds.isEmpty
        ? <KnowledgeNodeRow>[]
        : await (_db.select(_db.knowledgeNodes)
              ..where((t) => t.id.isIn(nodeIds)))
            .get();
    final nodeNames = {for (final node in nodes) node.id: node.name};

    final tagLinks = await (_db.select(_db.questionTags)
          ..where((t) => t.questionId.isIn(ids)))
        .get();
    final tagIds = tagLinks.map((link) => link.tagId).toSet().toList();
    final tags = tagIds.isEmpty
        ? <TagRow>[]
        : await (_db.select(_db.tags)..where((t) => t.id.isIn(tagIds))).get();
    final tagNames = {for (final tag in tags) tag.id: tag.name};

    return rows.map((row) {
      final rowLinks = links.where((l) => l.questionId == row.id).toList();
      final rowTags = tagLinks.where((l) => l.questionId == row.id).toList();
      return Question(
        id: row.id,
        promptLatex: row.promptLatex,
        answerLatex: row.answerLatex,
        solutionLatex: row.solutionLatex,
        hintLatex: row.hintLatex,
        difficulty: row.difficulty,
        sourceText: row.sourceText,
        errorReason: row.errorReason,
        isStarred: row.isStarred,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
        deletedAt: row.deletedAt,
        knowledgeNodeIds: rowLinks.map((l) => l.nodeId).toList(),
        knowledgeNames: rowLinks
            .map((l) => nodeNames[l.nodeId] ?? '')
            .where((name) => name.isNotEmpty)
            .toList(),
        tagNames: rowTags
            .map((l) => tagNames[l.tagId] ?? '')
            .where((name) => name.isNotEmpty)
            .toList(),
      );
    }).toList();
  }
}
