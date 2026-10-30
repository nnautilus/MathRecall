import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

import '../../core/errors/app_error.dart';
import '../../domain/entities/stored_image.dart';
import '../../domain/repositories/image_store.dart';
import '../../infrastructure/database/app_database.dart';

/// 图片文件存储：原图放 `images/original/<sha256>.<ext>`，DB 只存相对路径。
class ImageStorage implements ImageStore {
  ImageStorage(this._supportDir, this._db);

  final Directory _supportDir;
  final AppDatabase _db;
  static const _uuid = Uuid();

  Directory get _originalDir =>
      Directory(p.join(_supportDir.path, 'images', 'original'));

  Directory get _displayDir =>
      Directory(p.join(_supportDir.path, 'images', 'display'));

  @override
  File resolve(String relPath) => File(p.join(_supportDir.path, relPath));

  @override
  Future<File?> fileForSha(String sha256) async {
    final row = await (_db.select(_db.imageAssets)
          ..where((t) => t.sha256.equals(sha256)))
        .getSingleOrNull();
    if (row == null) return null;
    final file = resolve(row.relPath);
    return file.existsSync() ? file : null;
  }

  File displayPath(String sha256) =>
      File(p.join(_displayDir.path, '$sha256.jpg'));

  @override
  Future<StoredImage> storeBytes(List<int> bytes, {String? sourceName}) async {
    if (bytes.isEmpty) {
      throw const AppError(AppErrorKind.validation, '图片为空');
    }
    final data = bytes is Uint8List ? bytes : Uint8List.fromList(bytes);
    final digest = sha256.convert(data).toString();
    final ext = _extensionOf(sourceName) ?? _detectExtension(data);
    final mime = _mimeOf(ext);
    final relPath = p.join('images', 'original', '$digest.$ext');
    final target = resolve(relPath);
    await target.parent.create(recursive: true);

    if (!target.existsSync()) {
      final temp = File('${target.path}.${_uuid.v4()}.tmp');
      await temp.writeAsBytes(bytes, flush: true);
      await temp.rename(target.path);
    }

    await _db.into(_db.imageAssets).insert(
          ImageAssetsCompanion.insert(
            sha256: digest,
            relPath: relPath,
            bytes: Value(bytes.length),
            mime: Value(mime),
            createdAt: Value(DateTime.now().toUtc().millisecondsSinceEpoch),
          ),
          mode: InsertMode.insertOrIgnore,
        );

    return StoredImage(
      sha256: digest,
      relPath: relPath,
      bytes: bytes.length,
      mime: mime,
    );
  }

  @override
  Future<StoredImage> storeFile(File source) async {
    final bytes = await source.readAsBytes();
    return storeBytes(bytes, sourceName: source.path);
  }

  @override
  Future<File> ensureDisplay(String sha256, String originalRelPath) async {
    final display = displayPath(sha256);
    if (display.existsSync()) {
      return display;
    }
    return resolve(originalRelPath);
  }

  @override
  Future<int> cleanup() async {
    var removed = 0;
    if (_originalDir.existsSync()) {
      final assets = await _db.select(_db.imageAssets).get();
      final known = assets.map((a) => a.sha256).toSet();
      await for (final entity in _originalDir.list()) {
        if (entity is! File) continue;
        final name = p.basenameWithoutExtension(entity.path);
        if (name.endsWith('.tmp')) {
          await entity.delete();
          removed++;
        } else if (!known.contains(name)) {
          await entity.delete();
          removed++;
        }
      }
    }
    return removed;
  }

  String? _extensionOf(String? name) {
    if (name == null) return null;
    final ext = p.extension(name).toLowerCase();
    return switch (ext) {
      '.jpg' || '.jpeg' => 'jpg',
      '.png' => 'png',
      '.webp' => 'webp',
      '.heic' => 'heic',
      _ => null,
    };
  }

  String _detectExtension(Uint8List bytes) {
    if (bytes.length > 8 &&
        bytes[0] == 0x89 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x4E &&
        bytes[3] == 0x47) {
      return 'png';
    }
    if (bytes.length > 12 &&
        String.fromCharCodes(bytes.sublist(0, 4)) == 'RIFF' &&
        String.fromCharCodes(bytes.sublist(8, 12)) == 'WEBP') {
      return 'webp';
    }
    return 'jpg';
  }

  String _mimeOf(String ext) {
    return switch (ext) {
      'png' => 'image/png',
      'webp' => 'image/webp',
      'heic' => 'image/heic',
      _ => 'image/jpeg',
    };
  }
}
