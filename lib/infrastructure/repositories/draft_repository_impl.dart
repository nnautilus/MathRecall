import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../core/errors/app_error.dart';
import '../../domain/entities/ai_draft.dart';
import '../../domain/entities/draft.dart';
import '../../domain/entities/knowledge_match.dart';
import '../../domain/repositories/draft_repository.dart';
import '../database/app_database.dart';

class DraftRepositoryImpl implements DraftRepository {
  DraftRepositoryImpl(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();
  static const _draftTtlMs = 24 * 60 * 60 * 1000;

  int get _now => DateTime.now().toUtc().millisecondsSinceEpoch;

  @override
  Future<Draft> createFromImage({
    required String imageSha256,
    required String imageRelPath,
    required String source,
  }) async {
    final id = _uuid.v4();
    final now = _now;
    await _db.into(_db.drafts).insert(
          DraftsCompanion.insert(
            id: id,
            source: Value(source),
            imageSha256: Value(imageSha256),
            tempImagePath: Value(imageRelPath),
            createdAt: Value(now),
            expiresAt: Value(now + _draftTtlMs),
          ),
        );
    final row = await (_db.select(_db.drafts)..where((t) => t.id.equals(id)))
        .getSingle();
    return _mapDraft(row);
  }

  @override
  Future<Draft?> findById(String id) async {
    final row = await (_db.select(_db.drafts)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _mapDraft(row);
  }

  @override
  Future<List<DraftItem>> itemsOf(String draftId) async {
    final rows = await (_db.select(_db.draftItems)
          ..where((t) => t.draftId.equals(draftId))
          ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
        .get();
    if (rows.isEmpty) return const [];
    final images = await _imageMap(rows.map((row) => row.id).toList());
    return rows
        .map((row) => _mapItem(row, images[row.id] ?? const []))
        .toList();
  }

  @override
  Future<void> addItemImage(String itemId, String sha256) async {
    await _db.into(_db.draftItemImages).insert(
          DraftItemImagesCompanion.insert(
            draftItemId: itemId,
            sha256: sha256,
            createdAt: Value(_now),
          ),
          mode: InsertMode.insertOrIgnore,
        );
  }

  @override
  Future<void> removeItemImage(String itemId, String sha256) async {
    await (_db.delete(_db.draftItemImages)
          ..where((t) =>
              t.draftItemId.equals(itemId) & t.sha256.equals(sha256)))
        .go();
  }

  @override
  Future<void> markAnalyzing(
    String draftId, {
    required String provider,
    required String model,
    required String promptVersion,
  }) async {
    await (_db.update(_db.drafts)..where((t) => t.id.equals(draftId))).write(
      DraftsCompanion(
        status: const Value('analyzing'),
        aiProvider: Value(provider),
        aiModel: Value(model),
        aiPromptVersion: Value(promptVersion),
        errorCode: const Value(null),
      ),
    );
  }

  @override
  Future<void> markReady(
    String draftId,
    AiDraftResult result,
    List<DraftItem> items,
  ) async {
    await _db.transaction(() async {
      await (_db.update(_db.drafts)..where((t) => t.id.equals(draftId))).write(
        DraftsCompanion(
          status: const Value('ready'),
          aiRawJson: Value(result.rawJson),
          aiProvider: Value(result.provider),
          aiModel: Value(result.model),
          aiPromptVersion: Value(result.promptVersion),
          errorCode: const Value(null),
        ),
      );
      await _replaceItems(draftId, items);
    });
  }

  @override
  Future<void> markFailed(String draftId, String errorCode) async {
    await (_db.update(_db.drafts)..where((t) => t.id.equals(draftId))).write(
      DraftsCompanion(
        status: const Value('failed'),
        errorCode: Value(errorCode),
      ),
    );
  }

  @override
  Future<List<DraftItem>> saveItems(
    String draftId,
    List<DraftItem> items,
  ) async {
    return _db.transaction(() async {
      await _replaceItems(draftId, items);
      final rows = await (_db.select(_db.draftItems)
            ..where((t) => t.draftId.equals(draftId))
            ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
          .get();
      final images = await _imageMap(rows.map((row) => row.id).toList());
      return rows
          .map((row) => _mapItem(row, images[row.id] ?? const []))
          .toList();
    });
  }

  @override
  Future<List<String>> confirm(
    String draftId, {
    Set<String>? selectedItemIds,
  }) async {
    return _db.transaction(() async {
      final draft = await findById(draftId);
      if (draft == null) {
        throw const AppError(AppErrorKind.validation, '草稿不存在');
      }
      final all = await itemsOf(draftId);
      if (all.isEmpty) {
        throw const AppError(AppErrorKind.validation, '草稿没有题目');
      }
      final selected = all
          .where((item) =>
              selectedItemIds == null || selectedItemIds.contains(item.id))
          .where((item) => item.isSelected)
          .where((item) => item.createdQuestionId == null)
          .toList();
      if (selected.isEmpty) {
        throw const AppError(AppErrorKind.validation, '没有可入库的题目');
      }

      final nodeIdsByName =
          (await matchKnowledgePoints(
            selected.expand((item) => item.knowledgePoints).toList(),
          ))
              .matched;
      final now = _now;
      final createdIds = <String>[];
      for (final item in selected) {
        final prompt = item.promptLatex?.trim() ?? '';
        if (prompt.isEmpty) {
          throw const AppError(AppErrorKind.validation, '存在空白题干，请先编辑');
        }
        final questionId = _uuid.v4();
        await _db.into(_db.questions).insert(
              QuestionsCompanion.insert(
                id: questionId,
                promptLatex: prompt,
                answerLatex: Value(_nullIfEmpty(item.answerLatex)),
                solutionLatex: Value(_nullIfEmpty(item.solutionLatex)),
                createdAt: Value(now),
                updatedAt: Value(now),
              ),
            );
        for (final name in item.knowledgePoints) {
          final nodeId = nodeIdsByName[name.trim()];
          if (nodeId == null) continue;
          await _db.into(_db.questionKnowledge).insert(
                QuestionKnowledgeCompanion.insert(
                  questionId: questionId,
                  nodeId: nodeId,
                ),
                mode: InsertMode.insertOrIgnore,
              );
        }
        await _db.into(_db.reviewCards).insert(
              ReviewCardsCompanion.insert(
                questionId: questionId,
                step: const Value(0),
                dueAt: Value(now),
                createdAt: Value(now),
                updatedAt: Value(now),
              ),
              mode: InsertMode.insertOrIgnore,
            );
        if (draft.imageSha256 != null) {
          final asset = await (_db.select(_db.imageAssets)
                ..where((t) => t.sha256.equals(draft.imageSha256!)))
              .getSingleOrNull();
          if (asset != null) {
            await _db.into(_db.questionImages).insert(
                  QuestionImagesCompanion.insert(
                    questionId: questionId,
                    sha256: draft.imageSha256!,
                    role: const Value('original'),
                    createdAt: Value(now),
                  ),
                  mode: InsertMode.insertOrIgnore,
                );
          }
        }
        for (final sha in item.imageSha256s) {
          final asset = await (_db.select(_db.imageAssets)
                ..where((t) => t.sha256.equals(sha)))
              .getSingleOrNull();
          if (asset == null) continue;
          await _db.into(_db.questionImages).insert(
                QuestionImagesCompanion.insert(
                  questionId: questionId,
                  sha256: sha,
                  role: const Value('original'),
                  createdAt: Value(now),
                ),
                mode: InsertMode.insertOrIgnore,
              );
        }
        await (_db.update(_db.draftItems)..where((t) => t.id.equals(item.id)))
            .write(DraftItemsCompanion(createdQuestionId: Value(questionId)));
        createdIds.add(questionId);
      }

      await (_db.update(_db.drafts)..where((t) => t.id.equals(draftId))).write(
        const DraftsCompanion(status: Value('confirmed')),
      );
      return createdIds;
    });
  }

  @override
  Future<void> discard(String draftId) async {
    await (_db.delete(_db.drafts)..where((t) => t.id.equals(draftId))).go();
  }

  @override
  Future<int> cleanupExpired(int nowMs) async {
    return (_db.delete(_db.drafts)
          ..where((t) => t.expiresAt.isSmallerThanValue(nowMs)))
        .go();
  }

  Future<void> _replaceItems(String draftId, List<DraftItem> items) async {
    final existingIds =
        items.map((item) => item.id).where((id) => id.isNotEmpty).toList();
    final preserved = await _imageMap(existingIds);
    await (_db.delete(_db.draftItems)..where((t) => t.draftId.equals(draftId)))
        .go();
    for (var index = 0; index < items.length; index++) {
      final item = items[index];
      final itemId = item.id.isEmpty ? _uuid.v4() : item.id;
      await _db.into(_db.draftItems).insert(
            DraftItemsCompanion.insert(
              id: itemId,
              draftId: draftId,
              sortOrder: Value(index),
              promptLatex: Value(_nullIfEmpty(item.promptLatex)),
              answerLatex: Value(_nullIfEmpty(item.answerLatex)),
              solutionLatex: Value(_nullIfEmpty(item.solutionLatex)),
              knowledgePointsJson: Value(jsonEncode(item.knowledgePoints)),
              confidence: Value(item.confidence),
              isSelected: Value(item.isSelected),
              createdQuestionId: Value(item.createdQuestionId),
            ),
          );
      for (final sha in preserved[item.id] ?? const <String>[]) {
        await _db.into(_db.draftItemImages).insert(
              DraftItemImagesCompanion.insert(
                draftItemId: itemId,
                sha256: sha,
                createdAt: Value(_now),
              ),
              mode: InsertMode.insertOrIgnore,
            );
      }
    }
  }

  Future<Map<String, List<String>>> _imageMap(List<String> itemIds) async {
    if (itemIds.isEmpty) return const {};
    final links = await (_db.select(_db.draftItemImages)
          ..where((t) => t.draftItemId.isIn(itemIds)))
        .get();
    final result = <String, List<String>>{};
    for (final link in links) {
      result.putIfAbsent(link.draftItemId, () => []).add(link.sha256);
    }
    return result;
  }

  @override
  Future<KnowledgeMatchResult> matchKnowledgePoints(
    List<String> candidates,
  ) async {
    final cleaned = <String>{};
    for (final candidate in candidates) {
      final trimmed = candidate.trim();
      if (trimmed.isNotEmpty) cleaned.add(trimmed);
    }
    if (cleaned.isEmpty) return const KnowledgeMatchResult();

    final leaves = await (_db.select(_db.knowledgeNodes)
          ..where((t) => t.level.equals(3))
          ..where((t) => t.isActive.equals(true)))
        .get();
    if (leaves.isEmpty) {
      return KnowledgeMatchResult(unmatched: cleaned.toList());
    }

    final parentIds =
        leaves.map((leaf) => leaf.parentId).whereType<String>().toSet();
    final parents = parentIds.isEmpty
        ? <KnowledgeNodeRow>[]
        : await (_db.select(_db.knowledgeNodes)
              ..where((t) => t.id.isIn(parentIds)))
            .get();
    final parentById = {for (final parent in parents) parent.id: parent};
    final subjectIds =
        parents.map((parent) => parent.parentId).whereType<String>().toSet();
    final subjects = subjectIds.isEmpty
        ? <KnowledgeNodeRow>[]
        : await (_db.select(_db.knowledgeNodes)
              ..where((t) => t.id.isIn(subjectIds)))
            .get();
    final subjectById = {for (final subject in subjects) subject.id: subject};

    final fullPaths = <String, String>{};
    final chapterLeafPaths = <String, String>{};
    final leafByName = <String, List<String>>{};
    for (final leaf in leaves) {
      final chapter = leaf.parentId == null ? null : parentById[leaf.parentId];
      final subject = chapter?.parentId == null
          ? null
          : subjectById[chapter!.parentId];
      final parts = <String>[
        if (subject != null) subject.name,
        if (chapter != null) chapter.name,
        leaf.name,
      ];
      fullPaths[_normalize(parts.join('/'))] = leaf.id;
      if (chapter != null) {
        chapterLeafPaths[_normalize('${chapter.name}/${leaf.name}')] = leaf.id;
      }
      leafByName.putIfAbsent(_normalize(leaf.name), () => []).add(leaf.id);
    }

    final matched = <String, String>{};
    final unmatched = <String>[];
    final ambiguous = <String>[];
    for (final candidate in cleaned) {
      final normalized = _normalize(candidate);
      final parts = normalized.split('/');
      String? nodeId = fullPaths[normalized];
      if (nodeId == null && parts.length >= 2) {
        nodeId =
            chapterLeafPaths[parts.sublist(parts.length - 2).join('/')];
      }
      if (nodeId == null) {
        final ids = leafByName[parts.last] ?? const <String>[];
        if (ids.length == 1) {
          nodeId = ids.first;
        } else if (ids.length > 1) {
          ambiguous.add(candidate);
          continue;
        }
      }
      if (nodeId == null) {
        unmatched.add(candidate);
      } else {
        matched[candidate] = nodeId;
      }
    }

    return KnowledgeMatchResult(
      matched: matched,
      unmatched: unmatched,
      ambiguous: ambiguous,
    );
  }

  String _normalize(String value) {
    return value
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[\\>→]+'), '/')
        .split('/')
        .map((part) => part.trim())
        .where((part) => part.isNotEmpty)
        .join('/');
  }

  Draft _mapDraft(DraftRow row) {
    return Draft(
      id: row.id,
      source: row.source,
      status: DraftStatus.fromDb(row.status),
      createdAt: row.createdAt,
      imageSha256: row.imageSha256,
      imageRelPath: row.tempImagePath,
      aiRawJson: row.aiRawJson,
      aiProvider: row.aiProvider,
      aiModel: row.aiModel,
      aiPromptVersion: row.aiPromptVersion,
      errorCode: row.errorCode,
      expiresAt: row.expiresAt,
    );
  }

  DraftItem _mapItem(DraftItemRow row, List<String> imageSha256s) {
    final knowledge = row.knowledgePointsJson == null
        ? const <String>[]
        : (jsonDecode(row.knowledgePointsJson!) as List)
            .map((value) => value.toString())
            .toList();
    return DraftItem(
      id: row.id,
      draftId: row.draftId,
      sortOrder: row.sortOrder,
      promptLatex: row.promptLatex,
      answerLatex: row.answerLatex,
      solutionLatex: row.solutionLatex,
      knowledgePoints: knowledge,
      confidence: row.confidence,
      isSelected: row.isSelected,
      createdQuestionId: row.createdQuestionId,
      imageSha256s: imageSha256s,
    );
  }

  String? _nullIfEmpty(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
