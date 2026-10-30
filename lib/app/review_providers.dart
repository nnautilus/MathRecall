import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/review.dart';
import '../domain/repositories/review_repository.dart';
import '../infrastructure/repositories/review_repository_impl.dart';
import '../infrastructure/review/fsrs_scheduler.dart';
import 'providers.dart';

final reviewSchedulerProvider = Provider<ReviewScheduler>(
  (ref) => FsrsSchedulerAdapter(),
);

final reviewRepositoryProvider = Provider<ReviewRepository>(
  (ref) => ReviewRepositoryImpl(
    ref.watch(databaseProvider),
    ref.watch(reviewSchedulerProvider),
  ),
);

final dueQueueProvider = FutureProvider<List<ReviewQueueItem>>((ref) {
  final now = DateTime.now().toUtc().millisecondsSinceEpoch;
  return ref.watch(reviewRepositoryProvider).dueQueue(now);
});

final reviewHistoryCountProvider = FutureProvider<int>(
  (ref) => ref.watch(reviewRepositoryProvider).historyCount(),
);
