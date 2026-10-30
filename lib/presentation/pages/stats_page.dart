import 'package:flutter/material.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
        children: [
          Text('统计', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          const Row(
            children: [
              Expanded(child: _StatCard(label: '错题总量', value: '--')),
              SizedBox(width: 12),
              Expanded(child: _StatCard(label: '今日待复习', value: '--')),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(child: _StatCard(label: '累计复习', value: '--')),
              SizedBox(width: 12),
              Expanded(child: _StatCard(label: '已掌握/待加强', value: '--/--')),
            ],
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('科目分布', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  const Text('统计将在 P6 阶段接入；章节只展示数量，不输出薄弱结论。'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
