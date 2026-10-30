import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/capture_providers.dart';
import 'ai_settings_page.dart';
import 'knowledge_page.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aiConfig = ref.watch(aiConfigProvider);
    return SafeArea(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text('设置', style: Theme.of(context).textTheme.headlineMedium),
          ),
          ListTile(
            leading: const Icon(Icons.smart_toy_outlined),
            title: const Text('AI 配置'),
            subtitle: Text(
              aiConfig.maybeWhen(
                data: (config) =>
                    config.isConfigured ? '已配置：${config.model}' : '未配置',
                orElse: () => '未配置',
              ),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const AiSettingsPage()),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.tune),
            title: Text('复习阈值'),
            subtitle: Text('已掌握 ≥ 0.80 · 待加强 ≤ 0.40'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            leading: const Icon(Icons.account_tree_outlined),
            title: const Text('知识点管理'),
            subtitle: const Text('V1 不预置大纲，保留导入接口'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const KnowledgePage()),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.backup_outlined),
            title: Text('数据备份 / 恢复'),
            subtitle: Text('完整备份与恢复'),
            trailing: Icon(Icons.chevron_right),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('关于'),
            subtitle: Text('MathRecall 0.1.0 · Android 单机版'),
          ),
        ],
      ),
    );
  }
}
