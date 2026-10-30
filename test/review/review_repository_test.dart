import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mathrecall/core/errors/app_error.dart';
import 'package:mathrecall/domain/entities/review.dart';
import 'package:mathrecall/infrastructure/database/app_database.dart';
import 'package:mathrecall/infrastructure/repositories/question_repository_impl.dart';
import 'package:mathrecall/infrastructure/repositories/review_repository_impl.dart';
import 'package:mathrecall/infrastructure/review/fsrs_scheduler.dart';

void main() {
  late AppDatabase db;
  late QuestionRepositoryImpl questions;
  late ReviewRepositoryImpl reviews;
  int nowMs() => DateTime.now().toUtc().millisecondsSinceEpoch;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    questions = QuestionRepositoryImpl(db);
    reviews = ReviewRepositoryImpl(db, FsrsSchedulerAdapter());
  });

  tearDown(() async {
    await db.close();
  });

  test('new question gets a due card and appears in queue', () async {
    await questions.create(promptLatex: '题目一');
    await questions.create(promptLatex: '题目二');

    final now = nowMs();
    final queue = await reviews.dueQueue(now);
    expect(queue, hasLength(2));
    expect(queue.first.promptLatex, isNotEmpty);
    expect(await reviews.dueCount(now), 2);
  });

  test('submitReview updates card and writes append-only log', () async {
    final id = await questions.create(promptLatex: '极限题');
    final now = nowMs();
    final queue = await reviews.dueQueue(now);
    final card = queue.single.card;

    await reviews.submitReview(
      card: card,
      rating: ReviewRating.good,
      nowMs: now,
      durationMs: 1200,
      independent: true,
    );

    final updated = await reviews.cardOf(id);
    expect(updated?.reps, 1);
    expect(updated?.dueAt, greaterThan(now));
    expect(updated?.state, 1);
    expect(updated?.step, 1);

    final logs = await db.select(db.reviewLogs).get();
    expect(logs, hasLength(1));
    expect(logs.single.rating, 3);
    expect(logs.single.kind, 'review');
    expect(logs.single.independent, isTrue);
    expect(logs.single.durationMs, 1200);
    expect(await reviews.dueCount(now), 0);
  });

  test('soft-deleted question is excluded from due count and queue', () async {
    final id = await questions.create(promptLatex: '待删除题');
    final now = nowMs();
    expect(await reviews.dueCount(now), 1);
    expect(await reviews.dueQueue(now), hasLength(1));

    await questions.softDelete(id);

    expect(await reviews.dueCount(now), 0);
    expect(await reviews.dueQueue(now), isEmpty);
  });

  test('submit is idempotent with requestId', () async {
    await questions.create(promptLatex: '幂等题');
    final now = nowMs();
    final card = (await reviews.dueQueue(now)).single.card;

    await reviews.submitReview(
      card: card,
      rating: ReviewRating.good,
      nowMs: now,
      requestId: 'req-1',
    );
    await reviews.submitReview(
      card: card,
      rating: ReviewRating.good,
      nowMs: now + 1000,
      requestId: 'req-1',
    );

    expect((await db.select(db.reviewLogs).get()), hasLength(1));
    expect((await reviews.cardOf(card.questionId))?.reps, 1);
  });

  test('submit fails when card is missing and writes no log', () async {
    final id = await questions.create(promptLatex: '无卡题');
    final now = nowMs();
    final card = (await reviews.dueQueue(now)).single.card;
    await (db.delete(db.reviewCards)..where((t) => t.questionId.equals(id))).go();

    await expectLater(
      reviews.submitReview(
        card: card,
        rating: ReviewRating.good,
        nowMs: now,
      ),
      throwsA(isA<AppError>()),
    );
    expect(await db.select(db.reviewLogs).get(), isEmpty);
  });

  test('persists direct evidence fields', () async {
    await questions.create(promptLatex: '直证题');
    final now = nowMs();
    final card = (await reviews.dueQueue(now)).single.card;

    await reviews.submitReview(
      card: card,
      rating: ReviewRating.hard,
      nowMs: now,
      usedHint: true,
      viewedAnswer: true,
      independent: false,
      stuckNodeIds: const ['node-1'],
      errorType: '计算',
    );

    final log = (await db.select(db.reviewLogs).get()).single;
    expect(log.usedHint, isTrue);
    expect(log.viewedAnswer, isTrue);
    expect(log.independent, isFalse);
    expect(log.stuckNodeIdsJson, contains('node-1'));
    expect(log.errorType, '计算');
  });

  test('skip writes a log but leaves the card unchanged', () async {
    final id = await questions.create(promptLatex: '跳过题');
    final cardBefore = await reviews.cardOf(id);

    await reviews.skip(questionId: id, nowMs: nowMs(), durationMs: 500);

    final cardAfter = await reviews.cardOf(id);
    expect(cardAfter?.dueAt, cardBefore?.dueAt);
    expect(cardAfter?.reps, cardBefore?.reps);

    final logs = await db.select(db.reviewLogs).get();
    expect(logs.single.kind, 'skip');
    expect(logs.single.rating, isNull);
    expect(await reviews.historyCount(), 1);
  });
}
