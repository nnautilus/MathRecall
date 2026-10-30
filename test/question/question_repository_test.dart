import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mathrecall/core/errors/app_error.dart';
import 'package:mathrecall/infrastructure/database/app_database.dart';
import 'package:mathrecall/infrastructure/repositories/knowledge_repository_impl.dart';
import 'package:mathrecall/infrastructure/repositories/question_repository_impl.dart';

void main() {
  late AppDatabase db;
  late KnowledgeRepositoryImpl knowledge;
  late QuestionRepositoryImpl questions;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    knowledge = KnowledgeRepositoryImpl(db);
    questions = QuestionRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  Future<String> createPoint() async {
    final subject = await knowledge.createNode(name: '高等数学');
    final chapter = await knowledge.createNode(parentId: subject.id, name: '极限');
    final point = await knowledge.createNode(parentId: chapter.id, name: '等价无穷小');
    return point.id;
  }

  test('creates question with knowledge links and lists it', () async {
    final pointId = await createPoint();
    final id = await questions.create(
      promptLatex: r'$\lim_{x\to0}\frac{\sin x}{x}$',
      answerLatex: '1',
      difficulty: 2,
      knowledgeNodeIds: [pointId],
    );

    final list = await questions.list();
    expect(list, hasLength(1));
    expect(list.single.id, id);
    expect(list.single.knowledgeNames, contains('等价无穷小'));

    final found = await questions.findById(id);
    expect(found?.answerLatex, '1');
  });

  test('searches by keyword', () async {
    await questions.create(promptLatex: '极限计算题', answerLatex: '1');
    await questions.create(promptLatex: '矩阵求逆', answerLatex: 'A^{-1}');

    final result = await questions.list(keyword: '矩阵');
    expect(result, hasLength(1));
    expect(result.single.promptLatex, '矩阵求逆');
  });

  test('filters starred questions', () async {
    final id = await questions.create(promptLatex: '重点题');
    await questions.create(promptLatex: '普通题');
    await questions.setStarred(id, true);

    final starred = await questions.list(onlyStarred: true);
    expect(starred, hasLength(1));
    expect(starred.single.id, id);
  });

  test('soft delete and restore', () async {
    final id = await questions.create(promptLatex: '待删除');
    await questions.softDelete(id);

    expect(await questions.list(), isEmpty);
    final deleted = await questions.list(includeDeleted: true);
    expect(deleted, hasLength(1));
    expect(deleted.single.isDeleted, isTrue);
    expect(await questions.count(), 0);

    await questions.restore(id);
    expect(await questions.list(), hasLength(1));
  });

  test('replaces knowledge links', () async {
    final first = await createPoint();
    final id = await questions.create(
      promptLatex: '题目',
      knowledgeNodeIds: [first],
    );

    final second = await knowledge.createNode(
      parentId: (await knowledge.loadTree()).firstWhere((n) => n.level == 2).id,
      name: '洛必达法则',
    );
    await questions.setKnowledge(id, [second.id]);

    final found = await questions.findById(id);
    expect(found?.knowledgeNodeIds, [second.id]);
  });

  test('recent returns newest non-deleted questions', () async {
    final old = await questions.create(promptLatex: 'old');
    await Future<void>.delayed(const Duration(milliseconds: 2));
    final newest = await questions.create(promptLatex: 'newest');
    await Future<void>.delayed(const Duration(milliseconds: 2));
    final latest = await questions.create(promptLatex: 'latest');
    await questions.softDelete(newest);

    final recent = await questions.recent(limit: 2);
    expect(recent.map((question) => question.id), [latest, old]);
  });

  test('batch star, soft delete, restore and purge', () async {
    final ids = <String>[
      await questions.create(promptLatex: '批量一'),
      await questions.create(promptLatex: '批量二'),
      await questions.create(promptLatex: '批量三'),
    ];

    await questions.setStarredMany(ids, true);
    expect(await questions.list(onlyStarred: true), hasLength(3));

    await questions.softDeleteMany(ids);
    expect(await questions.list(), isEmpty);
    expect(await questions.list(includeDeleted: true), hasLength(3));
    expect(await questions.count(), 0);

    await questions.restoreMany(ids);
    expect(await questions.list(), hasLength(3));

    final purged = await questions.purgeMany(ids);
    expect(purged, 3);
    expect(await questions.list(includeDeleted: true), isEmpty);
    expect(await db.select(db.reviewCards).get(), isEmpty);
  });

  test('rejects invalid knowledge id', () async {
    await expectLater(
      questions.create(
        promptLatex: '题目',
        knowledgeNodeIds: ['not-exist'],
      ),
      throwsA(isA<AppError>()),
    );
  });
}
