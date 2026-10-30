import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mathrecall/infrastructure/database/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test('schema version is 4', () {
    expect(db.schemaVersion, 4);
  });

  test('insert question and soft delete hides it from counts', () async {
    await db.into(db.questions).insert(
          QuestionsCompanion.insert(
            id: 'q1',
            promptLatex: r'$\lim_{x\to 0}\frac{\sin x}{x}$',
          ),
        );
    expect(await db.countQuestions(), 1);

    await (db.update(db.questions)..where((t) => t.id.equals('q1'))).write(
      const QuestionsCompanion(deletedAt: Value(123456789)),
    );
    expect(await db.countQuestions(), 0);
  });

  test('foreign key is enforced for question-knowledge links', () async {
    await expectLater(
      db.into(db.questionKnowledge).insert(
            QuestionKnowledgeCompanion.insert(
              questionId: 'missing-question',
              nodeId: 'missing-node',
            ),
          ),
      throwsA(anything),
    );
  });
}
