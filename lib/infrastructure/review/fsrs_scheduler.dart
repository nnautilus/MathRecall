import 'package:fsrs/fsrs.dart' as fsrs;

import '../../domain/entities/review.dart';

/// FSRS-6 适配器：把领域卡片映射到 `fsrs` 包。
///
/// 使用标准 learning/relearning steps（1m/10m），关闭 fuzzing 以保证可复现。
class FsrsSchedulerAdapter implements ReviewScheduler {
  FsrsSchedulerAdapter({fsrs.Scheduler? scheduler})
      : _scheduler = scheduler ??
            fsrs.Scheduler(
              desiredRetention: 0.9,
              learningSteps: const [
                Duration(minutes: 1),
                Duration(minutes: 10),
              ],
              relearningSteps: const [Duration(minutes: 10)],
              enableFuzzing: false,
            );

  final fsrs.Scheduler _scheduler;

  @override
  ReviewCardState initial({required String questionId, required int nowMs}) {
    return ReviewCardState(
      questionId: questionId,
      state: fsrs.State.learning.value,
      step: 0,
      dueAt: nowMs,
      reps: 0,
      lapses: 0,
    );
  }

  @override
  ReviewCardState review({
    required ReviewCardState card,
    required ReviewRating rating,
    required int nowMs,
  }) {
    final fsrsCard = fsrs.Card(
      cardId: 0,
      state: fsrs.State.fromValue(card.state),
      step: card.step,
      stability: card.stability,
      difficulty: card.difficulty,
      due: DateTime.fromMillisecondsSinceEpoch(card.dueAt, isUtc: true),
      lastReview: card.lastReviewAt == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(card.lastReviewAt!, isUtc: true),
    );
    final nowUtc = DateTime.fromMillisecondsSinceEpoch(nowMs, isUtc: true);
    final result = _scheduler.reviewCard(
      fsrsCard,
      fsrs.Rating.fromValue(rating.value),
      reviewDateTime: nowUtc,
    );
    final reviewed = result.card;
    final scheduledDays = reviewed.due.difference(nowUtc).inDays;
    final lastReviewAt = card.lastReviewAt;
    final elapsedDays = lastReviewAt == null
        ? 0
        : nowUtc
            .difference(
              DateTime.fromMillisecondsSinceEpoch(lastReviewAt, isUtc: true),
            )
            .inDays;

    return ReviewCardState(
      questionId: card.questionId,
      state: reviewed.state.value,
      step: reviewed.step,
      dueAt: reviewed.due.millisecondsSinceEpoch,
      stability: reviewed.stability,
      difficulty: reviewed.difficulty,
      reps: card.reps + 1,
      lapses: card.lapses +
          (rating == ReviewRating.again &&
                  card.state == fsrs.State.review.value
              ? 1
              : 0),
      elapsedDays: elapsedDays < 0 ? 0 : elapsedDays,
      scheduledDays: scheduledDays < 0 ? 0 : scheduledDays,
      lastReviewAt: nowMs,
    );
  }
}
