import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mathrecall/core/errors/app_error.dart';
import 'package:mathrecall/domain/entities/ai_draft.dart';
import 'package:mathrecall/domain/entities/draft.dart';
import 'package:mathrecall/infrastructure/database/app_database.dart';
import 'package:mathrecall/infrastructure/repositories/draft_repository_impl.dart';
import 'package:mathrecall/infrastructure/repositories/knowledge_repository_impl.dart';

void main() {
  late AppDatabase db;
  late KnowledgeRepositoryImpl knowledge;
  late DraftRepositoryImpl drafts;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    knowledge = KnowledgeRepositoryImpl(db);
    drafts = DraftRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  Future<String> createPoint(String name) async {
    final subject = await knowledge.createNode(name: '高等数学');
    final chapter = await knowledge.createNode(
      parentId: subject.id,
      name: '极限与连续',
    );
    final point = await knowledge.createNode(
      parentId: chapter.id,
      name: name,
    );
    return point.id;
  }

  test('confirm creates questions, knowledge links and review cards', () async {
    await createPoint('等价无穷小');
    final draft = await drafts.createFromImage(
      imageSha256: 'a' * 64,
      imageRelPath: 'images/original/a.jpg',
      source: 'camera',
    );
    await drafts.saveItems(draft.id, [
      DraftItem(
        id: 'item-1',
        draftId: draft.id,
        sortOrder: 0,
        promptLatex: r'求 \lim_{x\to0}\frac{\sin x}{x}',
        answerLatex: '1',
        knowledgePoints: const ['等价无穷小'],
      ),
      DraftItem(
        id: 'item-2',
        draftId: draft.id,
        sortOrder: 1,
        promptLatex: '矩阵求逆',
        isSelected: false,
      ),
    ]);

    final ids = await drafts.confirm(draft.id, selectedItemIds: {'item-1'});
    expect(ids, hasLength(1));
    expect(await db.countQuestions(), 1);
    expect(await db.select(db.reviewCards).get(), hasLength(1));
    expect(await db.select(db.questionKnowledge).get(), hasLength(1));

    final items = await drafts.itemsOf(draft.id);
    expect(items.firstWhere((i) => i.id == 'item-1').createdQuestionId, ids.first);
    expect(
      items.firstWhere((i) => i.id == 'item-2').createdQuestionId,
      isNull,
    );
    expect((await drafts.findById(draft.id))?.status, DraftStatus.confirmed);
  });

  test('markReady stores AI metadata and replaces items', () async {
    final draft = await drafts.createFromImage(
      imageSha256: 'b' * 64,
      imageRelPath: 'images/original/b.jpg',
      source: 'gallery',
    );
    final result = AiDraftResult(
      questions: const [
        AiQuestionDraft(promptLatex: '题目 A'),
      ],
      rawJson: '{"questions":[{"prompt_latex":"题目 A"}]}',
      provider: 'deepseek',
      model: 'vlm',
    );
    await drafts.markReady(draft.id, result, [
      DraftItem(
        id: 'x',
        draftId: draft.id,
        sortOrder: 0,
        promptLatex: '题目 A',
      ),
    ]);

    final updated = await drafts.findById(draft.id);
    expect(updated?.status, DraftStatus.ready);
    expect(updated?.aiProvider, 'deepseek');
    expect(updated?.aiModel, 'vlm');
    expect((await drafts.itemsOf(draft.id)), hasLength(1));
  });

  test('empty or fully unselected draft cannot be confirmed', () async {
    final draft = await drafts.createFromImage(
      imageSha256: 'c' * 64,
      imageRelPath: 'images/original/c.jpg',
      source: 'camera',
    );
    await expectLater(
      drafts.confirm(draft.id),
      throwsA(isA<AppError>()),
    );
  });

  test('matches AI knowledge path to existing leaf and links question', () async {
    final pointId = await createPoint('等价无穷小');
    final draft = await drafts.createFromImage(
      imageSha256: 'e' * 64,
      imageRelPath: 'images/original/e.jpg',
      source: 'camera',
    );
    await drafts.saveItems(draft.id, [
      DraftItem(
        id: 'path-item',
        draftId: draft.id,
        sortOrder: 0,
        promptLatex: '路径匹配题',
        knowledgePoints: const ['高数/极限/等价无穷小'],
      ),
    ]);

    final match =
        await drafts.matchKnowledgePoints(const ['高数/极限/等价无穷小']);
    expect(match.matched.values, [pointId]);

    await drafts.confirm(draft.id);
    final links = await db.select(db.questionKnowledge).get();
    expect(links, hasLength(1));
    expect(links.single.nodeId, pointId);
  });

  test('attaches images to item, preserves them on save, and copies on confirm',
      () async {
    await db.into(db.imageAssets).insert(
          ImageAssetsCompanion.insert(
            sha256: 'f' * 64,
            relPath: 'images/original/f.jpg',
          ),
        );
    final draft = await drafts.createFromImage(
      imageSha256: 'f' * 64,
      imageRelPath: 'images/original/f.jpg',
      source: 'camera',
    );
    await drafts.saveItems(draft.id, [
      DraftItem(
        id: 'attach-item',
        draftId: draft.id,
        sortOrder: 0,
        promptLatex: '附加图片题',
      ),
    ]);
    await drafts.addItemImage('attach-item', 'f' * 64);

    var items = await drafts.itemsOf(draft.id);
    expect(items.single.imageSha256s, ['f' * 64]);

    await drafts.saveItems(draft.id, items);
    items = await drafts.itemsOf(draft.id);
    expect(items.single.imageSha256s, ['f' * 64]);

    await drafts.confirm(draft.id);
    expect(await db.select(db.questionImages).get(), hasLength(1));
  });

  test('reports unmatched knowledge instead of silently dropping', () async {
    final result = await drafts.matchKnowledgePoints(const ['不存在的知识点']);
    expect(result.matched, isEmpty);
    expect(result.unmatched, contains('不存在的知识点'));
  });

  test('discard removes draft and items', () async {
    final draft = await drafts.createFromImage(
      imageSha256: 'd' * 64,
      imageRelPath: 'images/original/d.jpg',
      source: 'camera',
    );
    await drafts.saveItems(draft.id, [
      DraftItem(id: 'i', draftId: draft.id, sortOrder: 0, promptLatex: 'x'),
    ]);
    await drafts.discard(draft.id);

    expect(await drafts.findById(draft.id), isNull);
    expect(await db.select(db.draftItems).get(), isEmpty);
  });
}
