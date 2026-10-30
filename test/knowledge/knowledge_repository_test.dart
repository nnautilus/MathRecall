import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mathrecall/core/errors/app_error.dart';
import 'package:mathrecall/infrastructure/database/app_database.dart';
import 'package:mathrecall/infrastructure/repositories/knowledge_repository_impl.dart';

void main() {
  late AppDatabase db;
  late KnowledgeRepositoryImpl repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = KnowledgeRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('creates three-level tree', () async {
    final subject = await repo.createNode(name: '高等数学');
    final chapter = await repo.createNode(parentId: subject.id, name: '极限与连续');
    final point = await repo.createNode(parentId: chapter.id, name: '等价无穷小');

    expect(subject.level, 1);
    expect(chapter.level, 2);
    expect(point.level, 3);
    expect((await repo.loadTree()).length, 3);
  });

  test('rejects duplicate sibling names', () async {
    await repo.createNode(name: '高等数学');
    await expectLater(
      repo.createNode(name: '高等数学'),
      throwsA(isA<AppError>()),
    );
  });

  test('rejects moving a node under its descendant', () async {
    final subject = await repo.createNode(name: '高等数学');
    final chapter = await repo.createNode(parentId: subject.id, name: '极限');
    await expectLater(
      repo.moveNode(subject.id, chapter.id),
      throwsA(isA<AppError>()),
    );
  });

  test('moves knowledge point to another chapter', () async {
    final subject1 = await repo.createNode(name: '高等数学');
    final chapter1 = await repo.createNode(parentId: subject1.id, name: '极限');
    final point = await repo.createNode(parentId: chapter1.id, name: '等价无穷小');
    final subject2 = await repo.createNode(name: '线性代数');
    final chapter2 = await repo.createNode(parentId: subject2.id, name: '矩阵');

    await repo.moveNode(point.id, chapter2.id);
    final nodes = await repo.loadTree();
    final moved = nodes.firstWhere((n) => n.id == point.id);
    expect(moved.parentId, chapter2.id);
    expect(moved.level, 3);
  });

  test('deactivating a node cascades to descendants', () async {
    final subject = await repo.createNode(name: '高等数学');
    final chapter = await repo.createNode(parentId: subject.id, name: '极限');
    await repo.createNode(parentId: chapter.id, name: '等价无穷小');

    await repo.setActive(subject.id, false);
    final nodes = await repo.loadTree();
    expect(nodes.every((n) => !n.isActive), isTrue);
  });

  test('tags are unique and can be deleted', () async {
    final tag = await repo.createTag('易错');
    await expectLater(repo.createTag('易错'), throwsA(isA<AppError>()));
    expect((await repo.listTags()).length, 1);
    await repo.deleteTag(tag.id);
    expect(await repo.listTags(), isEmpty);
  });
}
