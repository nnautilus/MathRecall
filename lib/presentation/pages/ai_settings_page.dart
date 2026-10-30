import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/capture_providers.dart';
import '../../core/errors/app_error.dart';
import '../../infrastructure/ai/ai_config.dart';
import '../../core/ui/app_snack_bar.dart';

class AiSettingsPage extends ConsumerStatefulWidget {
  const AiSettingsPage({super.key});

  @override
  ConsumerState<AiSettingsPage> createState() => _AiSettingsPageState();
}

class _AiSettingsPageState extends ConsumerState<AiSettingsPage> {
  static const _presets = <String, String>{
    'OpenAI': 'https://api.openai.com/v1',
    'DeepSeek': 'https://api.deepseek.com/v1',
    '火山方舟': 'https://ark.cn-beijing.volces.com/api/v3',
    'Ollama 本地': 'http://127.0.0.1:11434/v1',
    '自定义': '',
  };

  final _baseUrl = TextEditingController();
  final _model = TextEditingController();
  final _apiKey = TextEditingController();
  String _preset = '自定义';
  bool _loading = true;
  bool _saving = false;
  bool _hasKey = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _baseUrl.dispose();
    _model.dispose();
    _apiKey.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final config = await ref.read(aiConfigProvider.future);
    if (!mounted) return;
    setState(() {
      _baseUrl.text = config.baseUrl;
      _model.text = config.model;
      _apiKey.clear();
      _hasKey = config.apiKey.isNotEmpty;
      _preset = _presetFor(config.baseUrl);
      _loading = false;
    });
  }

  String _presetFor(String baseUrl) {
    for (final entry in _presets.entries) {
      if (entry.value.isNotEmpty && entry.value == baseUrl) {
        return entry.key;
      }
    }
    return '自定义';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI 配置')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                DropdownButtonFormField<String>(
                  initialValue: _preset,
                  decoration: const InputDecoration(
                    labelText: '服务商预设',
                    border: OutlineInputBorder(),
                  ),
                  items: _presets.keys
                      .map((name) => DropdownMenuItem(
                            value: name,
                            child: Text(name),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      _preset = value;
                      final baseUrl = _presets[value]!;
                      if (baseUrl.isNotEmpty) {
                        _baseUrl.text = baseUrl;
                      }
                    });
                  },
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _baseUrl,
                  decoration: const InputDecoration(
                    labelText: '接口地址（Base URL）',
                    hintText: 'https://api.deepseek.com/v1',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _model,
                  decoration: const InputDecoration(
                    labelText: '模型',
                    hintText: '需要支持图片输入的多模态模型',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _apiKey,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'API Key',
                    hintText: _hasKey ? '已配置（留空保持不变）' : '请输入 API Key',
                    helperText: _hasKey
                        ? '已保存到 Android Keystore，不回显'
                        : '保存在 Android Keystore，不写入数据库',
                    border: const OutlineInputBorder(),
                  ),
                ),
                if (_hasKey)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: _saving ? null : _clearKey,
                      icon: const Icon(Icons.delete_outline, size: 18),
                      label: const Text('删除 Key'),
                    ),
                  ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: _saving ? null : _save,
                  child: Text(_saving ? '保存中…' : '保存'),
                ),
                const SizedBox(height: 12),
                Text(
                  '说明：V1 只支持 OpenAI-compatible 接口，且模型必须支持图片输入。'
                  '识别失败时可改用手动录入。',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
    );
  }

  Future<void> _save() async {
    var apiKey = _apiKey.text.trim();
    if (apiKey.isEmpty && _hasKey) {
      apiKey = (await ref.read(aiConfigProvider.future)).apiKey;
    }
    final config = AiConfig(
      providerName: _preset == '自定义' ? 'openai-compatible' : _preset,
      baseUrl: _baseUrl.text,
      model: _model.text,
      apiKey: apiKey,
    );
    if (!config.isConfigured) {
      _snack('请填写接口地址、模型和 API Key');
      return;
    }
    setState(() => _saving = true);
    try {
      await ref.read(aiConfigStoreProvider).save(config);
      ref.invalidate(aiConfigProvider);
      if (!mounted) return;
      setState(() => _hasKey = true);
      _snack('已保存');
      Navigator.of(context).pop();
    } on AppError catch (error) {
      _snack(error.userMessage);
    } catch (error) {
      _snack('保存失败：$error');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _clearKey() async {
    await ref.read(aiConfigStoreProvider).clearApiKey();
    ref.invalidate(aiConfigProvider);
    if (!mounted) return;
    setState(() => _hasKey = false);
    _snack('已删除 API Key');
  }

  void _snack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showMessage(message);
  }
}
