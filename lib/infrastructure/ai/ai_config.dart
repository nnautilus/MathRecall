import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/errors/app_error.dart';
import '../database/app_database.dart';

/// AI 配置（API Key 单独存 Keystore）。
class AiConfig {
  const AiConfig({
    this.providerName = 'openai-compatible',
    this.baseUrl = '',
    this.model = '',
    this.apiKey = '',
  });

  final String providerName;
  final String baseUrl;
  final String model;
  final String apiKey;

  bool get isConfigured =>
      baseUrl.trim().isNotEmpty && model.trim().isNotEmpty && apiKey.trim().isNotEmpty;

  AiConfig copyWith({
    String? providerName,
    String? baseUrl,
    String? model,
    String? apiKey,
  }) {
    return AiConfig(
      providerName: providerName ?? this.providerName,
      baseUrl: baseUrl ?? this.baseUrl,
      model: model ?? this.model,
      apiKey: apiKey ?? this.apiKey,
    );
  }
}

/// AI 配置持久化：普通字段进 settings 表，Key 进 Android Keystore。
class AiConfigStore {
  AiConfigStore(this._db, [FlutterSecureStorage? storage])
      : _storage = storage ?? const FlutterSecureStorage();

  final AppDatabase _db;
  final FlutterSecureStorage _storage;

  static const _providerKey = 'ai.provider';
  static const _baseUrlKey = 'ai.baseUrl';
  static const _modelKey = 'ai.model';
  static const _apiKeyKey = 'mathrecall.ai.apiKey';

  Future<AiConfig> load() async {
    final rows = await _db.select(_db.settingsTable).get();
    final values = <String, Object?>{};
    for (final row in rows) {
      try {
        values[row.key] = jsonDecode(row.valueJson);
      } catch (_) {
        values[row.key] = null;
      }
    }
    String? apiKey;
    try {
      apiKey = await _storage.read(key: _apiKeyKey);
    } catch (_) {
      apiKey = null;
    }
    return AiConfig(
      providerName: (values[_providerKey] as String?) ?? 'openai-compatible',
      baseUrl: (values[_baseUrlKey] as String?) ?? '',
      model: (values[_modelKey] as String?) ?? '',
      apiKey: apiKey ?? '',
    );
  }

  Future<void> save(AiConfig config) async {
    if (!config.isConfigured) {
      throw const AppError(AppErrorKind.validation, '请填写完整的 AI 配置');
    }
    final now = DateTime.now().toUtc().millisecondsSinceEpoch;
    await _db.transaction(() async {
      await _writeSetting(_providerKey, config.providerName, now);
      await _writeSetting(_baseUrlKey, config.baseUrl.trim(), now);
      await _writeSetting(_modelKey, config.model.trim(), now);
    });
    try {
      await _storage.write(key: _apiKeyKey, value: config.apiKey.trim());
    } catch (error) {
      throw AppError(
        AppErrorKind.storage,
        'API Key 保存失败',
        cause: error,
      );
    }
  }

  Future<void> clearApiKey() async {
    try {
      await _storage.delete(key: _apiKeyKey);
    } catch (_) {}
  }

  Future<void> _writeSetting(String key, Object? value, int now) async {
    await _db.into(_db.settingsTable).insertOnConflictUpdate(
          SettingsTableCompanion.insert(
            key: key,
            valueJson: Value(jsonEncode(value)),
            updatedAt: Value(now),
          ),
        );
  }
}
