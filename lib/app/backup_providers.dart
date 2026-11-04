import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../infrastructure/backup/backup_service.dart';
import 'providers.dart';

/// 备份服务：数据库 + 应用支持目录。
final backupServiceProvider = FutureProvider<BackupService>((ref) async {
  final support = await getApplicationSupportDirectory();
  final db = ref.watch(databaseProvider);
  return BackupService(
    db: db,
    dbFile: File(p.join(support.path, 'db', 'mathrecall.sqlite')),
    supportDir: support,
  );
});
