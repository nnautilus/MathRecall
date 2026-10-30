import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/knowledge_providers.dart';
import '../../domain/entities/knowledge_node.dart';
import '../../core/ui/app_snack_bar.dart';

class KnowledgePage extends ConsumerWidget {
  const KnowledgePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: const Text('知识点与标签')),
        body: const TabBarView(
          children: [
            _KnowledgeTab(),
            _TagsTab(),
          ],
        ),
        bottomNavigationBar: const TabBar(
          tabs: [
            Tab(text: '知识点'),
            Tab(text: '标签'),
          ],
        ),
      ),
    );
  }
}

class _KnowledgeTab extends ConsumerWidget {
  const _KnowledgeTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tree = ref.watch(knowledgeTreeProvider);
    return tree.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('加载失败：$error')),
      data: (nodes) {
        final flat = _flatten(nodes);
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'V1 不预置大纲，可自行建立科目/章节/知识点',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => _showAddDialog(context, ref, nodes),
                    icon: const Icon(Icons.add),
                    label: const Text('新增'),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: flat.isEmpty
                  ? const Center(child: Text('还没有知识点，点击“新增”开始'))
                  : ListView.builder(
                      itemCount: flat.length,
                      itemBuilder: (context, index) {
                        final node = flat[index];
                        return _NodeTile(
                          node: node,
                          allNodes: nodes,
                          onChanged: () => ref.invalidate(knowledgeTreeProvider),
                        );
                      },
                    ),
            ),
            const _ImportEntry(),
          ],
        );
      },
    );
  }
}

class _NodeTile extends ConsumerWidget {
  const _NodeTile({
    required this.node,
    required this.allNodes,
    required this.onChanged,
  });

  final KnowledgeNode node;
  final List<KnowledgeNode> allNodes;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final icon = switch (node.level) {
      1 => Icons.school_outlined,
      2 => Icons.folder_outlined,
      _ => Icons.label_outline,
    };
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.only(left: 16.0 * node.level, right: 8),
      leading: Icon(icon, size: 20),
      title: Text(node.name),
      subtitle: node.isActive ? null : const Text('已停用'),
      trailing: PopupMenuButton<String>(
        onSelected: (value) => _handle(context, ref, value),
        itemBuilder: (context) => [
          const PopupMenuItem(value: 'rename', child: Text('重命名')),
          const PopupMenuItem(value: 'move', child: Text('调整归属')),
          PopupMenuItem(
            value: 'active',
            child: Text(node.isActive ? '停用' : '启用'),
          ),
        ],
      ),
    );
  }

  Future<void> _handle(BuildContext context, WidgetRef ref, String action) async {
    final repo = ref.read(knowledgeRepositoryProvider);
    switch (action) {
      case 'rename':
        final name = await _askName(context, '重命名', node.name);
        if (name == null) return;
        await repo.renameNode(node.id, name);
      case 'move':
        final parent = await _askParent(context, allNodes, node);
        if (parent == _cancelSentinel) return;
        await repo.moveNode(node.id, parent == _rootSentinel ? null : parent as String?);
      case 'active':
        await repo.setActive(node.id, !node.isActive);
    }
    onChanged();
  }
}

const _cancelSentinel = '__cancel__';
const _rootSentinel = '__root__';

Future<String?> _askName(BuildContext context, String title, String initial) {
  final controller = TextEditingController(text: initial);
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
        autofocus: true,
        decoration: const InputDecoration(labelText: '名称'),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('取消')),
        FilledButton(
          onPressed: () => Navigator.pop(context, controller.text),
          child: const Text('保存'),
        ),
      ],
    ),
  );
}

Future<void> _showAddDialog(BuildContext context, WidgetRef ref, List<KnowledgeNode> nodes) async {
  final nameController = TextEditingController();
  String? parentId;
  final parents = nodes.where((n) => n.isActive && n.level < 3).toList();
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: const Text('新增知识点'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String?>(
              initialValue: parentId,
              decoration: const InputDecoration(labelText: '父节点'),
              items: [
                const DropdownMenuItem<String?>(value: null, child: Text('根节点（科目）')),
                ...parents.map((n) => DropdownMenuItem<String?>(
                      value: n.id,
                      child: Text('${'　' * (n.level - 1)}${n.name}'),
                    )),
              ],
              onChanged: (value) => setState(() => parentId = value),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: '名称'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('取消')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('保存')),
        ],
      ),
    ),
  );
  if (result != true) return;
  await ref.read(knowledgeRepositoryProvider).createNode(
        parentId: parentId,
        name: nameController.text,
      );
  ref.invalidate(knowledgeTreeProvider);
}

Future<Object?> _askParent(BuildContext context, List<KnowledgeNode> nodes, KnowledgeNode node) async {
  final options = nodes.where((n) => n.isActive && n.level < 3 && n.id != node.id).toList();
  var value = node.parentId;
  return showDialog<Object>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text('调整「${node.name}」的归属'),
        content: DropdownButtonFormField<String?>(
          initialValue: options.any((n) => n.id == value) ? value : null,
          decoration: const InputDecoration(labelText: '新父节点'),
          items: [
            const DropdownMenuItem<String?>(value: null, child: Text('根节点（科目）')),
            ...options.map((n) => DropdownMenuItem<String?>(
                  value: n.id,
                  child: Text('${'　' * (n.level - 1)}${n.name}'),
                )),
          ],
          onChanged: (v) => setState(() => value = v),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, _cancelSentinel), child: const Text('取消')),
          FilledButton(onPressed: () => Navigator.pop(context, value ?? _rootSentinel), child: const Text('保存')),
        ],
      ),
    ),
  );
}

class _ImportEntry extends ConsumerWidget {
  const _ImportEntry();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      child: OutlinedButton.icon(
        onPressed: () {
          ScaffoldMessenger.of(context).showMessage('大纲导入将在后续版本开放');
        },
        icon: const Icon(Icons.upload_file_outlined),
        label: const Text('导入考研大纲（后续版本）'),
      ),
    );
  }
}

class _TagsTab extends ConsumerWidget {
  const _TagsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags = ref.watch(tagsProvider);
    return tags.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('加载失败：$error')),
      data: (items) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              children: [
                const Expanded(child: Text('自定义标签独立于知识点体系')),
                TextButton.icon(
                  onPressed: () => _addTag(context, ref),
                  icon: const Icon(Icons.add),
                  label: const Text('新增'),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: items.isEmpty
                ? const Center(child: Text('还没有标签'))
                : ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final tag = items[index];
                      return ListTile(
                        leading: const Icon(Icons.label_outline),
                        title: Text(tag.name),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () async {
                            await ref.read(knowledgeRepositoryProvider).deleteTag(tag.id);
                            ref.invalidate(tagsProvider);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _addTag(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('新增标签'),
        content: TextField(controller: controller, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('取消')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('保存')),
        ],
      ),
    );
    if (result != true) return;
    await ref.read(knowledgeRepositoryProvider).createTag(controller.text);
    ref.invalidate(tagsProvider);
  }
}

List<KnowledgeNode> _flatten(List<KnowledgeNode> nodes) {
  final children = <String?, List<KnowledgeNode>>{};
  for (final node in nodes) {
    children.putIfAbsent(node.parentId, () => []).add(node);
  }
  for (final list in children.values) {
    list.sort((a, b) {
      final byOrder = a.sortOrder.compareTo(b.sortOrder);
      return byOrder != 0 ? byOrder : a.name.compareTo(b.name);
    });
  }
  final result = <KnowledgeNode>[];
  void visit(String? parentId) {
    for (final node in children[parentId] ?? const <KnowledgeNode>[]) {
      result.add(node);
      visit(node.id);
    }
  }

  visit(null);
  return result;
}
