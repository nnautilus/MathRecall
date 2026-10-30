import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../app/capture_providers.dart';
import '../../app/providers.dart';
import '../../app/question_providers.dart';
import '../../core/errors/app_error.dart';
import '../../core/ui/app_snack_bar.dart';
import '../../domain/entities/draft.dart';
import '../../domain/entities/knowledge_match.dart';
import '../widgets/math_text.dart';

class DraftReviewPage extends ConsumerStatefulWidget {
  const DraftReviewPage({super.key, required this.draftId});

  final String draftId;

  @override
  ConsumerState<DraftReviewPage> createState() => _DraftReviewPageState();
}

class _DraftReviewPageState extends ConsumerState<DraftReviewPage> {
  List<DraftItem> _items = const [];
  Map<String, KnowledgeMatchResult> _matches = const {};
  bool _loading = true;
  bool _saving = false;
  String? _error;
  final _picker = ImagePicker();

  bool get _hasNewSelected =>
      _items.any((item) => item.isSelected && item.createdQuestionId == null);

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final repo = ref.read(draftRepositoryProvider);
      final draft = await repo.findById(widget.draftId);
      final items = draft == null ? <DraftItem>[] : await repo.itemsOf(draft.id);
      final matches = await _computeMatches(items);
      if (!mounted) return;
      setState(() {
        _items = items;
        _matches = matches;
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = '$error';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('校对题目'),
        actions: [
          IconButton(
            tooltip: '放弃草稿',
            onPressed: _loading ? null : _discard,
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: _body(),
      bottomNavigationBar: _loading || _error != null
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _saving ? null : _saveEdits,
                        child: const Text('保存修改'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: _saving || !_hasNewSelected ? null : _confirm,
                        child: Text(_saving ? '处理中…' : '确认入库'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _body() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(child: Text('加载失败：$_error'));
    }
    if (_items.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('AI 没有识别出题目'),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: _addItem,
              child: const Text('手动添加一题'),
            ),
          ],
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _items.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) => _itemCard(index),
    );
  }

  Widget _itemCard(int index) {
    final item = _items[index];
    final created = item.createdQuestionId != null;
    final match = _matches[item.id];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  value: item.isSelected && !created,
                  onChanged: created
                      ? null
                      : (value) => setState(() {
                            _items[index] =
                                item.copyWith(isSelected: value ?? false);
                          }),
                ),
                Text('第 ${index + 1} 题'),
                const Spacer(),
                if (created)
                  const Chip(label: Text('已入库'))
                else if (item.confidence != null)
                  Chip(
                    label: Text(
                      '置信度 ${(item.confidence! * 100).toStringAsFixed(0)}%',
                    ),
                  ),
              ],
            ),
            TextFormField(
              key: ValueKey('${item.id}-prompt'),
              initialValue: item.promptLatex ?? '',
              minLines: 2,
              maxLines: 8,
              enabled: !created,
              decoration: const InputDecoration(
                labelText: '题干（LaTeX）',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _items[index] = item.copyWith(promptLatex: value);
                });
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              key: ValueKey('${item.id}-answer'),
              initialValue: item.answerLatex ?? '',
              enabled: !created,
              decoration: const InputDecoration(
                labelText: '答案（可空）',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _items[index] = item.copyWith(answerLatex: value);
                });
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              key: ValueKey('${item.id}-solution'),
              initialValue: item.solutionLatex ?? '',
              minLines: 2,
              maxLines: 6,
              enabled: !created,
              decoration: const InputDecoration(
                labelText: '正确解法（可空）',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _items[index] = item.copyWith(solutionLatex: value);
                });
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              key: ValueKey('${item.id}-knowledge'),
              initialValue: item.knowledgePoints.join('，'),
              enabled: !created,
              decoration: const InputDecoration(
                labelText: '知识点（用逗号分隔，可留空）',
                border: OutlineInputBorder(),
                isDense: true,
              ),
              onChanged: (value) {
                setState(() {
                  _items[index] = item.copyWith(
                    knowledgePoints: value
                        .split(RegExp(r'[,，/]'))
                        .map((part) => part.trim())
                        .where((part) => part.isNotEmpty)
                        .toList(),
                  );
                });
              },
            ),
            if (!created) _previewBlock(item),
            const SizedBox(height: 8),
            _attachmentSection(index, item, created),
            if (match != null && match.hasIssues)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  '${
                    [
                      if (match.unmatched.isNotEmpty)
                        '未匹配：${match.unmatched.join('、')}',
                      if (match.ambiguous.isNotEmpty)
                        '同名需消歧：${match.ambiguous.join('、')}',
                    ].join('；')
                  }（入库时忽略，可改成现有知识点名称）',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, KnowledgeMatchResult>> _computeMatches(
    List<DraftItem> items,
  ) async {
    final repo = ref.read(draftRepositoryProvider);
    final result = <String, KnowledgeMatchResult>{};
    for (final item in items) {
      result[item.id] = await repo.matchKnowledgePoints(item.knowledgePoints);
    }
    return result;
  }

  Widget _previewBlock(DraftItem item) {
    final prompt = (item.promptLatex ?? '').trim();
    final answer = (item.answerLatex ?? '').trim();
    final solution = (item.solutionLatex ?? '').trim();
    if (prompt.isEmpty && answer.isEmpty && solution.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('渲染预览', style: Theme.of(context).textTheme.labelSmall),
          if (prompt.isNotEmpty) ...[
            const SizedBox(height: 4),
            MathText(prompt),
          ],
          if (answer.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text('答案', style: Theme.of(context).textTheme.labelSmall),
            MathText(answer),
          ],
          if (solution.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text('解法', style: Theme.of(context).textTheme.labelSmall),
            MathText(solution),
          ],
        ],
      ),
    );
  }

  Widget _attachmentSection(int index, DraftItem item, bool created) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('附加图片', style: Theme.of(context).textTheme.labelLarge),
            const Spacer(),
            if (!created)
              TextButton.icon(
                onPressed: _saving ? null : () => _addAttachment(index),
                icon: const Icon(Icons.add_a_photo_outlined, size: 18),
                label: const Text('添加'),
              ),
          ],
        ),
        if (item.imageSha256s.isEmpty)
          Text(
            '识别不完整时可补充图片',
            style: Theme.of(context).textTheme.bodySmall,
          )
        else
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final sha in item.imageSha256s)
                _attachmentThumb(sha, index, created),
            ],
          ),
      ],
    );
  }

  Widget _attachmentThumb(String sha, int index, bool created) {
    return FutureBuilder<File?>(
      future: _fileForSha(sha),
      builder: (context, snapshot) {
        final file = snapshot.data;
        return Stack(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.antiAlias,
              child: file == null
                  ? const Icon(Icons.image_outlined)
                  : Image.file(file, fit: BoxFit.cover),
            ),
            if (!created)
              Positioned(
                right: 0,
                top: 0,
                child: InkWell(
                  onTap: _saving ? null : () => _removeAttachment(index, sha),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Future<File?> _fileForSha(String sha256) async {
    final store = await ref.read(imageStorageProvider.future);
    return store.fileForSha(sha256);
  }

  Future<void> _addAttachment(int index) async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: const Text('拍照'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('从相册选择'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
    if (source == null) return;
    final picked = await _picker.pickImage(
      source: source,
      maxWidth: 3000,
      imageQuality: 95,
    );
    if (picked == null) return;
    setState(() => _saving = true);
    try {
      final store = await ref.read(imageStorageProvider.future);
      final stored = await store.storeFile(File(picked.path));
      await ref
          .read(draftRepositoryProvider)
          .addItemImage(_items[index].id, stored.sha256);
      await _reloadItems();
      _snack('已附加图片');
    } catch (error) {
      _snack('附加图片失败：$error');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _removeAttachment(int index, String sha256) async {
    setState(() => _saving = true);
    try {
      await ref
          .read(draftRepositoryProvider)
          .removeItemImage(_items[index].id, sha256);
      await _reloadItems();
    } catch (error) {
      _snack('移除图片失败：$error');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _reloadItems() async {
    final repo = ref.read(draftRepositoryProvider);
    final items = await repo.itemsOf(widget.draftId);
    final matches = await _computeMatches(items);
    if (!mounted) return;
    setState(() {
      _items = items;
      _matches = matches;
    });
  }

  Future<void> _saveEdits() async {
    setState(() => _saving = true);
    try {
      final saved = await ref
          .read(draftRepositoryProvider)
          .saveItems(widget.draftId, _items);
      final matches = await _computeMatches(saved);
      if (!mounted) return;
      setState(() {
        _items = saved;
        _matches = matches;
      });
      _snack('已保存');
    } on AppError catch (error) {
      _snack(error.userMessage);
    } catch (error) {
      _snack('保存失败：$error');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _confirm() async {
    setState(() => _saving = true);
    try {
      final repo = ref.read(draftRepositoryProvider);
      final saved = await repo.saveItems(widget.draftId, _items);
      final matches = await _computeMatches(saved);
      if (!mounted) return;
      setState(() {
        _items = saved;
        _matches = matches;
      });

      final issues = <String>[];
      for (var i = 0; i < saved.length; i++) {
        final match = matches[saved[i].id];
        if (match == null || !match.hasIssues) continue;
        final parts = <String>[
          if (match.unmatched.isNotEmpty) '未匹配 ${match.unmatched.join('、')}',
          if (match.ambiguous.isNotEmpty) '同名需消歧 ${match.ambiguous.join('、')}',
        ];
        issues.add('第 ${i + 1} 题：${parts.join('；')}');
      }
      if (issues.isNotEmpty) {
        final proceed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('有未匹配的知识点'),
            content: Text('${issues.join('\n')}\n\n继续入库时这些知识点会被忽略，可能影响后续统计。'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('返回修改'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('仍然入库'),
              ),
            ],
          ),
        );
        if (proceed != true) return;
      }

      final selected = saved
          .where((item) => item.isSelected && item.createdQuestionId == null)
          .map((item) => item.id)
          .toSet();
      if (selected.isEmpty) {
        _snack('请至少勾选一道题');
        return;
      }
      final ids = await repo.confirm(widget.draftId, selectedItemIds: selected);
      ref.invalidate(questionListProvider);
      ref.invalidate(questionCountProvider);
      ref.invalidate(dueCountProvider);
      ref.invalidate(recentQuestionsProvider);
      if (!mounted) return;
      Navigator.of(context).pop(ids.length);
      _snack('已入库 ${ids.length} 道题');
    } on AppError catch (error) {
      _snack(error.userMessage);
    } catch (error) {
      _snack('入库失败：$error');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _addItem() async {
    final item = DraftItem(
      id: const Uuid().v4(),
      draftId: widget.draftId,
      sortOrder: _items.length,
    );
    setState(() => _items = [..._items, item]);
    await _saveEdits();
  }

  Future<void> _discard() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('放弃草稿？'),
        content: const Text('草稿与识别结果会被删除，图片保留。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('放弃'),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    await ref.read(draftRepositoryProvider).discard(widget.draftId);
    if (mounted) Navigator.of(context).pop();
  }

  void _snack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showMessage(message);
  }
}
