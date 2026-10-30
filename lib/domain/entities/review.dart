/// 复习评分（与 FSRS 的 1–4 对应）。
enum ReviewRating {
  again(1),
  hard(2),
  good(3),
  easy(4);

  const ReviewRating(this.value);

  final int value;

  static ReviewRating fromValue(int value) {
    return switch (value) {
      1 => ReviewRating.again,
      2 => ReviewRating.hard,
      3 => ReviewRating.good,
      4 => ReviewRating.easy,
      _ => throw ArgumentError('invalid rating: $value'),
    };
  }
}

/// FSRS 卡片状态（与 review_cards 表一一对应）。
class ReviewCardState {
  const ReviewCardState({
    required this.questionId,
    required this.state,
    required this.dueAt,
    required this.reps,
    required this.lapses,
    this.step,
    this.stability,
    this.difficulty,
    this.elapsedDays = 0,
    this.scheduledDays = 0,
    this.lastReviewAt,
  });

  final String questionId;
  final int state;
  final int? step;
  final int dueAt;
  final int reps;
  final int lapses;
  final double? stability;
  final double? difficulty;
  final int elapsedDays;
  final int scheduledDays;
  final int? lastReviewAt;

  ReviewCardState copyWith({
    int? state,
    int? step,
    int? dueAt,
    int? reps,
    int? lapses,
    double? stability,
    double? difficulty,
    int? elapsedDays,
    int? scheduledDays,
    int? lastReviewAt,
  }) {
    return ReviewCardState(
      questionId: questionId,
      state: state ?? this.state,
      step: step ?? this.step,
      dueAt: dueAt ?? this.dueAt,
      reps: reps ?? this.reps,
      lapses: lapses ?? this.lapses,
      stability: stability ?? this.stability,
      difficulty: difficulty ?? this.difficulty,
      elapsedDays: elapsedDays ?? this.elapsedDays,
      scheduledDays: scheduledDays ?? this.scheduledDays,
      lastReviewAt: lastReviewAt ?? this.lastReviewAt,
    );
  }
}

/// 调度器端口：便于替换实现、做 py-fsrs 对拍。
abstract interface class ReviewScheduler {
  ReviewCardState initial({required String questionId, required int nowMs});

  ReviewCardState review({
    required ReviewCardState card,
    required ReviewRating rating,
    required int nowMs,
  });
}

/// 待复习条目（卡片 + 题目摘要）。
class ReviewQueueItem {
  const ReviewQueueItem({
    required this.card,
    required this.promptLatex,
    this.answerLatex,
    this.solutionLatex,
    this.hintLatex,
    this.knowledgeNames = const [],
    this.knowledgeNodeIds = const [],
  });

  final ReviewCardState card;
  final String promptLatex;
  final String? answerLatex;
  final String? solutionLatex;
  final String? hintLatex;
  final List<String> knowledgeNames;
  final List<String> knowledgeNodeIds;
}
