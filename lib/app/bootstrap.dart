import 'dart:io';

import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../infrastructure/database/app_database.dart';
import '../infrastructure/media/image_storage.dart';
import '../infrastructure/repositories/draft_repository_impl.dart';

/// 打开本地数据库：`ApplicationSupport/db/mathrecall.sqlite`。
///
/// 图片目录（images/drafts/backups）将在 P4/P7 阶段初始化。
Future<AppDatabase> openAppDatabase() async {
  final support = await getApplicationSupportDirectory();
  final dbDir = Directory(p.join(support.path, 'db'));
  if (!dbDir.existsSync()) {
    dbDir.createSync(recursive: true);
  }
  final dbFile = File(p.join(dbDir.path, 'mathrecall.sqlite'));
  final db = AppDatabase(NativeDatabase.createInBackground(dbFile));
  try {
    await DraftRepositoryImpl(db).cleanupExpired(
      DateTime.now().toUtc().millisecondsSinceEpoch,
    );
    await ImageStorage(support, db).cleanup();
  } catch (_) {
    // 启动维护失败不阻塞 App 使用。
  }
  return db;
}
