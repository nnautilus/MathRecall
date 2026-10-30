import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../app/question_providers.dart';
import '../../app/review_providers.dart';
import '../widgets/math_text.dart';
import 'question_detail_page.dart';
import 'review_session_page.dart';
import '../../core/ui/app_snack_bar.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.watch(questionCountProvider);
    final due = ref.watch(dueCountProvider);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
        children: [
          Text('MathRecall', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 4),
          Text(
            '今天先复习，再录新题',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _MetricCard(
                  label: '今日待复习',
                  value: _valueOf(due),
                  icon: Icons.event_repeat,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MetricCard(
                  label: '错题总数',
                  value: _valueOf(questions),
                  icon: Icons.menu_book_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Expanded(
                child: _MetricCard(
                  label: '已掌握',
                  value: '--',
                  icon: Icons.check_circle_outline,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _MetricCard(
                  label: '待加强',
                  value: '--',
                  icon: Icons.priority_high,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Card(
            child: ListTile(
              leading: const Icon(Icons.play_circle_outline),
              title: const Text('继续复习'),
              subtitle: Text(_valueOf(due) == '0' ? '今天没有到期题目' : '今日还有 ${_valueOf(due)} 道到期'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _continueReview(context, ref),
            ),
          ),
          const SizedBox(height: 8),
          const _RecentQuestionsCard(),
        ],
      ),
    );
  }

  static String _valueOf(AsyncValue<int> value) {
    return value.when(
      data: (data) => '$data',
      loading: () => '--',
      error: (error, stackTrace) => '--',
    );
  }

  Future<void> _continueReview(BuildContext context, WidgetRef ref) async {
    final count = await ref.read(reviewRepositoryProvider).dueCount(
          DateTime.now().toUtc().millisecondsSinceEpoch,
        );
    if (!context.mounted) return;
    if (count == 0) {
      ScaffoldMessenger.of(context).showMessage('今天没有到期题目');
      return;
    }
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ReviewSessionPage()),
    );
    ref.invalidate(dueCountProvider);
  }
}

class _RecentQuestionsCard extends ConsumerWidget {
  const _RecentQuestionsCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recent = ref.watch(recentQuestionsProvider);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.inbox_outlined),
              title: const Text('最近录入'),
              trailing: Text(
                '最近 3 条',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            recent.when(
              loading: () => const Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: LinearProgressIndicator(),
              ),
              error: (error, _) => Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Text('加载失败：$error'),
              ),
              data: (items) {
                if (items.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
                    child: Text('还没有录入，点击右下角“录题”开始'),
                  );
                }
                return Column(
                  children: [
                    for (final question in items)
                      ListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        title: MathText(
                          question.promptLatex,
                          maxLines: 1,
                        ),
                        subtitle: question.knowledgeNames.isEmpty
                            ? null
                            : Text(
                                question.knowledgeNames.join('、'),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                        trailing: question.isStarred
                            ? const Icon(
                                Icons.star,
                                size: 18,
                                color: Colors.amber,
                              )
                            : null,
                        onTap: () async {
                          ref.invalidate(
                            questionDetailProvider(question.id),
                          );
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => QuestionDetailPage(
                                questionId: question.id,
                              ),
                            ),
                          );
                          ref.invalidate(recentQuestionsProvider);
                          ref.invalidate(questionCountProvider);
                          ref.invalidate(dueCountProvider);
                        },
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: colors.primary),
            const SizedBox(height: 12),
            Text(value, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
