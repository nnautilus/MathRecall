import '../entities/review.dart';

/// 复习数据访问端口。
abstract interface class ReviewRepository {
  Future<List<ReviewQueueItem>> dueQueue(int nowMs, {int limit = 100});

  Future<ReviewCardState?> cardOf(String questionId);

  Future<int> dueCount(int nowMs);

  /// 评分：更新卡片 + 插入 review_logs（同一事务）。
  /// [requestId] 用于幂等：同一 id 重复提交不会产生第二条日志。
  Future<void> submitReview({
    required ReviewCardState card,
    required ReviewRating rating,
    required int nowMs,
    int? durationMs,
    bool usedHint = false,
    bool viewedAnswer = false,
    bool independent = false,
    List<String> stuckNodeIds = const [],
    String? errorType,
    String? requestId,
  });

  /// 跳过：只记日志，不改卡片。
  Future<void> skip({
    required String questionId,
    required int nowMs,
    int? durationMs,
    String? requestId,
  });

  Future<int> historyCount();
}
