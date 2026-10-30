import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/knowledge_providers.dart';
import '../../app/providers.dart';
import '../../app/question_providers.dart';
import '../../core/errors/app_error.dart';
import '../../domain/entities/question.dart';
import '../../core/ui/app_snack_bar.dart';

class QuestionEditPage extends ConsumerStatefulWidget {
  const QuestionEditPage({super.key, this.question});

  final Question? question;

  @override
  ConsumerState<QuestionEditPage> createState() => _QuestionEditPageState();
}

class _QuestionEditPageState extends ConsumerState<QuestionEditPage> {
  late final TextEditingController _prompt;
  late final TextEditingController _answer;
  late final TextEditingController _solution;
  late final TextEditingController _hint;
  late final TextEditingController _source;
  int? _difficulty;
  final Set<String> _selectedNodeIds = {};
  bool _saving = false;

  bool get _isEdit => widget.question != null;

  @override
  void initState() {
    super.initState();
    final question = widget.question;
    _prompt = TextEditingController(text: question?.promptLatex ?? '');
    _answer = TextEditingController(text: question?.answerLatex ?? '');
    _solution = TextEditingController(text: question?.solutionLatex ?? '');
    _hint = TextEditingController(text: question?.hintLatex ?? '');
    _source = TextEditingController(text: question?.sourceText ?? '');
    _difficulty = question?.difficulty;
    _selectedNodeIds.addAll(question?.knowledgeNodeIds ?? const []);
  }

  @override
  void dispose() {
    _prompt.dispose();
    _answer.dispose();
    _solution.dispose();
    _hint.dispose();
    _source.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tree = ref.watch(knowledgeTreeProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? '编辑题目' : '手动新增题目'),
        actions: [
          TextButton(
            onPressed: _saving ? null : _save,
            child: const Text('保存'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _prompt,
            minLines: 3,
            maxLines: 8,
            decoration: const InputDecoration(
              labelText: '题干（支持 LaTeX）',
              alignLabelWithHint: true,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _answer,
            decoration: const InputDecoration(
              labelText: '答案（可空）',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _solution,
            minLines: 3,
            maxLines: 10,
            decoration: const InputDecoration(
              labelText: '正确解法（可空）',
              alignLabelWithHint: true,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _hint,
            minLines: 1,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: '提示（可空，复习时使用）',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<int?>(
            initialValue: _difficulty,
            decoration: const InputDecoration(
              labelText: '难度',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem<int?>(value: null, child: Text('未设置')),
              DropdownMenuItem<int?>(value: 1, child: Text('1')),
              DropdownMenuItem<int?>(value: 2, child: Text('2')),
              DropdownMenuItem<int?>(value: 3, child: Text('3')),
              DropdownMenuItem<int?>(value: 4, child: Text('4')),
              DropdownMenuItem<int?>(value: 5, child: Text('5')),
            ],
            onChanged: (value) => setState(() => _difficulty = value),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _source,
            decoration: const InputDecoration(
              labelText: '来源（可选，如：张宇30讲 第1讲 例3）',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Text('知识点', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          tree.when(
            loading: () => const LinearProgressIndicator(),
            error: (error, _) => Text('知识点加载失败：$error'),
            data: (nodes) {
              final points =
                  nodes.where((n) => n.level == 3 && n.isActive).toList();
              if (points.isEmpty) {
                return const Text('还没有三级知识点，请先在“设置 → 知识点管理”创建。');
              }
              return Wrap(
                spacing: 8,
                runSpacing: 4,
                children: points.map((node) {
                  final selected = _selectedNodeIds.contains(node.id);
                  return FilterChip(
                    label: Text(node.name),
                    selected: selected,
                    onSelected: (value) {
                      setState(() {
                        if (value) {
                          _selectedNodeIds.add(node.id);
                        } else {
                          _selectedNodeIds.remove(node.id);
                        }
                      });
                    },
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      final repo = ref.read(questionRepositoryProvider);
      if (_isEdit) {
        final id = widget.question!.id;
        await repo.update(
          id: id,
          promptLatex: _prompt.text,
          answerLatex: _emptyToNull(_answer.text),
          solutionLatex: _emptyToNull(_solution.text),
          hintLatex: _emptyToNull(_hint.text),
          difficulty: _difficulty,
          sourceText: _emptyToNull(_source.text),
        );
        await repo.setKnowledge(id, _selectedNodeIds.toList());
      } else {
        await repo.create(
          promptLatex: _prompt.text,
          answerLatex: _emptyToNull(_answer.text),
          solutionLatex: _emptyToNull(_solution.text),
          hintLatex: _emptyToNull(_hint.text),
          difficulty: _difficulty,
          sourceText: _emptyToNull(_source.text),
          knowledgeNodeIds: _selectedNodeIds.toList(),
        );
      }
      ref.invalidate(questionListProvider);
      ref.invalidate(questionCountProvider);
      ref.invalidate(dueCountProvider);
      ref.invalidate(recentQuestionsProvider);
      if (!mounted) return;
      Navigator.of(context).pop();
    } on AppError catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showMessage(error.userMessage);
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  String? _emptyToNull(String value) => value.trim().isEmpty ? null : value;
}
