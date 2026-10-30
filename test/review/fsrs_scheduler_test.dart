import 'package:flutter_test/flutter_test.dart';
import 'package:mathrecall/domain/entities/review.dart';
import 'package:mathrecall/infrastructure/review/fsrs_scheduler.dart';

void main() {
  final scheduler = FsrsSchedulerAdapter();
  final now = DateTime.utc(2026, 1, 1).millisecondsSinceEpoch;

  test('initial card is learning with step 0 and due now', () {
    final card = scheduler.initial(questionId: 'q1', nowMs: now);
    expect(card.state, 1);
    expect(card.step, 0);
    expect(card.dueAt, now);
    expect(card.reps, 0);
    expect(card.lapses, 0);
    expect(card.stability, isNull);
  });

  test('again on new card stays learning and does not count lapse', () {
    final initial = scheduler.initial(questionId: 'q1', nowMs: now);
    final after = scheduler.review(
      card: initial,
      rating: ReviewRating.again,
      nowMs: now,
    );
    expect(after.state, 1);
    expect(after.step, 0);
    expect(after.dueAt, greaterThan(now));
    expect(after.lapses, 0);
    expect(after.reps, 1);
  });

  test('good on new card advances learning step', () {
    final initial = scheduler.initial(questionId: 'q1', nowMs: now);
    final after = scheduler.review(
      card: initial,
      rating: ReviewRating.good,
      nowMs: now,
    );
    expect(after.state, 1);
    expect(after.step, 1);
    expect(after.dueAt, greaterThan(now));
    expect(after.stability, isNotNull);
    expect(after.reps, 1);
  });

  test('easy graduates to review', () {
    final initial = scheduler.initial(questionId: 'q1', nowMs: now);
    final after = scheduler.review(
      card: initial,
      rating: ReviewRating.easy,
      nowMs: now,
    );
    expect(after.state, 2);
    expect(after.step, isNull);
    expect(after.dueAt, greaterThan(now));
  });

  test('again in review state counts lapse and enters relearning', () {
    final initial = scheduler.initial(questionId: 'q1', nowMs: now);
    final graduated = scheduler.review(
      card: initial,
      rating: ReviewRating.easy,
      nowMs: now,
    );
    final failed = scheduler.review(
      card: graduated,
      rating: ReviewRating.again,
      nowMs: now + 24 * 60 * 60 * 1000,
    );
    expect(failed.state, 3);
    expect(failed.lapses, 1);
  });
}
