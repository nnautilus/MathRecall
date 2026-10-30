import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../app/question_providers.dart';
import '../../domain/entities/question.dart';
import '../widgets/math_text.dart';
import 'question_edit_page.dart';

class QuestionDetailPage extends ConsumerWidget {
  const QuestionDetailPage({super.key, required this.questionId});

  final String questionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(questionDetailProvider(questionId));
    return Scaffold(
      appBar: AppBar(title: const Text('题目详情')),
      body: detail.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('加载失败：$error')),
        data: (question) {
          if (question == null) {
            return const Center(child: Text('题目不存在'));
          }
          return _DetailBody(question: question);
        },
      ),
    );
  }
}

class _DetailBody extends ConsumerWidget {
  const _DetailBody({required this.question});

  final Question question;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (question.isDeleted)
          Card(
            color: Theme.of(context).colorScheme.errorContainer,
            child: ListTile(
              title: const Text('该题已在回收站'),
              trailing: TextButton(
                onPressed: () async {
                  await ref.read(questionRepositoryProvider).restore(question.id);
                  ref.invalidate(questionDetailProvider(question.id));
                  ref.invalidate(questionListProvider);
                  ref.invalidate(questionCountProvider);
                  ref.invalidate(dueCountProvider);
                  ref.invalidate(recentQuestionsProvider);
                },
                child: const Text('恢复'),
              ),
            ),
          ),
        Row(
          children: [
            Expanded(
              child: Text('题干', style: Theme.of(context).textTheme.titleMedium),
            ),
            if (!question.isDeleted) ...[
              IconButton(
                onPressed: () async {
                  await ref
                      .read(questionRepositoryProvider)
                      .setStarred(question.id, !question.isStarred);
                  ref.invalidate(questionDetailProvider(question.id));
                  ref.invalidate(questionListProvider);
                },
                icon: Icon(
                  question.isStarred ? Icons.star : Icons.star_border,
                  color: question.isStarred ? Colors.amber : null,
                ),
              ),
              IconButton(
                tooltip: '编辑',
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => QuestionEditPage(question: question),
                    ),
                  );
                  ref.invalidate(questionDetailProvider(question.id));
                  ref.invalidate(questionListProvider);
                  ref.invalidate(questionCountProvider);
                  ref.invalidate(dueCountProvider);
                },
                icon: const Icon(Icons.edit_outlined),
              ),
            ],
          ],
        ),
        MathText(question.promptLatex, style: const TextStyle(fontSize: 16)),
        if (question.answerLatex != null) ...[
          const SizedBox(height: 16),
          Text('答案', style: Theme.of(context).textTheme.titleMedium),
          MathText(question.answerLatex!),
        ],
        if (question.solutionLatex != null) ...[
          const SizedBox(height: 16),
          Text('正确解法', style: Theme.of(context).textTheme.titleMedium),
          MathText(question.solutionLatex!),
        ],
        if (question.knowledgeNames.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text('知识点', style: Theme.of(context).textTheme.titleMedium),
          Wrap(
            spacing: 8,
            children: question.knowledgeNames
                .map((name) => Chip(label: Text(name)))
                .toList(),
          ),
        ],
        if (question.tagNames.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text('标签', style: Theme.of(context).textTheme.titleMedium),
          Wrap(
            spacing: 8,
            children: question.tagNames
                .map((name) => Chip(label: Text(name)))
                .toList(),
          ),
        ],
        const SizedBox(height: 16),
        Text(
          '难度：${question.difficulty ?? '未设置'}'
          '${question.sourceText == null ? '' : ' · 来源：${question.sourceText}'}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 24),
        if (!question.isDeleted)
          OutlinedButton.icon(
            onPressed: () async {
              await ref.read(questionRepositoryProvider).softDelete(question.id);
              ref.invalidate(questionListProvider);
              ref.invalidate(questionCountProvider);
              ref.invalidate(dueCountProvider);
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.delete_outline),
            label: const Text('删除（可在回收站恢复）'),
          ),
      ],
    );
  }
}
