import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../app/providers.dart';
import '../../app/review_providers.dart';
import '../../core/errors/app_error.dart';
import '../../domain/entities/review.dart';
import '../../core/ui/app_snack_bar.dart';
import '../widgets/math_text.dart';

class ReviewSessionPage extends ConsumerStatefulWidget {
  const ReviewSessionPage({super.key});

  @override
  ConsumerState<ReviewSessionPage> createState() => _ReviewSessionPageState();
}

class _ReviewSessionPageState extends ConsumerState<ReviewSessionPage> {
  static const _errorTypes = ['审题', '计算', '概念', '方法', '其他'];

  List<ReviewQueueItem> _items = const [];
  int _index = 0;
  bool _loading = true;
  bool _showAnswer = false;
  bool _viewedAnswer = false;
  bool _usedHint = false;
  bool _busy = false;
  DateTime _shownAt = DateTime.now();
  final Set<String> _stuckNodeIds = {};
  String? _errorType;
  String _requestId = const Uuid().v4();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final items = await ref.read(reviewRepositoryProvider).dueQueue(
          DateTime.now().toUtc().millisecondsSinceEpoch,
        );
    if (!mounted) return;
    setState(() {
      _items = items;
      _loading = false;
      _shownAt = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _loading || _index >= _items.length
              ? '复习'
              : '复习 ${_index + 1}/${_items.length}',
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _index >= _items.length
              ? _doneView()
              : _questionView(_items[_index]),
    );
  }

  Widget _doneView() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle_outline, size: 64, color: Colors.green),
          const SizedBox(height: 12),
          const Text('本轮复习完成'),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('返回'),
          ),
        ],
      ),
    );
  }

  Widget _questionView(ReviewQueueItem item) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: [
        if (item.knowledgeNames.isNotEmpty)
          Wrap(
            spacing: 8,
            children: item.knowledgeNames
                .map((name) => Chip(label: Text(name)))
                .toList(),
          ),
        const SizedBox(height: 8),
        MathText(
          item.promptLatex,
          style: const TextStyle(fontSize: 18, height: 1.5),
        ),
        if (_usedHint && item.hintLatex != null) ...[
          const SizedBox(height: 16),
          Card(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text('提示：${item.hintLatex}'),
            ),
          ),
        ],
        if (_showAnswer) ...[
          const SizedBox(height: 20),
          Text('答案', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          MathText(
            item.answerLatex ?? '（未填写）',
            style: const TextStyle(fontSize: 16),
          ),
          if (item.solutionLatex != null) ...[
            const SizedBox(height: 16),
            Text('解法', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            MathText(item.solutionLatex!, style: const TextStyle(height: 1.5)),
          ],
        ],
        const SizedBox(height: 16),
        _evidenceSection(item),
        const SizedBox(height: 16),
        Row(
          children: [
            if (item.hintLatex != null)
              OutlinedButton.icon(
                onPressed: _busy || _usedHint
                    ? null
                    : () => setState(() => _usedHint = true),
                icon: const Icon(Icons.lightbulb_outline),
                label: const Text('提示'),
              ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _busy || _showAnswer
                    ? null
                    : () => setState(() {
                          _showAnswer = true;
                          _viewedAnswer = true;
                        }),
                icon: const Icon(Icons.visibility_outlined),
                label: const Text('显示答案'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _ratingButtons(item),
        const SizedBox(height: 12),
        TextButton(
          onPressed: _busy ? null : _skip,
          child: const Text('跳过（不计入调度）'),
        ),
      ],
    );
  }

  Widget _evidenceSection(ReviewQueueItem item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (item.knowledgeNodeIds.isNotEmpty) ...[
          Text('卡住的知识点（可选）',
              style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              for (var i = 0; i < item.knowledgeNodeIds.length; i++)
                FilterChip(
                  label: Text(
                    i < item.knowledgeNames.length
                        ? item.knowledgeNames[i]
                        : item.knowledgeNodeIds[i],
                  ),
                  selected: _stuckNodeIds.contains(item.knowledgeNodeIds[i]),
                  onSelected: (selected) {
                    setState(() {
                      final id = item.knowledgeNodeIds[i];
                      if (selected) {
                        _stuckNodeIds.add(id);
                      } else {
                        _stuckNodeIds.remove(id);
                      }
                    });
                  },
                ),
            ],
          ),
          const SizedBox(height: 12),
        ],
        Text('错误类型（可选）', style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: _errorTypes
              .map(
                (type) => ChoiceChip(
                  label: Text(type),
                  selected: _errorType == type,
                  onSelected: (selected) => setState(
                    () => _errorType = selected ? type : null,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _ratingButtons(ReviewQueueItem item) {
    final options = [
      (ReviewRating.again, '忘记', Colors.red),
      (ReviewRating.hard, '困难', Colors.orange),
      (ReviewRating.good, '良好', Colors.blue),
      (ReviewRating.easy, '容易', Colors.green),
    ];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        final (rating, label, color) = option;
        return SizedBox(
          width: (MediaQuery.sizeOf(context).width - 32 - 24) / 2,
          child: FilledButton(
            style: FilledButton.styleFrom(backgroundColor: color),
            onPressed: _busy ? null : () => _rate(item, rating),
            child: Text(label),
          ),
        );
      }).toList(),
    );
  }

  Future<void> _rate(ReviewQueueItem item, ReviewRating rating) async {
    setState(() => _busy = true);
    final now = DateTime.now().toUtc().millisecondsSinceEpoch;
    var saved = false;
    try {
      await ref.read(reviewRepositoryProvider).submitReview(
            card: item.card,
            rating: rating,
            nowMs: now,
            durationMs: now - _shownAt.millisecondsSinceEpoch,
            usedHint: _usedHint,
            viewedAnswer: _viewedAnswer,
            independent: !_usedHint && !_viewedAnswer,
            stuckNodeIds: _stuckNodeIds.toList(),
            errorType: _errorType,
            requestId: _requestId,
          );
      saved = true;
    } on AppError catch (error) {
      _snack(error.userMessage);
    } catch (error) {
      _snack('保存失败：$error');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
    if (saved) {
      _next();
    }
  }

  Future<void> _skip() async {
    final item = _items[_index];
    setState(() => _busy = true);
    var saved = false;
    try {
      await ref.read(reviewRepositoryProvider).skip(
            questionId: item.card.questionId,
            nowMs: DateTime.now().toUtc().millisecondsSinceEpoch,
            durationMs: DateTime.now().difference(_shownAt).inMilliseconds,
            requestId: _requestId,
          );
      saved = true;
    } catch (error) {
      _snack('跳过失败：$error');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
    if (saved) {
      _next();
    }
  }

  void _next() {
    if (!mounted) return;
    setState(() {
      _index++;
      _showAnswer = false;
      _viewedAnswer = false;
      _usedHint = false;
      _stuckNodeIds.clear();
      _errorType = null;
      _requestId = const Uuid().v4();
      _shownAt = DateTime.now();
    });
    if (_index >= _items.length) {
      ref.invalidate(dueCountProvider);
      ref.invalidate(reviewHistoryCountProvider);
    }
  }

  void _snack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showMessage(message);
  }
}
