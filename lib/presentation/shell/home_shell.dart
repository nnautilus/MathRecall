import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../app/question_providers.dart';
import '../pages/capture_page.dart';
import '../pages/home_page.dart';
import '../pages/questions_page.dart';
import '../pages/review_page.dart';
import '../pages/settings_page.dart';
import '../pages/stats_page.dart';

/// 5 个底部 Tab：首页 / 错题本 / 复习 / 统计 / 设置。
class HomeShell extends ConsumerStatefulWidget {
  const HomeShell({super.key});

  @override
  ConsumerState<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends ConsumerState<HomeShell> {
  int _index = 0;

  Future<void> _openCapture() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const CapturePage()),
    );
    if (!mounted) return;
    ref.invalidate(questionCountProvider);
    ref.invalidate(dueCountProvider);
    ref.invalidate(recentQuestionsProvider);
  }

  static const _pages = <Widget>[
    HomePage(),
    QuestionsPage(),
    ReviewPage(),
    StatsPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      floatingActionButton: _index == 0
          ? FloatingActionButton.extended(
              onPressed: _openCapture,
              icon: const Icon(Icons.add),
              label: const Text('录题'),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: '首页'),
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), label: '错题本'),
          NavigationDestination(icon: Icon(Icons.event_repeat), label: '复习'),
          NavigationDestination(icon: Icon(Icons.bar_chart), label: '统计'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), label: '设置'),
        ],
      ),
    );
  }
}
