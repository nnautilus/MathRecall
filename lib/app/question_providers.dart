import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/question.dart';
import '../domain/repositories/question_repository.dart';
import '../infrastructure/repositories/question_repository_impl.dart';
import 'providers.dart';

class QuestionFilter {
  const QuestionFilter({
    this.keyword = '',
    this.onlyStarred = false,
    this.includeDeleted = false,
    this.knowledgeNodeId,
  });

  final String keyword;
  final bool onlyStarred;
  final bool includeDeleted;
  final String? knowledgeNodeId;

  QuestionFilter copyWith({
    String? keyword,
    bool? onlyStarred,
    bool? includeDeleted,
    String? knowledgeNodeId,
    bool clearKnowledge = false,
  }) {
    return QuestionFilter(
      keyword: keyword ?? this.keyword,
      onlyStarred: onlyStarred ?? this.onlyStarred,
      includeDeleted: includeDeleted ?? this.includeDeleted,
      knowledgeNodeId:
          clearKnowledge ? null : (knowledgeNodeId ?? this.knowledgeNodeId),
    );
  }
}

class QuestionFilterNotifier extends Notifier<QuestionFilter> {
  @override
  QuestionFilter build() => const QuestionFilter();

  void setKeyword(String value) => state = state.copyWith(keyword: value);

  void toggleStarred() =>
      state = state.copyWith(onlyStarred: !state.onlyStarred);

  void toggleDeleted() =>
      state = state.copyWith(includeDeleted: !state.includeDeleted);
}

final questionFilterProvider =
    NotifierProvider<QuestionFilterNotifier, QuestionFilter>(
  QuestionFilterNotifier.new,
);

final questionRepositoryProvider = Provider<QuestionRepository>(
  (ref) => QuestionRepositoryImpl(ref.watch(databaseProvider)),
);

final questionListProvider = FutureProvider<List<Question>>((ref) {
  final filter = ref.watch(questionFilterProvider);
  return ref.watch(questionRepositoryProvider).list(
        keyword: filter.keyword,
        onlyStarred: filter.onlyStarred,
        includeDeleted: filter.includeDeleted,
        knowledgeNodeId: filter.knowledgeNodeId,
      );
});

final questionDetailProvider =
    FutureProvider.family<Question?, String>((ref, id) {
  return ref.watch(questionRepositoryProvider).findById(id);
});

final recentQuestionsProvider = FutureProvider<List<Question>>((ref) {
  return ref.watch(questionRepositoryProvider).recent(limit: 3);
});
