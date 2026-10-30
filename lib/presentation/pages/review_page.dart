import 'package:flutter/material.dart';

import '../../app/providers.dart';
import '../../app/review_providers.dart';
import 'review_session_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/ui/app_snack_bar.dart';

class ReviewPage extends ConsumerWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final due = ref.watch(dueCountProvider);
    final history = ref.watch(reviewHistoryCountProvider);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
        children: [
          Text('复习', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 4),
          Text(
            '按 FSRS-6 调度，到期后逐题自评',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(
                    Icons.event_repeat,
                    size: 56,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    due.maybeWhen(
                      data: (count) => '$count',
                      orElse: () => '--',
                    ),
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const Text('今日到期'),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () => _start(context, ref),
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('开始复习'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.history),
              title: const Text('复习历史'),
              subtitle: Text(
                history.maybeWhen(
                  data: (count) => '已记录 $count 次',
                  orElse: () => '加载中…',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _start(BuildContext context, WidgetRef ref) async {
    final items = await ref.read(reviewRepositoryProvider).dueQueue(
          DateTime.now().toUtc().millisecondsSinceEpoch,
        );
    if (!context.mounted) return;
    if (items.isEmpty) {
      ScaffoldMessenger.of(context).showMessage('今天没有到期题目');
      return;
    }
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ReviewSessionPage()),
    );
    ref.invalidate(dueCountProvider);
    ref.invalidate(reviewHistoryCountProvider);
  }
}
