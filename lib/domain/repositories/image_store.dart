import 'dart:io';

import '../entities/stored_image.dart';

/// 图片存储端口：原图落盘、内容寻址、按相对路径解析。
abstract interface class ImageStore {
  Future<StoredImage> storeFile(File file);

  Future<StoredImage> storeBytes(List<int> bytes, {String? sourceName});

  File resolve(String relPath);

  /// 按内容哈希查图片文件；不存在返回 null。
  Future<File?> fileForSha(String sha256);

  /// 展示图路径；V1 可回退原图。
  Future<File> ensureDisplay(String sha256, String originalRelPath);

  Future<int> cleanup();
}
