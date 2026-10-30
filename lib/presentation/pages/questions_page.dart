import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../app/providers.dart';
import '../../app/question_providers.dart';
import '../../domain/entities/question.dart';
import '../widgets/math_text.dart';
import 'question_detail_page.dart';
import 'question_edit_page.dart';
import '../../core/ui/app_snack_bar.dart';

class QuestionsPage extends ConsumerStatefulWidget {
  const QuestionsPage({super.key});

  @override
  ConsumerState<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends ConsumerState<QuestionsPage> {
  final _searchController = TextEditingController();
  bool _selectionMode = false;
  final Set<String> _selectedIds = {};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(questionFilterProvider);
    final questions = ref.watch(questionListProvider);
    final items = questions.when(
      data: (data) => data,
      loading: () => const <Question>[],
      error: (_, _) => const <Question>[],
    );

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 8, 4),
            child: _selectionMode
                ? _selectionHeader(items)
                : _normalHeader(filter),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: '搜索题干、答案或解法',
                border: OutlineInputBorder(),
                isDense: true,
              ),
              onChanged: (value) {
                _exitSelection();
                ref
                    .read(questionFilterProvider.notifier)
                    .setKeyword(value);
              },
            ),
          ),
          Expanded(
            child: questions.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('加载失败：$error')),
              data: (items) {
                if (items.isEmpty) {
                  return _emptyView(filter);
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 96),
                  itemCount: items.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final question = items[index];
                    return _QuestionCard(
                      question: question,
                      selectionMode: _selectionMode,
                      selected: _selectedIds.contains(question.id),
                      onTap: () {
                        if (_selectionMode) {
                          _toggleSelection(question.id);
                        } else {
                          ref.invalidate(
                            questionDetailProvider(question.id),
                          );
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => QuestionDetailPage(
                                questionId: question.id,
                              ),
                            ),
                          );
                        }
                      },
                      onLongPress: () => _enterSelection(question.id),
                    );
                  },
                );
              },
            ),
          ),
          if (_selectionMode) _selectionBar(filter),
        ],
      ),
    );
  }

  Widget _normalHeader(QuestionFilter filter) {
    return Row(
      children: [
        Expanded(
          child: Text(
            filter.includeDeleted ? '回收站' : '错题本',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        IconButton(
          tooltip: '收藏筛选',
          onPressed: () {
            _exitSelection();
            ref.read(questionFilterProvider.notifier).toggleStarred();
          },
          icon: Icon(
            filter.onlyStarred ? Icons.star : Icons.star_outline,
            color: filter.onlyStarred ? Colors.amber : null,
          ),
        ),
        IconButton(
          tooltip: filter.includeDeleted ? '返回错题本' : '回收站',
          onPressed: () {
            _exitSelection();
            ref.read(questionFilterProvider.notifier).toggleDeleted();
          },
          icon: Icon(
            filter.includeDeleted
                ? Icons.delete_forever_outlined
                : Icons.delete_outline,
          ),
        ),
        IconButton(
          tooltip: '手动新增',
          onPressed: _openEditor,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  Widget _selectionHeader(List<Question> items) {
    final allSelected =
        items.isNotEmpty && items.every((item) => _selectedIds.contains(item.id));
    return Row(
      children: [
        IconButton(
          tooltip: '退出多选',
          onPressed: _exitSelection,
          icon: const Icon(Icons.close),
        ),
        Text('已选 ${_selectedIds.length}'),
        const Spacer(),
        TextButton(
          onPressed: () {
            setState(() {
              if (allSelected) {
                _selectedIds.clear();
              } else {
                _selectedIds
                  ..clear()
                  ..addAll(items.map((item) => item.id));
              }
            });
          },
          child: Text(allSelected ? '取消全选' : '全选'),
        ),
      ],
    );
  }

  Widget _selectionBar(QuestionFilter filter) {
    return Material(
      elevation: 8,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: OverflowBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: filter.includeDeleted
                ? [
                    TextButton.icon(
                      onPressed: _batchRestore,
                      icon: const Icon(Icons.restore),
                      label: const Text('恢复'),
                    ),
                    FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ),
                      onPressed: _batchPurge,
                      icon: const Icon(Icons.delete_forever),
                      label: const Text('彻底删除'),
                    ),
                  ]
                : [
                    TextButton.icon(
                      onPressed: () => _batchStar(true),
                      icon: const Icon(Icons.star),
                      label: const Text('收藏'),
                    ),
                    TextButton.icon(
                      onPressed: () => _batchStar(false),
                      icon: const Icon(Icons.star_border),
                      label: const Text('取消收藏'),
                    ),
                    FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ),
                      onPressed: _batchDelete,
                      icon: const Icon(Icons.delete_outline),
                      label: const Text('删除'),
                    ),
                  ],
          ),
        ),
      ),
    );
  }

  Widget _emptyView(QuestionFilter filter) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            filter.includeDeleted
                ? Icons.delete_outline
                : Icons.menu_book_outlined,
            size: 56,
            color: Colors.grey,
          ),
          const SizedBox(height: 12),
          Text(filter.includeDeleted ? '回收站是空的' : '还没有错题'),
          const SizedBox(height: 4),
          Text(
            filter.includeDeleted
                ? '删除的题目会出现在这里'
                : '点击右上角 + 手动新增，或从首页录题',
          ),
        ],
      ),
    );
  }

  void _enterSelection(String id) {
    setState(() {
      _selectionMode = true;
      _selectedIds.add(id);
    });
  }

  void _toggleSelection(String id) {
    setState(() {
      if (!_selectedIds.add(id)) {
        _selectedIds.remove(id);
      }
      if (_selectedIds.isEmpty) {
        _selectionMode = false;
      }
    });
  }

  void _exitSelection() {
    if (!_selectionMode && _selectedIds.isEmpty) return;
    setState(() {
      _selectionMode = false;
      _selectedIds.clear();
    });
  }

  Future<void> _batchStar(bool starred) async {
    if (_selectedIds.isEmpty) return;
    final ids = _selectedIds.toList();
    await ref.read(questionRepositoryProvider).setStarredMany(ids, starred);
    _afterMutation(ids);
  }

  Future<void> _batchDelete() async {
    if (_selectedIds.isEmpty) return;
    final ids = _selectedIds.toList();
    await ref.read(questionRepositoryProvider).softDeleteMany(ids);
    _afterMutation(ids);
    _snack('已移入回收站 ${ids.length} 道题');
  }

  Future<void> _batchRestore() async {
    if (_selectedIds.isEmpty) return;
    final ids = _selectedIds.toList();
    await ref.read(questionRepositoryProvider).restoreMany(ids);
    _afterMutation(ids);
    _snack('已恢复 ${ids.length} 道题');
  }

  Future<void> _batchPurge() async {
    if (_selectedIds.isEmpty) return;
    final count = _selectedIds.length;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('彻底删除 $count 道题？'),
        content: const Text('彻底删除后不可恢复，复习记录也会一并删除。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('彻底删除'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    final ids = _selectedIds.toList();
    await ref.read(questionRepositoryProvider).purgeMany(ids);
    _afterMutation(ids);
    _snack('已彻底删除 $count 道题');
  }

  void _afterMutation(List<String> ids) {
    for (final id in ids) {
      ref.invalidate(questionDetailProvider(id));
    }
    ref.invalidate(questionListProvider);
    ref.invalidate(questionCountProvider);
    ref.invalidate(dueCountProvider);
    ref.invalidate(recentQuestionsProvider);
    _exitSelection();
  }

  Future<void> _openEditor() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const QuestionEditPage()),
    );
    if (!mounted) return;
    ref.invalidate(questionListProvider);
    ref.invalidate(questionCountProvider);
    ref.invalidate(dueCountProvider);
    ref.invalidate(recentQuestionsProvider);
  }

  void _snack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showMessage(message);
  }
}

class _QuestionCard extends ConsumerWidget {
  const _QuestionCard({
    required this.question,
    required this.onTap,
    required this.onLongPress,
    required this.selectionMode,
    required this.selected,
  });

  final Question question;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final bool selectionMode;
  final bool selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meta = <String>[
      if (question.knowledgeNames.isNotEmpty) question.knowledgeNames.join('、'),
      if (question.difficulty != null) '难度 ${question.difficulty}',
    ].join(' · ');
    final isDeleted = question.isDeleted;

    return Slidable(
      // 状态变化时重建 Slidable，避免复用旧的动作栏。
      key: ValueKey('${question.id}-$isDeleted-${question.isStarred}'),
      enabled: !selectionMode,
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.5,
        children: isDeleted
            ? [
                SlidableAction(
                  onPressed: (_) => _restore(ref),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  icon: Icons.restore,
                  label: '恢复',
                  borderRadius: BorderRadius.circular(12),
                ),
                SlidableAction(
                  onPressed: (_) => _purge(context, ref),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete_forever,
                  label: '删除',
                  borderRadius: BorderRadius.circular(12),
                ),
              ]
            : [
                SlidableAction(
                  onPressed: (_) => _toggleStar(ref),
                  backgroundColor: Colors.amber.shade700,
                  foregroundColor: Colors.white,
                  icon: question.isStarred ? Icons.star_outline : Icons.star,
                  label: question.isStarred ? '取消收藏' : '收藏',
                  borderRadius: BorderRadius.circular(12),
                ),
                SlidableAction(
                  onPressed: (_) => _delete(ref, context),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete_outline,
                  label: '删除',
                  borderRadius: BorderRadius.circular(12),
                ),
              ],
      ),
      child: Card(
        color: selected
            ? Theme.of(context).colorScheme.primaryContainer
            : null,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          onLongPress: onLongPress,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 8, 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (selectionMode)
                  Padding(
                    padding: const EdgeInsets.only(right: 4, top: 2),
                    child: Checkbox(
                      value: selected,
                      onChanged: (_) => onTap(),
                    ),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MathText(
                        question.promptLatex,
                        maxLines: 2,
                      ),
                      if (meta.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text(
                          meta,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                      if (question.isDeleted)
                        Text(
                          '已删除（可在回收站恢复）',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ),
                if (question.isStarred)
                  const Padding(
                    padding: EdgeInsets.only(left: 4, top: 4),
                    child: Icon(Icons.star, size: 20, color: Colors.amber),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _toggleStar(WidgetRef ref) async {
    await ref
        .read(questionRepositoryProvider)
        .setStarred(question.id, !question.isStarred);
    _invalidate(ref);
  }

  Future<void> _delete(WidgetRef ref, BuildContext context) async {
    final repo = ref.read(questionRepositoryProvider);
    final messenger = ScaffoldMessenger.of(context);
    await repo.softDelete(question.id);
    _invalidate(ref);
    messenger.showMessage(
      '已移入回收站',
      action: SnackBarAction(
        label: '撤销',
        onPressed: () {
          repo.restore(question.id).then((_) => _invalidate(ref));
        },
      ),
    );
  }

  Future<void> _restore(WidgetRef ref) async {
    await ref.read(questionRepositoryProvider).restore(question.id);
    _invalidate(ref);
  }

  Future<void> _purge(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('彻底删除？'),
        content: const Text('彻底删除后不可恢复，复习记录也会一并删除。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('彻底删除'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref.read(questionRepositoryProvider).purgeMany([question.id]);
    _invalidate(ref);
  }

  void _invalidate(WidgetRef ref) {
    ref.invalidate(questionDetailProvider(question.id));
    ref.invalidate(questionListProvider);
    ref.invalidate(questionCountProvider);
    ref.invalidate(dueCountProvider);
    ref.invalidate(recentQuestionsProvider);
  }
}
