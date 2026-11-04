// ignore_for_file: prefer_initializing_formals
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive_io.dart';
import 'package:crypto/crypto.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

import '../../core/errors/app_error.dart';
import '../../domain/entities/backup.dart';
import '../database/app_database.dart';

/// 完整备份 / 恢复。
///
/// 备份结构：
/// ```
/// manifest.json
/// database.sqlite
/// images/original/<sha256>.<ext>
/// ```
///
/// 恢复不替换正在使用的数据库文件，而是在一个事务里把备份库整表复制进当前库，
/// 这样不会出现关闭数据库 / 重启 App 的问题；失败时 SQLite 自动回滚。
class BackupService {
  BackupService({
    required AppDatabase db,
    required File dbFile,
    required Directory supportDir,
  })  : _db = db,
        _dbFile = dbFile,
        _supportDir = supportDir;

  final AppDatabase _db;
  final File _dbFile;
  final Directory _supportDir;
  static const _uuid = Uuid();

  Directory get _backupDir =>
      Directory(p.join(_supportDir.path, 'backups'));

  /// 导出 / 恢复时整表复制的顺序：先父表，后子表。
  static const _insertOrder = [
    'app_meta',
    'settings_table',
    'knowledge_nodes',
    'tags',
    'questions',
    'image_assets',
    'question_knowledge',
    'question_tags',
    'question_images',
    'review_cards',
    'review_logs',
    'drafts',
    'draft_items',
    'draft_item_images',
    'mastery_snapshots',
    'question_mastery',
  ];

  static const _deleteOrder = [
    'draft_item_images',
    'draft_items',
    'drafts',
    'review_logs',
    'review_cards',
    'question_images',
    'question_tags',
    'question_knowledge',
    'image_assets',
    'questions',
    'tags',
    'knowledge_nodes',
    'mastery_snapshots',
    'question_mastery',
    'settings_table',
    'app_meta',
  ];

  Future<List<BackupInfo>> listBackups() async {
    try {
      if (!_backupDir.existsSync()) return const [];
      final files = await _backupDir
          .list()
          .where((entity) =>
              entity is File && entity.path.toLowerCase().endsWith('.zip'))
          .cast<File>()
          .toList();
      final infos = await Future.wait(
        files.map((file) async {
          final stat = await file.stat();
          return BackupInfo(
            file: file,
            bytes: stat.size,
            modifiedAt: stat.modified,
          );
        }),
      );
      infos.sort((a, b) => b.modifiedAt.compareTo(a.modifiedAt));
      return infos;
    } catch (error) {
      throw AppError(AppErrorKind.backup, '读取备份列表失败', cause: error);
    }
  }

  /// 生成完整备份 ZIP。
  Future<File> exportBackup({void Function(String message)? onProgress}) async {
    final id = _uuid.v4();
    final snapshot = File(p.join(_backupDir.path, '.snapshot-$id.sqlite'));
    final manifestFile = File(p.join(_backupDir.path, '.manifest-$id.json'));
    final tempZip = File(p.join(_backupDir.path, '.tmp-$id.zip'));
    try {
      await _backupDir.create(recursive: true);
      onProgress?.call('正在创建数据库快照…');
      await _checkpoint();
      if (snapshot.existsSync()) await snapshot.delete();
      await _db.customStatement(
        "VACUUM INTO '${_sqlPath(snapshot.path)}'",
      );

      final dbBytes = await snapshot.length();
      final dbSha = await _fileSha(snapshot);
      onProgress?.call('正在整理图片…');
      final imageEntries = <BackupImageEntry>[];
      var missingImages = 0;
      final assets = await _db.select(_db.imageAssets).get();
      for (final asset in assets) {
        final rel = _safeRelative(asset.relPath);
        final file = File(p.joinAll([_supportDir.path, ...rel.split('/')]));
        if (!file.existsSync()) {
          missingImages++;
          continue;
        }
        imageEntries.add(
          BackupImageEntry(
            path: rel,
            sha256: await _fileSha(file),
            bytes: await file.length(),
          ),
        );
      }

      final now = DateTime.now().toUtc();
      final manifest = BackupManifest(
        formatVersion: backupFormatVersion,
        appVersion: '1.1.0',
        schemaVersion: _db.schemaVersion,
        createdAt: now.millisecondsSinceEpoch,
        database: BackupDatabaseInfo(
          path: 'database.sqlite',
          sha256: dbSha,
          bytes: dbBytes,
        ),
        images: imageEntries,
        counts: await _counts(),
        missingImages: missingImages,
      );
      await manifestFile.writeAsString(
        const JsonEncoder.withIndent('  ').convert(manifest.toJson()),
        flush: true,
      );

      onProgress?.call('正在打包 ZIP…');
      if (tempZip.existsSync()) await tempZip.delete();
      final encoder = ZipFileEncoder();
      encoder.create(tempZip.path);
      await encoder.addFile(snapshot, 'database.sqlite');
      for (final entry in imageEntries) {
        await encoder.addFile(
          File(p.joinAll([_supportDir.path, ...entry.path.split('/')])),
          entry.path,
        );
      }
      await encoder.addFile(manifestFile, 'manifest.json');
      await encoder.close();

      onProgress?.call('正在校验备份…');
      await inspectBackup(tempZip);

      final stamp = _timestamp(now.toLocal());
      final target = File(p.join(_backupDir.path, 'MathRecall-backup-$stamp.zip'));
      if (target.existsSync()) await target.delete();
      await tempZip.rename(target.path);
      onProgress?.call('备份完成');
      return target;
    } on AppError {
      rethrow;
    } catch (error) {
      throw AppError(AppErrorKind.backup, '备份失败', cause: error);
    } finally {
      for (final file in [snapshot, manifestFile, tempZip]) {
        try {
          if (file.existsSync()) await file.delete();
        } catch (_) {}
      }
    }
  }

  /// 打开并校验备份，返回预览。
  Future<BackupPreview> inspectBackup(File zip) async {
    if (!zip.existsSync()) {
      throw const AppError(AppErrorKind.backup, '备份文件不存在');
    }
    InputFileStream? input;
    try {
      input = InputFileStream(zip.path);
      final archive = ZipDecoder().decodeBuffer(input);
      final manifestFile = _find(archive, 'manifest.json');
      if (manifestFile == null) {
        throw const AppError(AppErrorKind.backup, '备份缺少 manifest.json');
      }
      final manifest = BackupManifest.fromJson(
        jsonDecode(utf8.decode(_entryBytes(manifestFile)))
            as Map<String, dynamic>,
      );
      if (manifest.formatVersion <= 0 ||
          manifest.formatVersion > backupFormatVersion) {
        throw AppError(
          AppErrorKind.backup,
          '备份格式版本不支持：${manifest.formatVersion}',
        );
      }
      final warnings = <String>[];
      final dbEntry = _find(archive, manifest.database.path);
      if (dbEntry == null) {
        throw const AppError(AppErrorKind.backup, '备份缺少数据库文件');
      }
      final dbBytes = _entryBytes(dbEntry);
      final actualDbSha = sha256.convert(dbBytes).toString();
      if (actualDbSha != manifest.database.sha256) {
        throw const AppError(AppErrorKind.backup, '数据库校验失败');
      }
      for (final entry in manifest.images) {
        final file = _find(archive, entry.path);
        if (file == null) {
          warnings.add('缺少图片：${entry.path}');
          continue;
        }
        final actual = sha256.convert(_entryBytes(file)).toString();
        if (actual != entry.sha256) {
          throw AppError(
            AppErrorKind.backup,
            '图片校验失败：${entry.path}',
          );
        }
      }
      final compatible = manifest.schemaVersion <= _db.schemaVersion;
      return BackupPreview(
        file: zip,
        manifest: manifest,
        compatible: compatible,
        warnings: warnings,
        error: compatible
            ? null
            : '备份 schema ${manifest.schemaVersion} 高于当前 ${_db.schemaVersion}',
      );
    } on AppError {
      rethrow;
    } catch (error) {
      throw AppError(AppErrorKind.backup, '备份校验失败', cause: error);
    } finally {
      try {
        input?.close();
      } catch (_) {}
    }
  }

  /// 恢复备份。调用方必须已经让用户确认 [confirmed]。
  Future<RestoreReport> restoreBackup(
    File zip, {
    required bool confirmed,
  }) async {
    if (!confirmed) {
      throw const AppError(AppErrorKind.validation, '请先确认恢复');
    }
    final preview = await inspectBackup(zip);
    if (!preview.canRestore) {
      throw AppError(
        AppErrorKind.backup,
        preview.error ?? '备份与当前版本不兼容',
      );
    }

    final id = _uuid.v4();
    final staging = Directory(p.join(_supportDir.path, '.restore-$id'));
    InputFileStream? input;
    try {
      await staging.create(recursive: true);
      final stagingDb = File(p.join(staging.path, 'database.sqlite'));
      final stagingImages = <String, File>{};
      input = InputFileStream(zip.path);
      final archive = ZipDecoder().decodeBuffer(input);
      final dbEntry = _find(archive, preview.manifest.database.path);
      if (dbEntry == null) {
        throw const AppError(AppErrorKind.backup, '备份缺少数据库文件');
      }
      await stagingDb.writeAsBytes(_entryBytes(dbEntry), flush: true);
      for (final entry in preview.manifest.images) {
        final archiveFile = _find(archive, entry.path);
        if (archiveFile == null) continue;
        final target = File(
          p.joinAll([staging.path, ..._safeRelative(entry.path).split('/')]),
        );
        await target.parent.create(recursive: true);
        await target.writeAsBytes(_entryBytes(archiveFile), flush: true);
        stagingImages[entry.sha256] = target;
      }

      // 先在临时库上应用迁移，校验 schema，避免把损坏/过新的库带进主库。
      await _migrateSnapshot(stagingDb);

      // 备份当前数据库，失败时仍可人工回滚。
      await _backupCurrentDatabase();

      var restoredImages = 0;
      var missingImages = 0;
      for (final entry in preview.manifest.images) {
        final source = stagingImages[entry.sha256];
        if (source == null) {
          missingImages++;
          continue;
        }
        final rel = _safeRelative(entry.path);
        final target = File(p.joinAll([_supportDir.path, ...rel.split('/')]));
        if (target.existsSync() && await _fileSha(target) == entry.sha256) {
          restoredImages++;
          continue;
        }
        await target.parent.create(recursive: true);
        await source.copy(target.path);
        if (await _fileSha(target) != entry.sha256) {
          throw const AppError(AppErrorKind.backup, '恢复图片校验失败');
        }
        restoredImages++;
      }

      await _replaceDatabase(stagingDb);
      return RestoreReport(
        manifest: preview.manifest,
        restoredQuestions: preview.manifest.counts['questions'] ?? 0,
        restoredImages: restoredImages,
        missingImages: missingImages,
      );
    } on AppError {
      rethrow;
    } catch (error) {
      throw AppError(AppErrorKind.backup, '恢复失败，原数据未被修改', cause: error);
    } finally {
      try {
        input?.close();
      } catch (_) {}
      try {
        if (staging.existsSync()) await staging.delete(recursive: true);
      } catch (_) {}
    }
  }

  Future<void> _migrateSnapshot(File dbFile) async {
    final snapshotDb = AppDatabase(NativeDatabase(dbFile));
    try {
      await snapshotDb.customSelect('SELECT 1').get();
      await snapshotDb.close();
    } catch (error) {
      try {
        await snapshotDb.close();
      } catch (_) {}
      throw AppError(AppErrorKind.backup, '备份数据库迁移失败', cause: error);
    }
  }

  Future<void> _replaceDatabase(File snapshotDb) async {
    final alias = 'backup_${_uuid.v4().replaceAll('-', '')}';
    var attached = false;
    try {
      await _db.customStatement('PRAGMA foreign_keys = OFF');
      await _db.customStatement(
        "ATTACH DATABASE '${_sqlPath(snapshotDb.path)}' AS $alias",
      );
      attached = true;
      await _db.transaction(() async {
        for (final table in _deleteOrder) {
          await _db.customStatement('DELETE FROM main."$table"');
        }
        for (final table in _insertOrder) {
          await _db.customStatement(
            'INSERT INTO main."$table" SELECT * FROM $alias."$table"',
          );
        }
        final fk = await _db.customSelect('PRAGMA foreign_key_check').get();
        if (fk.isNotEmpty) {
          throw const AppError(AppErrorKind.backup, '备份外键校验失败');
        }
      });
    } finally {
      if (attached) {
        try {
          await _db.customStatement('DETACH DATABASE $alias');
        } catch (_) {}
      }
      try {
        await _db.customStatement('PRAGMA foreign_keys = ON');
      } catch (_) {}
    }
    final quick = await _db.customSelect('PRAGMA quick_check').get();
    final value = quick.isEmpty ? '' : quick.first.data.values.first;
    if (value.toString().toLowerCase() != 'ok') {
      throw const AppError(AppErrorKind.backup, '恢复后完整性校验失败');
    }
  }

  Future<void> _backupCurrentDatabase() async {
    if (!_dbFile.existsSync()) return;
    final backup = File(
      '${_dbFile.path}.bak-${DateTime.now().millisecondsSinceEpoch}',
    );
    await _dbFile.copy(backup.path);
  }

  Future<void> _checkpoint() async {
    try {
      await _db.customSelect('PRAGMA wal_checkpoint(TRUNCATE)').get();
    } catch (_) {
      // 内存库/非 WAL 模式下无关紧要。
    }
  }

  Future<Map<String, int>> _counts() async {
    final result = <String, int>{};
    for (final table in ['questions', 'review_logs', 'knowledge_nodes', 'image_assets']) {
      final rows = await _db.customSelect('SELECT COUNT(*) AS c FROM "$table"').get();
      result[table == 'questions' ? 'questions' : table] =
          (rows.first.data['c'] as num?)?.toInt() ?? 0;
    }
    return result;
  }

  Future<String> _fileSha(File file) async {
    final digest = await sha256.bind(file.openRead()).first;
    return digest.toString();
  }

  ArchiveFile? _find(Archive archive, String name) {
    for (final file in archive.files) {
      if (file.name == name) return file;
    }
    return null;
  }

  Uint8List _entryBytes(ArchiveFile file) {
    final content = file.content;
    if (content is Uint8List) return content;
    if (content is List<int>) return Uint8List.fromList(content);
    throw AppError(AppErrorKind.backup, '无法读取备份条目：${file.name}');
  }

  String _safeRelative(String path) {
    final normalized = p.posix.normalize(path.replaceAll('\\', '/'));
    if (normalized.isEmpty ||
        normalized.startsWith('/') ||
        normalized == '..' ||
        normalized.startsWith('../') ||
        normalized.contains('/../')) {
      throw AppError(AppErrorKind.backup, '备份包含非法路径：$path');
    }
    return normalized;
  }

  String _sqlPath(String path) => path.replaceAll("'", "''");

  String _timestamp(DateTime time) {
    String two(int value) => value.toString().padLeft(2, '0');
    final millis = time.millisecond.toString().padLeft(3, '0');
    return '${time.year}${two(time.month)}${two(time.day)}-'
        '${two(time.hour)}${two(time.minute)}${two(time.second)}-$millis';
  }
}
