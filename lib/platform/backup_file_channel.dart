import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;

import '../core/errors/app_error.dart';

/// 通过 Android SAF 导出/导入备份文件，不依赖第三方文件选择插件。
class BackupFileChannel {
  const BackupFileChannel();

  static const MethodChannel _channel = MethodChannel('mathrecall/backup');

  /// 让用户选择备份 ZIP；取消返回 null。
  Future<File?> pickBackup() async {
    try {
      final path = await _channel.invokeMethod<String>('importBackup');
      if (path == null || path.isEmpty) return null;
      final file = File(path);
      return await file.exists() ? file : null;
    } on PlatformException catch (error) {
      throw AppError(
        AppErrorKind.backup,
        error.message ?? '选择备份文件失败',
        cause: error,
      );
    } on MissingPluginException catch (error) {
      throw AppError(
        AppErrorKind.backup,
        '当前平台不支持文件选择',
        cause: error,
      );
    }
  }

  /// 让用户选择保存位置；返回是否保存成功。
  Future<bool> saveBackup(File file) async {
    try {
      final saved = await _channel.invokeMethod<bool>(
        'saveBackup',
        {
          'sourcePath': file.path,
          'fileName': p.basename(file.path),
        },
      );
      return saved ?? false;
    } on PlatformException catch (error) {
      throw AppError(
        AppErrorKind.backup,
        error.message ?? '保存备份失败',
        cause: error,
      );
    } on MissingPluginException catch (error) {
      throw AppError(
        AppErrorKind.backup,
        '当前平台不支持文件保存',
        cause: error,
      );
    }
  }
}
