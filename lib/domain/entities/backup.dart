import 'dart:io';

/// 备份格式版本。恢复时只接受 <= 当前版本。
const int backupFormatVersion = 1;

/// manifest.json 中的数据库信息。
class BackupDatabaseInfo {
  const BackupDatabaseInfo({
    required this.path,
    required this.sha256,
    required this.bytes,
  });

  final String path;
  final String sha256;
  final int bytes;

  factory BackupDatabaseInfo.fromJson(Map<String, dynamic> json) {
    return BackupDatabaseInfo(
      path: (json['path'] ?? 'database.sqlite').toString(),
      sha256: (json['sha256'] ?? '').toString(),
      bytes: (json['bytes'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'path': path,
        'sha256': sha256,
        'bytes': bytes,
      };
}

/// manifest.json 中的图片条目。
class BackupImageEntry {
  const BackupImageEntry({
    required this.path,
    required this.sha256,
    required this.bytes,
  });

  final String path;
  final String sha256;
  final int bytes;

  factory BackupImageEntry.fromJson(Map<String, dynamic> json) {
    return BackupImageEntry(
      path: (json['path'] ?? '').toString(),
      sha256: (json['sha256'] ?? '').toString(),
      bytes: (json['bytes'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'path': path,
        'sha256': sha256,
        'bytes': bytes,
      };
}

/// 完整备份清单。
class BackupManifest {
  const BackupManifest({
    required this.formatVersion,
    required this.appVersion,
    required this.schemaVersion,
    required this.createdAt,
    required this.database,
    required this.images,
    required this.counts,
    this.missingImages = 0,
  });

  static const String formatName = 'mathrecall-backup';

  final int formatVersion;
  final String appVersion;
  final int schemaVersion;
  final int createdAt;
  final BackupDatabaseInfo database;
  final List<BackupImageEntry> images;
  final Map<String, int> counts;
  final int missingImages;

  factory BackupManifest.fromJson(Map<String, dynamic> json) {
    final imagesJson = json['images'];
    final countsJson = json['counts'];
    return BackupManifest(
      formatVersion: (json['formatVersion'] as num?)?.toInt() ?? 0,
      appVersion: (json['appVersion'] ?? '').toString(),
      schemaVersion: (json['schemaVersion'] as num?)?.toInt() ?? 0,
      createdAt: (json['createdAt'] as num?)?.toInt() ?? 0,
      database: BackupDatabaseInfo.fromJson(
        (json['database'] as Map?)?.cast<String, dynamic>() ?? const {},
      ),
      images: imagesJson is List
          ? imagesJson
              .whereType<Map>()
              .map((item) => BackupImageEntry.fromJson(
                    item.cast<String, dynamic>(),
                  ))
              .toList()
          : const [],
      counts: countsJson is Map
          ? countsJson.map(
              (key, value) =>
                  MapEntry(key.toString(), (value as num?)?.toInt() ?? 0),
            )
          : const {},
      missingImages: (json['missingImages'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'format': formatName,
        'formatVersion': formatVersion,
        'appVersion': appVersion,
        'schemaVersion': schemaVersion,
        'createdAt': createdAt,
        'database': database.toJson(),
        'images': images.map((item) => item.toJson()).toList(),
        'counts': counts,
        'missingImages': missingImages,
      };

  DateTime get createdAtDateTime =>
      DateTime.fromMillisecondsSinceEpoch(createdAt, isUtc: true).toLocal();
}

/// 备份文件（本地备份目录中的一个 ZIP）。
class BackupInfo {
  const BackupInfo({
    required this.file,
    required this.bytes,
    required this.modifiedAt,
  });

  final File file;
  final int bytes;
  final DateTime modifiedAt;

  String get name => file.uri.pathSegments.last;
}

/// 恢复前的预览信息。
class BackupPreview {
  const BackupPreview({
    required this.file,
    required this.manifest,
    required this.compatible,
    this.error,
    this.warnings = const [],
  });

  final File file;
  final BackupManifest manifest;
  final bool compatible;
  final String? error;
  final List<String> warnings;

  bool get canRestore => compatible && error == null;
}

/// 恢复完成报告。
class RestoreReport {
  const RestoreReport({
    required this.manifest,
    required this.restoredQuestions,
    required this.restoredImages,
    required this.missingImages,
  });

  final BackupManifest manifest;
  final int restoredQuestions;
  final int restoredImages;
  final int missingImages;
}
