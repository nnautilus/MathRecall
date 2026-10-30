import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../app/capture_providers.dart';
import '../../app/knowledge_providers.dart';
import '../../app/providers.dart';
import '../../app/question_providers.dart';
import '../../core/errors/app_error.dart';
import '../../domain/entities/draft.dart';
import 'ai_settings_page.dart';
import 'draft_review_page.dart';
import 'image_region_select_page.dart';
import 'question_edit_page.dart';
import '../../core/ui/app_snack_bar.dart';

class CapturePage extends ConsumerStatefulWidget {
  const CapturePage({super.key});

  @override
  ConsumerState<CapturePage> createState() => _CapturePageState();
}

class _CapturePageState extends ConsumerState<CapturePage> {
  final _picker = ImagePicker();
  File? _image;
  Draft? _draft;
  bool _busy = false;
  String _status = '拍照或从相册选择题目图片';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('录题')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AspectRatio(
            aspectRatio: 3 / 4,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: _image == null
                  ? const Center(child: Text('尚未选择图片'))
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(_image!, fit: BoxFit.contain),
                    ),
            ),
          ),
          const SizedBox(height: 12),
          Text(_status, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _busy ? null : () => _pick(ImageSource.camera),
                  icon: const Icon(Icons.photo_camera_outlined),
                  label: const Text('拍照'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _busy ? null : () => _pick(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library_outlined),
                  label: const Text('相册'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: _busy || _image == null ? null : _analyze,
            icon: _busy
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.auto_awesome),
            label: Text(_busy ? '识别中…' : 'AI 识别并拆分题目'),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: _busy || _image == null ? null : _analyzeRegion,
            icon: const Icon(Icons.crop_free),
            label: const Text('重新框选识别'),
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: _busy ? null : _manualEntry,
            icon: const Icon(Icons.edit_outlined),
            label: const Text('跳过 AI，手动录入'),
          ),
        ],
      ),
    );
  }

  Future<void> _pick(ImageSource source) async {
    setState(() => _busy = true);
    try {
      final picked = await _picker.pickImage(
        source: source,
        maxWidth: 3000,
        imageQuality: 95,
      );
      if (picked == null) return;
      final file = File(picked.path);
      final bytes = await file.readAsBytes();
      final service = await ref.read(captureServiceProvider.future);
      final draft = await service.createDraft(
        file,
        source: source == ImageSource.camera ? 'camera' : 'gallery',
      );
      if (!mounted) return;
      setState(() {
        _image = file;
        _draft = draft;
        _status = '图片已保存，请框选题目区域';
      });
      await _regionRecognize(bytes, draft);
    } on AppError catch (error) {
      _show(error.userMessage);
    } catch (error) {
      _show('读取图片失败：$error');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  /// 拍完/选完立即进入框选页，确认后直接识别。
  Future<void> _regionRecognize(Uint8List imageBytes, Draft draft) async {
    if (!mounted) return;
    final rect = await Navigator.of(context).push<Rect>(
      MaterialPageRoute(
        builder: (_) => ImageRegionSelectPage(imageBytes: imageBytes),
      ),
    );
    if (!mounted) return;
    if (rect == null) {
      setState(() => _status = '已取消框选，可识别整图或重新框选');
      return;
    }
    final isFullImage = rect.width >= 0.999 && rect.height >= 0.999;
    final cropped =
        isFullImage ? null : await cropImageBytes(imageBytes, rect);
    final config = await ref.read(aiConfigProvider.future);
    if (!config.isConfigured) {
      if (!mounted) return;
      await _askConfigureAi();
      return;
    }
    final provider = await ref.read(aiVisionProviderProvider.future);
    final service = await ref.read(captureServiceProvider.future);
    setState(() => _status = '正在识别…');
    final updated = await service.analyze(
      draft,
      provider,
      imageBytes: cropped,
      userHint: isFullImage ? null : '这是用户从原图中框选的局部区域，只识别该区域内的题目。',
      knowledgePaths: await _knowledgePaths(),
    );
    if (!mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DraftReviewPage(draftId: updated.id),
      ),
    );
    if (mounted) setState(() => _status = '识别完成，可在校对页调整');
  }

  Future<void> _analyze() async {
    final draft = _draft;
    if (draft == null) return;
    setState(() {
      _busy = true;
      _status = '正在调用 AI 识别…';
    });
    try {
      final config = await ref.read(aiConfigProvider.future);
      if (!config.isConfigured) {
        if (!mounted) return;
        await _askConfigureAi();
        return;
      }
      final provider = await ref.read(aiVisionProviderProvider.future);
      final service = await ref.read(captureServiceProvider.future);
      final updated = await service.analyze(
        draft,
        provider,
        knowledgePaths: await _knowledgePaths(),
      );
      if (!mounted) return;
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => DraftReviewPage(draftId: updated.id),
        ),
      );
      if (!mounted) return;
      setState(() => _status = '识别完成，可在校对页调整后入库');
    } on AppError catch (error) {
      _show(error.userMessage);
    } catch (error) {
      _show('识别失败：$error');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _analyzeRegion() async {
    final draft = _draft;
    final image = _image;
    if (draft == null || image == null) return;
    setState(() => _busy = true);
    try {
      await _regionRecognize(await image.readAsBytes(), draft);
    } on AppError catch (error) {
      _show(error.userMessage);
    } catch (error) {
      _show('框选识别失败：$error');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<List<String>> _knowledgePaths() async {
    try {
      final nodes = await ref.read(knowledgeTreeProvider.future);
      final byId = {for (final node in nodes) node.id: node};
      final paths = <String>[];
      for (final node in nodes.where((n) => n.level == 3 && n.isActive)) {
        final chapter = node.parentId == null ? null : byId[node.parentId];
        final subject = chapter == null || chapter.parentId == null
            ? null
            : byId[chapter.parentId];
        paths.add(
          [
            if (subject != null) subject.name,
            if (chapter != null) chapter.name,
            node.name,
          ].join('/'),
        );
      }
      return paths;
    } catch (_) {
      return const [];
    }
  }

  Future<void> _askConfigureAi() async {
    final go = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('AI 未配置'),
        content: const Text('请先在设置中填写 AI 接口地址、模型和 API Key。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('去设置'),
          ),
        ],
      ),
    );
    if (go == true && mounted) {
      await Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const AiSettingsPage()),
      );
    }
  }

  Future<void> _manualEntry() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const QuestionEditPage()),
    );
    if (!mounted) return;
    ref.invalidate(questionCountProvider);
    ref.invalidate(questionListProvider);
    ref.invalidate(dueCountProvider);
    ref.invalidate(recentQuestionsProvider);
  }

  void _show(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showMessage(message);
  }
}
