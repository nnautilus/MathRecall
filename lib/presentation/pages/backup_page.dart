import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;

import '../../app/backup_providers.dart';
import '../../app/capture_providers.dart';
import '../../app/knowledge_providers.dart';
import '../../app/providers.dart';
import '../../app/question_providers.dart';
import '../../app/review_providers.dart';
import '../../core/errors/app_error.dart';
import '../../core/ui/app_snack_bar.dart';
import '../../domain/entities/backup.dart';
import '../../infrastructure/backup/backup_service.dart';
import '../../platform/backup_file_channel.dart';

class BackupPage extends ConsumerStatefulWidget {
  const BackupPage({super.key});

  @override
  ConsumerState<BackupPage> createState() => _BackupPageState();
}

class _BackupPageState extends ConsumerState<BackupPage> {
  List<BackupInfo> _backups = const [];
  bool _loading = true;
  bool _busy = false;
  String _progress = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<BackupService> _service() async =>
      ref.read(backupServiceProvider.future);

  Future<void> _load() async {
    try {
      final service = await _service();
      final backups = await service.listBackups();
      if (!mounted) return;
      setState(() {
        _backups = backups;
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => _loading = false);
      _snack(error is AppError ? error.userMessage : '读取备份失败：$error');
    }
  }

  Future<void> _createBackup() async {
    setState(() {
      _busy = true;
      _progress = '准备中…';
    });
    try {
      final service = await _service();
      final file = await service.exportBackup(
        onProgress: (message) {
          if (mounted) setState(() => _progress = message);
        },
      );
      await _load();
      if (!mounted) return;
      setState(() => _progress = '备份完成');
      await _showCreated(file);
    } on AppError catch (error) {
      _snack(error.userMessage);
    } catch (error) {
      _snack('备份失败：$error');
    } finally {
      if (mounted) {
        setState(() {
          _busy = false;
          _progress = '';
        });
      }
    }
  }

  Future<void> _showCreated(File file) async {
    final size = await file.length();
    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('备份完成'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(p.basename(file.path)),
            const SizedBox(height: 8),
            Text('大小：${_formatBytes(size)}'),
            const SizedBox(height: 8),
            const Text('建议立即保存到手机或网盘，卸载 App 后本地备份会丢失。'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('关闭'),
          ),
          FilledButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
              _saveToDevice(file);
            },
            icon: const Icon(Icons.save_alt),
            label: const Text('保存到手机'),
          ),
        ],
      ),
    );
  }

  Future<void> _saveToDevice(File file) async {
    try {
      final saved = await const BackupFileChannel().saveBackup(file);
      if (saved) _snack('备份已保存到所选位置');
    } on AppError catch (error) {
      _snack(error.userMessage);
    } catch (error) {
      _snack('保存失败：$error');
    }
  }

  Future<void> _pickAndRestore() async {
    try {
      final file = await const BackupFileChannel().pickBackup();
      if (file == null) return;
      await _previewAndRestore(file);
    } on AppError catch (error) {
      _snack(error.userMessage);
    } catch (error) {
      _snack('选择备份失败：$error');
    }
  }

  Future<void> _previewAndRestore(File file) async {
    setState(() {
      _busy = true;
      _progress = '正在校验备份…';
    });
    try {
      final service = await _service();
      final preview = await service.inspectBackup(file);
      if (!mounted) return;
      setState(() {
        _busy = false;
        _progress = '';
      });
      if (!preview.canRestore) {
        _snack(preview.error ?? '备份不兼容');
        return;
      }
      final confirmed = await _showPreview(preview);
      if (confirmed != true) return;
      setState(() {
        _busy = true;
        _progress = '正在恢复数据…';
      });
      final report = await service.restoreBackup(file, confirmed: true);
      _invalidateData();
      await _load();
      if (!mounted) return;
      _snack(
        '恢复完成：${report.restoredQuestions} 道题、'
        '${report.restoredImages} 张图片'
        '${report.missingImages > 0 ? '，丢失 ${report.missingImages} 张' : ''}',
      );
    } on AppError catch (error) {
      _snack(error.userMessage);
    } catch (error) {
      _snack('恢复失败：$error');
    } finally {
      if (mounted) {
        setState(() {
          _busy = false;
          _progress = '';
        });
      }
    }
  }

  Future<bool?> _showPreview(BackupPreview preview) {
    final manifest = preview.manifest;
    final counts = manifest.counts;
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('恢复备份？'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('备份时间：${_formatDate(manifest.createdAtDateTime)}'),
              Text('应用版本：${manifest.appVersion}'),
              Text('schema：${manifest.schemaVersion}'),
              const SizedBox(height: 8),
              Text(
                '题目：${counts['questions'] ?? 0}　'
                '复习日志：${counts['review_logs'] ?? 0}',
              ),
              Text(
                '知识点：${counts['knowledge_nodes'] ?? 0}　'
                '图片：${manifest.images.length}',
              ),
              if (preview.warnings.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  '警告：${preview.warnings.length} 个图片缺失',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
              const SizedBox(height: 12),
              const Text(
                '恢复会覆盖当前全部题目、复习记录和知识点。当前数据库会先备份为 .bak。',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('覆盖并恢复'),
          ),
        ],
      ),
    );
  }

  void _invalidateData() {
    ref.invalidate(questionCountProvider);
    ref.invalidate(dueCountProvider);
    ref.invalidate(questionListProvider);
    ref.invalidate(questionFilterProvider);
    ref.invalidate(recentQuestionsProvider);
    ref.invalidate(knowledgeTreeProvider);
    ref.invalidate(tagsProvider);
    ref.invalidate(dueQueueProvider);
    ref.invalidate(reviewHistoryCountProvider);
    ref.invalidate(imageStorageProvider);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('备份与恢复')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('完整备份', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 6),
                  const Text('包含题库、知识点、复习记录、草稿和全部原图。'),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _busy ? null : _createBackup,
                      icon: const Icon(Icons.backup_outlined),
                      label: const Text('创建备份'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _busy ? null : _pickAndRestore,
                      icon: const Icon(Icons.restore_page_outlined),
                      label: const Text('从文件恢复'),
                    ),
                  ),
                  if (_busy) ...[
                    const SizedBox(height: 12),
                    const LinearProgressIndicator(),
                    const SizedBox(height: 6),
                    Text(_progress, style: theme.textTheme.bodySmall),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('本地备份', style: theme.textTheme.titleMedium),
          const SizedBox(height: 6),
          if (_loading)
            const Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_backups.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('还没有本地备份。创建后建议分享/保存到网盘。'),
            )
          else
            ..._backups.map(
              (backup) => Card(
                child: ListTile(
                  leading: const Icon(Icons.archive_outlined),
                  title: Text(backup.name),
                  subtitle: Text(
                    '${_formatDate(backup.modifiedAt)} · '
                    '${_formatBytes(backup.bytes)}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        tooltip: '保存到手机',
                        onPressed: _busy
                            ? null
                            : () => _saveToDevice(backup.file),
                        icon: const Icon(Icons.save_alt),
                      ),
                      IconButton(
                        tooltip: '恢复',
                        onPressed: _busy
                            ? null
                            : () => _previewAndRestore(backup.file),
                        icon: const Icon(Icons.restore),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          const SizedBox(height: 16),
          Text(
            '注意：卸载 App 会删除“本地备份”目录。切换签名 / 换手机前，'
            '请先把备份保存到网盘或文件管理器。',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  void _snack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showMessage(message);
  }

  static String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(bytes / 1024 / 1024).toStringAsFixed(1)} MB';
  }

  static String _formatDate(DateTime time) {
    String two(int value) => value.toString().padLeft(2, '0');
    return '${time.year}-${two(time.month)}-${two(time.day)} '
        '${two(time.hour)}:${two(time.minute)}';
  }
}
