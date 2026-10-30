import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../infrastructure/database/app_database.dart';
import '../platform/platform_facade.dart';

/// 数据库实例：由 main/bootstrap 覆盖注入（测试用内存库）。
final databaseProvider = Provider<AppDatabase>(
  (ref) => throw UnimplementedError('databaseProvider must be overridden'),
);

/// 平台能力：V1 先用 Fake，P4 接入真实实现。
final platformFacadeProvider = Provider<PlatformFacade>(
  (ref) => FakePlatformFacade(),
);

/// 首页指标：错题总数。
final questionCountProvider = FutureProvider<int>((ref) async {
  final db = ref.watch(databaseProvider);
  return db.countQuestions();
});

/// 首页指标：今日待复习数量。
final dueCountProvider = FutureProvider<int>((ref) async {
  final db = ref.watch(databaseProvider);
  return db.countDue(DateTime.now().toUtc().millisecondsSinceEpoch);
});
