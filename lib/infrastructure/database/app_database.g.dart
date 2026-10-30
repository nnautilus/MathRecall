// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AppMetaTable extends AppMeta with TableInfo<$AppMetaTable, AppMetaRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppMetaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_meta';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppMetaRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppMetaRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppMetaRow(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AppMetaTable createAlias(String alias) {
    return $AppMetaTable(attachedDatabase, alias);
  }
}

class AppMetaRow extends DataClass implements Insertable<AppMetaRow> {
  final String key;
  final String value;
  final int updatedAt;
  const AppMetaRow({
    required this.key,
    required this.value,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  AppMetaCompanion toCompanion(bool nullToAbsent) {
    return AppMetaCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppMetaRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppMetaRow(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  AppMetaRow copyWith({String? key, String? value, int? updatedAt}) =>
      AppMetaRow(
        key: key ?? this.key,
        value: value ?? this.value,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  AppMetaRow copyWithCompanion(AppMetaCompanion data) {
    return AppMetaRow(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppMetaRow(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppMetaRow &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class AppMetaCompanion extends UpdateCompanion<AppMetaRow> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const AppMetaCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppMetaCompanion.insert({
    required String key,
    required String value,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<AppMetaRow> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppMetaCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return AppMetaCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppMetaCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SettingsTableTable extends SettingsTable
    with TableInfo<$SettingsTableTable, SettingsRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueJsonMeta = const VerificationMeta(
    'valueJson',
  );
  @override
  late final GeneratedColumn<String> valueJson = GeneratedColumn<String>(
    'value_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('null'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [key, valueJson, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SettingsRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value_json')) {
      context.handle(
        _valueJsonMeta,
        valueJson.isAcceptableOrUnknown(data['value_json']!, _valueJsonMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SettingsRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingsRow(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      valueJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value_json'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SettingsTableTable createAlias(String alias) {
    return $SettingsTableTable(attachedDatabase, alias);
  }
}

class SettingsRow extends DataClass implements Insertable<SettingsRow> {
  final String key;
  final String valueJson;
  final int updatedAt;
  const SettingsRow({
    required this.key,
    required this.valueJson,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value_json'] = Variable<String>(valueJson);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  SettingsTableCompanion toCompanion(bool nullToAbsent) {
    return SettingsTableCompanion(
      key: Value(key),
      valueJson: Value(valueJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory SettingsRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingsRow(
      key: serializer.fromJson<String>(json['key']),
      valueJson: serializer.fromJson<String>(json['valueJson']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'valueJson': serializer.toJson<String>(valueJson),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  SettingsRow copyWith({String? key, String? valueJson, int? updatedAt}) =>
      SettingsRow(
        key: key ?? this.key,
        valueJson: valueJson ?? this.valueJson,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  SettingsRow copyWithCompanion(SettingsTableCompanion data) {
    return SettingsRow(
      key: data.key.present ? data.key.value : this.key,
      valueJson: data.valueJson.present ? data.valueJson.value : this.valueJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingsRow(')
          ..write('key: $key, ')
          ..write('valueJson: $valueJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, valueJson, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingsRow &&
          other.key == this.key &&
          other.valueJson == this.valueJson &&
          other.updatedAt == this.updatedAt);
}

class SettingsTableCompanion extends UpdateCompanion<SettingsRow> {
  final Value<String> key;
  final Value<String> valueJson;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const SettingsTableCompanion({
    this.key = const Value.absent(),
    this.valueJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsTableCompanion.insert({
    required String key,
    this.valueJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key);
  static Insertable<SettingsRow> custom({
    Expression<String>? key,
    Expression<String>? valueJson,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (valueJson != null) 'value_json': valueJson,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsTableCompanion copyWith({
    Value<String>? key,
    Value<String>? valueJson,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return SettingsTableCompanion(
      key: key ?? this.key,
      valueJson: valueJson ?? this.valueJson,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (valueJson.present) {
      map['value_json'] = Variable<String>(valueJson.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsTableCompanion(')
          ..write('key: $key, ')
          ..write('valueJson: $valueJson, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $KnowledgeNodesTable extends KnowledgeNodes
    with TableInfo<$KnowledgeNodesTable, KnowledgeNodeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KnowledgeNodesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parentIdMeta = const VerificationMeta(
    'parentId',
  );
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
    'parent_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES knowledge_nodes (id)',
    ),
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isSystemMeta = const VerificationMeta(
    'isSystem',
  );
  @override
  late final GeneratedColumn<bool> isSystem = GeneratedColumn<bool>(
    'is_system',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_system" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    parentId,
    level,
    name,
    sortOrder,
    isSystem,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'knowledge_nodes';
  @override
  VerificationContext validateIntegrity(
    Insertable<KnowledgeNodeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(
        _parentIdMeta,
        parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta),
      );
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('is_system')) {
      context.handle(
        _isSystemMeta,
        isSystem.isAcceptableOrUnknown(data['is_system']!, _isSystemMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KnowledgeNodeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KnowledgeNodeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      parentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_id'],
      ),
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      isSystem: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_system'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $KnowledgeNodesTable createAlias(String alias) {
    return $KnowledgeNodesTable(attachedDatabase, alias);
  }
}

class KnowledgeNodeRow extends DataClass
    implements Insertable<KnowledgeNodeRow> {
  final String id;
  final String? parentId;
  final int level;
  final String name;
  final int sortOrder;
  final bool isSystem;
  final bool isActive;
  final int createdAt;
  final int updatedAt;
  const KnowledgeNodeRow({
    required this.id,
    this.parentId,
    required this.level,
    required this.name,
    required this.sortOrder,
    required this.isSystem,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    map['level'] = Variable<int>(level);
    map['name'] = Variable<String>(name);
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_system'] = Variable<bool>(isSystem);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  KnowledgeNodesCompanion toCompanion(bool nullToAbsent) {
    return KnowledgeNodesCompanion(
      id: Value(id),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      level: Value(level),
      name: Value(name),
      sortOrder: Value(sortOrder),
      isSystem: Value(isSystem),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory KnowledgeNodeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KnowledgeNodeRow(
      id: serializer.fromJson<String>(json['id']),
      parentId: serializer.fromJson<String?>(json['parentId']),
      level: serializer.fromJson<int>(json['level']),
      name: serializer.fromJson<String>(json['name']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isSystem: serializer.fromJson<bool>(json['isSystem']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'parentId': serializer.toJson<String?>(parentId),
      'level': serializer.toJson<int>(level),
      'name': serializer.toJson<String>(name),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isSystem': serializer.toJson<bool>(isSystem),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  KnowledgeNodeRow copyWith({
    String? id,
    Value<String?> parentId = const Value.absent(),
    int? level,
    String? name,
    int? sortOrder,
    bool? isSystem,
    bool? isActive,
    int? createdAt,
    int? updatedAt,
  }) => KnowledgeNodeRow(
    id: id ?? this.id,
    parentId: parentId.present ? parentId.value : this.parentId,
    level: level ?? this.level,
    name: name ?? this.name,
    sortOrder: sortOrder ?? this.sortOrder,
    isSystem: isSystem ?? this.isSystem,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  KnowledgeNodeRow copyWithCompanion(KnowledgeNodesCompanion data) {
    return KnowledgeNodeRow(
      id: data.id.present ? data.id.value : this.id,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      level: data.level.present ? data.level.value : this.level,
      name: data.name.present ? data.name.value : this.name,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isSystem: data.isSystem.present ? data.isSystem.value : this.isSystem,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KnowledgeNodeRow(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('level: $level, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isSystem: $isSystem, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    parentId,
    level,
    name,
    sortOrder,
    isSystem,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KnowledgeNodeRow &&
          other.id == this.id &&
          other.parentId == this.parentId &&
          other.level == this.level &&
          other.name == this.name &&
          other.sortOrder == this.sortOrder &&
          other.isSystem == this.isSystem &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class KnowledgeNodesCompanion extends UpdateCompanion<KnowledgeNodeRow> {
  final Value<String> id;
  final Value<String?> parentId;
  final Value<int> level;
  final Value<String> name;
  final Value<int> sortOrder;
  final Value<bool> isSystem;
  final Value<bool> isActive;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const KnowledgeNodesCompanion({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    this.level = const Value.absent(),
    this.name = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isSystem = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KnowledgeNodesCompanion.insert({
    required String id,
    this.parentId = const Value.absent(),
    required int level,
    required String name,
    this.sortOrder = const Value.absent(),
    this.isSystem = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       level = Value(level),
       name = Value(name);
  static Insertable<KnowledgeNodeRow> custom({
    Expression<String>? id,
    Expression<String>? parentId,
    Expression<int>? level,
    Expression<String>? name,
    Expression<int>? sortOrder,
    Expression<bool>? isSystem,
    Expression<bool>? isActive,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (parentId != null) 'parent_id': parentId,
      if (level != null) 'level': level,
      if (name != null) 'name': name,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isSystem != null) 'is_system': isSystem,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KnowledgeNodesCompanion copyWith({
    Value<String>? id,
    Value<String?>? parentId,
    Value<int>? level,
    Value<String>? name,
    Value<int>? sortOrder,
    Value<bool>? isSystem,
    Value<bool>? isActive,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return KnowledgeNodesCompanion(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      level: level ?? this.level,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
      isSystem: isSystem ?? this.isSystem,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isSystem.present) {
      map['is_system'] = Variable<bool>(isSystem.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KnowledgeNodesCompanion(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('level: $level, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isSystem: $isSystem, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, TagRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<TagRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TagRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TagRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }
}

class TagRow extends DataClass implements Insertable<TagRow> {
  final String id;
  final String name;
  final int createdAt;
  const TagRow({required this.id, required this.name, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
    );
  }

  factory TagRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TagRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  TagRow copyWith({String? id, String? name, int? createdAt}) => TagRow(
    id: id ?? this.id,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
  );
  TagRow copyWithCompanion(TagsCompanion data) {
    return TagRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TagRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TagRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt);
}

class TagsCompanion extends UpdateCompanion<TagRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> createdAt;
  final Value<int> rowid;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TagsCompanion.insert({
    required String id,
    required String name,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<TagRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TagsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return TagsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuestionsTable extends Questions
    with TableInfo<$QuestionsTable, QuestionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _promptLatexMeta = const VerificationMeta(
    'promptLatex',
  );
  @override
  late final GeneratedColumn<String> promptLatex = GeneratedColumn<String>(
    'prompt_latex',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _answerLatexMeta = const VerificationMeta(
    'answerLatex',
  );
  @override
  late final GeneratedColumn<String> answerLatex = GeneratedColumn<String>(
    'answer_latex',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _solutionLatexMeta = const VerificationMeta(
    'solutionLatex',
  );
  @override
  late final GeneratedColumn<String> solutionLatex = GeneratedColumn<String>(
    'solution_latex',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hintLatexMeta = const VerificationMeta(
    'hintLatex',
  );
  @override
  late final GeneratedColumn<String> hintLatex = GeneratedColumn<String>(
    'hint_latex',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<int> difficulty = GeneratedColumn<int>(
    'difficulty',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceTextMeta = const VerificationMeta(
    'sourceText',
  );
  @override
  late final GeneratedColumn<String> sourceText = GeneratedColumn<String>(
    'source_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _errorReasonMeta = const VerificationMeta(
    'errorReason',
  );
  @override
  late final GeneratedColumn<String> errorReason = GeneratedColumn<String>(
    'error_reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isStarredMeta = const VerificationMeta(
    'isStarred',
  );
  @override
  late final GeneratedColumn<bool> isStarred = GeneratedColumn<bool>(
    'is_starred',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_starred" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    promptLatex,
    answerLatex,
    solutionLatex,
    hintLatex,
    difficulty,
    sourceText,
    errorReason,
    isStarred,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'questions';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuestionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('prompt_latex')) {
      context.handle(
        _promptLatexMeta,
        promptLatex.isAcceptableOrUnknown(
          data['prompt_latex']!,
          _promptLatexMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_promptLatexMeta);
    }
    if (data.containsKey('answer_latex')) {
      context.handle(
        _answerLatexMeta,
        answerLatex.isAcceptableOrUnknown(
          data['answer_latex']!,
          _answerLatexMeta,
        ),
      );
    }
    if (data.containsKey('solution_latex')) {
      context.handle(
        _solutionLatexMeta,
        solutionLatex.isAcceptableOrUnknown(
          data['solution_latex']!,
          _solutionLatexMeta,
        ),
      );
    }
    if (data.containsKey('hint_latex')) {
      context.handle(
        _hintLatexMeta,
        hintLatex.isAcceptableOrUnknown(data['hint_latex']!, _hintLatexMeta),
      );
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    }
    if (data.containsKey('source_text')) {
      context.handle(
        _sourceTextMeta,
        sourceText.isAcceptableOrUnknown(data['source_text']!, _sourceTextMeta),
      );
    }
    if (data.containsKey('error_reason')) {
      context.handle(
        _errorReasonMeta,
        errorReason.isAcceptableOrUnknown(
          data['error_reason']!,
          _errorReasonMeta,
        ),
      );
    }
    if (data.containsKey('is_starred')) {
      context.handle(
        _isStarredMeta,
        isStarred.isAcceptableOrUnknown(data['is_starred']!, _isStarredMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuestionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      promptLatex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prompt_latex'],
      )!,
      answerLatex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}answer_latex'],
      ),
      solutionLatex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}solution_latex'],
      ),
      hintLatex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hint_latex'],
      ),
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}difficulty'],
      ),
      sourceText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_text'],
      ),
      errorReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_reason'],
      ),
      isStarred: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_starred'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $QuestionsTable createAlias(String alias) {
    return $QuestionsTable(attachedDatabase, alias);
  }
}

class QuestionRow extends DataClass implements Insertable<QuestionRow> {
  final String id;
  final String promptLatex;
  final String? answerLatex;
  final String? solutionLatex;
  final String? hintLatex;
  final int? difficulty;
  final String? sourceText;
  final String? errorReason;
  final bool isStarred;
  final int createdAt;
  final int updatedAt;
  final int? deletedAt;
  const QuestionRow({
    required this.id,
    required this.promptLatex,
    this.answerLatex,
    this.solutionLatex,
    this.hintLatex,
    this.difficulty,
    this.sourceText,
    this.errorReason,
    required this.isStarred,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['prompt_latex'] = Variable<String>(promptLatex);
    if (!nullToAbsent || answerLatex != null) {
      map['answer_latex'] = Variable<String>(answerLatex);
    }
    if (!nullToAbsent || solutionLatex != null) {
      map['solution_latex'] = Variable<String>(solutionLatex);
    }
    if (!nullToAbsent || hintLatex != null) {
      map['hint_latex'] = Variable<String>(hintLatex);
    }
    if (!nullToAbsent || difficulty != null) {
      map['difficulty'] = Variable<int>(difficulty);
    }
    if (!nullToAbsent || sourceText != null) {
      map['source_text'] = Variable<String>(sourceText);
    }
    if (!nullToAbsent || errorReason != null) {
      map['error_reason'] = Variable<String>(errorReason);
    }
    map['is_starred'] = Variable<bool>(isStarred);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  QuestionsCompanion toCompanion(bool nullToAbsent) {
    return QuestionsCompanion(
      id: Value(id),
      promptLatex: Value(promptLatex),
      answerLatex: answerLatex == null && nullToAbsent
          ? const Value.absent()
          : Value(answerLatex),
      solutionLatex: solutionLatex == null && nullToAbsent
          ? const Value.absent()
          : Value(solutionLatex),
      hintLatex: hintLatex == null && nullToAbsent
          ? const Value.absent()
          : Value(hintLatex),
      difficulty: difficulty == null && nullToAbsent
          ? const Value.absent()
          : Value(difficulty),
      sourceText: sourceText == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceText),
      errorReason: errorReason == null && nullToAbsent
          ? const Value.absent()
          : Value(errorReason),
      isStarred: Value(isStarred),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory QuestionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionRow(
      id: serializer.fromJson<String>(json['id']),
      promptLatex: serializer.fromJson<String>(json['promptLatex']),
      answerLatex: serializer.fromJson<String?>(json['answerLatex']),
      solutionLatex: serializer.fromJson<String?>(json['solutionLatex']),
      hintLatex: serializer.fromJson<String?>(json['hintLatex']),
      difficulty: serializer.fromJson<int?>(json['difficulty']),
      sourceText: serializer.fromJson<String?>(json['sourceText']),
      errorReason: serializer.fromJson<String?>(json['errorReason']),
      isStarred: serializer.fromJson<bool>(json['isStarred']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'promptLatex': serializer.toJson<String>(promptLatex),
      'answerLatex': serializer.toJson<String?>(answerLatex),
      'solutionLatex': serializer.toJson<String?>(solutionLatex),
      'hintLatex': serializer.toJson<String?>(hintLatex),
      'difficulty': serializer.toJson<int?>(difficulty),
      'sourceText': serializer.toJson<String?>(sourceText),
      'errorReason': serializer.toJson<String?>(errorReason),
      'isStarred': serializer.toJson<bool>(isStarred),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  QuestionRow copyWith({
    String? id,
    String? promptLatex,
    Value<String?> answerLatex = const Value.absent(),
    Value<String?> solutionLatex = const Value.absent(),
    Value<String?> hintLatex = const Value.absent(),
    Value<int?> difficulty = const Value.absent(),
    Value<String?> sourceText = const Value.absent(),
    Value<String?> errorReason = const Value.absent(),
    bool? isStarred,
    int? createdAt,
    int? updatedAt,
    Value<int?> deletedAt = const Value.absent(),
  }) => QuestionRow(
    id: id ?? this.id,
    promptLatex: promptLatex ?? this.promptLatex,
    answerLatex: answerLatex.present ? answerLatex.value : this.answerLatex,
    solutionLatex: solutionLatex.present
        ? solutionLatex.value
        : this.solutionLatex,
    hintLatex: hintLatex.present ? hintLatex.value : this.hintLatex,
    difficulty: difficulty.present ? difficulty.value : this.difficulty,
    sourceText: sourceText.present ? sourceText.value : this.sourceText,
    errorReason: errorReason.present ? errorReason.value : this.errorReason,
    isStarred: isStarred ?? this.isStarred,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  QuestionRow copyWithCompanion(QuestionsCompanion data) {
    return QuestionRow(
      id: data.id.present ? data.id.value : this.id,
      promptLatex: data.promptLatex.present
          ? data.promptLatex.value
          : this.promptLatex,
      answerLatex: data.answerLatex.present
          ? data.answerLatex.value
          : this.answerLatex,
      solutionLatex: data.solutionLatex.present
          ? data.solutionLatex.value
          : this.solutionLatex,
      hintLatex: data.hintLatex.present ? data.hintLatex.value : this.hintLatex,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      sourceText: data.sourceText.present
          ? data.sourceText.value
          : this.sourceText,
      errorReason: data.errorReason.present
          ? data.errorReason.value
          : this.errorReason,
      isStarred: data.isStarred.present ? data.isStarred.value : this.isStarred,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuestionRow(')
          ..write('id: $id, ')
          ..write('promptLatex: $promptLatex, ')
          ..write('answerLatex: $answerLatex, ')
          ..write('solutionLatex: $solutionLatex, ')
          ..write('hintLatex: $hintLatex, ')
          ..write('difficulty: $difficulty, ')
          ..write('sourceText: $sourceText, ')
          ..write('errorReason: $errorReason, ')
          ..write('isStarred: $isStarred, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    promptLatex,
    answerLatex,
    solutionLatex,
    hintLatex,
    difficulty,
    sourceText,
    errorReason,
    isStarred,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionRow &&
          other.id == this.id &&
          other.promptLatex == this.promptLatex &&
          other.answerLatex == this.answerLatex &&
          other.solutionLatex == this.solutionLatex &&
          other.hintLatex == this.hintLatex &&
          other.difficulty == this.difficulty &&
          other.sourceText == this.sourceText &&
          other.errorReason == this.errorReason &&
          other.isStarred == this.isStarred &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class QuestionsCompanion extends UpdateCompanion<QuestionRow> {
  final Value<String> id;
  final Value<String> promptLatex;
  final Value<String?> answerLatex;
  final Value<String?> solutionLatex;
  final Value<String?> hintLatex;
  final Value<int?> difficulty;
  final Value<String?> sourceText;
  final Value<String?> errorReason;
  final Value<bool> isStarred;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const QuestionsCompanion({
    this.id = const Value.absent(),
    this.promptLatex = const Value.absent(),
    this.answerLatex = const Value.absent(),
    this.solutionLatex = const Value.absent(),
    this.hintLatex = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.sourceText = const Value.absent(),
    this.errorReason = const Value.absent(),
    this.isStarred = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionsCompanion.insert({
    required String id,
    required String promptLatex,
    this.answerLatex = const Value.absent(),
    this.solutionLatex = const Value.absent(),
    this.hintLatex = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.sourceText = const Value.absent(),
    this.errorReason = const Value.absent(),
    this.isStarred = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       promptLatex = Value(promptLatex);
  static Insertable<QuestionRow> custom({
    Expression<String>? id,
    Expression<String>? promptLatex,
    Expression<String>? answerLatex,
    Expression<String>? solutionLatex,
    Expression<String>? hintLatex,
    Expression<int>? difficulty,
    Expression<String>? sourceText,
    Expression<String>? errorReason,
    Expression<bool>? isStarred,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (promptLatex != null) 'prompt_latex': promptLatex,
      if (answerLatex != null) 'answer_latex': answerLatex,
      if (solutionLatex != null) 'solution_latex': solutionLatex,
      if (hintLatex != null) 'hint_latex': hintLatex,
      if (difficulty != null) 'difficulty': difficulty,
      if (sourceText != null) 'source_text': sourceText,
      if (errorReason != null) 'error_reason': errorReason,
      if (isStarred != null) 'is_starred': isStarred,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionsCompanion copyWith({
    Value<String>? id,
    Value<String>? promptLatex,
    Value<String?>? answerLatex,
    Value<String?>? solutionLatex,
    Value<String?>? hintLatex,
    Value<int?>? difficulty,
    Value<String?>? sourceText,
    Value<String?>? errorReason,
    Value<bool>? isStarred,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int?>? deletedAt,
    Value<int>? rowid,
  }) {
    return QuestionsCompanion(
      id: id ?? this.id,
      promptLatex: promptLatex ?? this.promptLatex,
      answerLatex: answerLatex ?? this.answerLatex,
      solutionLatex: solutionLatex ?? this.solutionLatex,
      hintLatex: hintLatex ?? this.hintLatex,
      difficulty: difficulty ?? this.difficulty,
      sourceText: sourceText ?? this.sourceText,
      errorReason: errorReason ?? this.errorReason,
      isStarred: isStarred ?? this.isStarred,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (promptLatex.present) {
      map['prompt_latex'] = Variable<String>(promptLatex.value);
    }
    if (answerLatex.present) {
      map['answer_latex'] = Variable<String>(answerLatex.value);
    }
    if (solutionLatex.present) {
      map['solution_latex'] = Variable<String>(solutionLatex.value);
    }
    if (hintLatex.present) {
      map['hint_latex'] = Variable<String>(hintLatex.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<int>(difficulty.value);
    }
    if (sourceText.present) {
      map['source_text'] = Variable<String>(sourceText.value);
    }
    if (errorReason.present) {
      map['error_reason'] = Variable<String>(errorReason.value);
    }
    if (isStarred.present) {
      map['is_starred'] = Variable<bool>(isStarred.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionsCompanion(')
          ..write('id: $id, ')
          ..write('promptLatex: $promptLatex, ')
          ..write('answerLatex: $answerLatex, ')
          ..write('solutionLatex: $solutionLatex, ')
          ..write('hintLatex: $hintLatex, ')
          ..write('difficulty: $difficulty, ')
          ..write('sourceText: $sourceText, ')
          ..write('errorReason: $errorReason, ')
          ..write('isStarred: $isStarred, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuestionKnowledgeTable extends QuestionKnowledge
    with TableInfo<$QuestionKnowledgeTable, QuestionKnowledgeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionKnowledgeTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _questionIdMeta = const VerificationMeta(
    'questionId',
  );
  @override
  late final GeneratedColumn<String> questionId = GeneratedColumn<String>(
    'question_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES questions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nodeIdMeta = const VerificationMeta('nodeId');
  @override
  late final GeneratedColumn<String> nodeId = GeneratedColumn<String>(
    'node_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES knowledge_nodes (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _relevanceMeta = const VerificationMeta(
    'relevance',
  );
  @override
  late final GeneratedColumn<double> relevance = GeneratedColumn<double>(
    'relevance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _isPrimaryMeta = const VerificationMeta(
    'isPrimary',
  );
  @override
  late final GeneratedColumn<bool> isPrimary = GeneratedColumn<bool>(
    'is_primary',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_primary" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    questionId,
    nodeId,
    relevance,
    isPrimary,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'question_knowledge';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuestionKnowledgeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('question_id')) {
      context.handle(
        _questionIdMeta,
        questionId.isAcceptableOrUnknown(data['question_id']!, _questionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('node_id')) {
      context.handle(
        _nodeIdMeta,
        nodeId.isAcceptableOrUnknown(data['node_id']!, _nodeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_nodeIdMeta);
    }
    if (data.containsKey('relevance')) {
      context.handle(
        _relevanceMeta,
        relevance.isAcceptableOrUnknown(data['relevance']!, _relevanceMeta),
      );
    }
    if (data.containsKey('is_primary')) {
      context.handle(
        _isPrimaryMeta,
        isPrimary.isAcceptableOrUnknown(data['is_primary']!, _isPrimaryMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {questionId, nodeId};
  @override
  QuestionKnowledgeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionKnowledgeRow(
      questionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_id'],
      )!,
      nodeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}node_id'],
      )!,
      relevance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}relevance'],
      )!,
      isPrimary: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_primary'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $QuestionKnowledgeTable createAlias(String alias) {
    return $QuestionKnowledgeTable(attachedDatabase, alias);
  }
}

class QuestionKnowledgeRow extends DataClass
    implements Insertable<QuestionKnowledgeRow> {
  final String questionId;
  final String nodeId;
  final double relevance;
  final bool isPrimary;
  final int createdAt;
  const QuestionKnowledgeRow({
    required this.questionId,
    required this.nodeId,
    required this.relevance,
    required this.isPrimary,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['question_id'] = Variable<String>(questionId);
    map['node_id'] = Variable<String>(nodeId);
    map['relevance'] = Variable<double>(relevance);
    map['is_primary'] = Variable<bool>(isPrimary);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  QuestionKnowledgeCompanion toCompanion(bool nullToAbsent) {
    return QuestionKnowledgeCompanion(
      questionId: Value(questionId),
      nodeId: Value(nodeId),
      relevance: Value(relevance),
      isPrimary: Value(isPrimary),
      createdAt: Value(createdAt),
    );
  }

  factory QuestionKnowledgeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionKnowledgeRow(
      questionId: serializer.fromJson<String>(json['questionId']),
      nodeId: serializer.fromJson<String>(json['nodeId']),
      relevance: serializer.fromJson<double>(json['relevance']),
      isPrimary: serializer.fromJson<bool>(json['isPrimary']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'questionId': serializer.toJson<String>(questionId),
      'nodeId': serializer.toJson<String>(nodeId),
      'relevance': serializer.toJson<double>(relevance),
      'isPrimary': serializer.toJson<bool>(isPrimary),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  QuestionKnowledgeRow copyWith({
    String? questionId,
    String? nodeId,
    double? relevance,
    bool? isPrimary,
    int? createdAt,
  }) => QuestionKnowledgeRow(
    questionId: questionId ?? this.questionId,
    nodeId: nodeId ?? this.nodeId,
    relevance: relevance ?? this.relevance,
    isPrimary: isPrimary ?? this.isPrimary,
    createdAt: createdAt ?? this.createdAt,
  );
  QuestionKnowledgeRow copyWithCompanion(QuestionKnowledgeCompanion data) {
    return QuestionKnowledgeRow(
      questionId: data.questionId.present
          ? data.questionId.value
          : this.questionId,
      nodeId: data.nodeId.present ? data.nodeId.value : this.nodeId,
      relevance: data.relevance.present ? data.relevance.value : this.relevance,
      isPrimary: data.isPrimary.present ? data.isPrimary.value : this.isPrimary,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuestionKnowledgeRow(')
          ..write('questionId: $questionId, ')
          ..write('nodeId: $nodeId, ')
          ..write('relevance: $relevance, ')
          ..write('isPrimary: $isPrimary, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(questionId, nodeId, relevance, isPrimary, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionKnowledgeRow &&
          other.questionId == this.questionId &&
          other.nodeId == this.nodeId &&
          other.relevance == this.relevance &&
          other.isPrimary == this.isPrimary &&
          other.createdAt == this.createdAt);
}

class QuestionKnowledgeCompanion extends UpdateCompanion<QuestionKnowledgeRow> {
  final Value<String> questionId;
  final Value<String> nodeId;
  final Value<double> relevance;
  final Value<bool> isPrimary;
  final Value<int> createdAt;
  final Value<int> rowid;
  const QuestionKnowledgeCompanion({
    this.questionId = const Value.absent(),
    this.nodeId = const Value.absent(),
    this.relevance = const Value.absent(),
    this.isPrimary = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionKnowledgeCompanion.insert({
    required String questionId,
    required String nodeId,
    this.relevance = const Value.absent(),
    this.isPrimary = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : questionId = Value(questionId),
       nodeId = Value(nodeId);
  static Insertable<QuestionKnowledgeRow> custom({
    Expression<String>? questionId,
    Expression<String>? nodeId,
    Expression<double>? relevance,
    Expression<bool>? isPrimary,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (questionId != null) 'question_id': questionId,
      if (nodeId != null) 'node_id': nodeId,
      if (relevance != null) 'relevance': relevance,
      if (isPrimary != null) 'is_primary': isPrimary,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionKnowledgeCompanion copyWith({
    Value<String>? questionId,
    Value<String>? nodeId,
    Value<double>? relevance,
    Value<bool>? isPrimary,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return QuestionKnowledgeCompanion(
      questionId: questionId ?? this.questionId,
      nodeId: nodeId ?? this.nodeId,
      relevance: relevance ?? this.relevance,
      isPrimary: isPrimary ?? this.isPrimary,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (questionId.present) {
      map['question_id'] = Variable<String>(questionId.value);
    }
    if (nodeId.present) {
      map['node_id'] = Variable<String>(nodeId.value);
    }
    if (relevance.present) {
      map['relevance'] = Variable<double>(relevance.value);
    }
    if (isPrimary.present) {
      map['is_primary'] = Variable<bool>(isPrimary.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionKnowledgeCompanion(')
          ..write('questionId: $questionId, ')
          ..write('nodeId: $nodeId, ')
          ..write('relevance: $relevance, ')
          ..write('isPrimary: $isPrimary, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuestionTagsTable extends QuestionTags
    with TableInfo<$QuestionTagsTable, QuestionTagRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _questionIdMeta = const VerificationMeta(
    'questionId',
  );
  @override
  late final GeneratedColumn<String> questionId = GeneratedColumn<String>(
    'question_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES questions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<String> tagId = GeneratedColumn<String>(
    'tag_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tags (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [questionId, tagId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'question_tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuestionTagRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('question_id')) {
      context.handle(
        _questionIdMeta,
        questionId.isAcceptableOrUnknown(data['question_id']!, _questionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
        _tagIdMeta,
        tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {questionId, tagId};
  @override
  QuestionTagRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionTagRow(
      questionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_id'],
      )!,
      tagId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $QuestionTagsTable createAlias(String alias) {
    return $QuestionTagsTable(attachedDatabase, alias);
  }
}

class QuestionTagRow extends DataClass implements Insertable<QuestionTagRow> {
  final String questionId;
  final String tagId;
  final int createdAt;
  const QuestionTagRow({
    required this.questionId,
    required this.tagId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['question_id'] = Variable<String>(questionId);
    map['tag_id'] = Variable<String>(tagId);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  QuestionTagsCompanion toCompanion(bool nullToAbsent) {
    return QuestionTagsCompanion(
      questionId: Value(questionId),
      tagId: Value(tagId),
      createdAt: Value(createdAt),
    );
  }

  factory QuestionTagRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionTagRow(
      questionId: serializer.fromJson<String>(json['questionId']),
      tagId: serializer.fromJson<String>(json['tagId']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'questionId': serializer.toJson<String>(questionId),
      'tagId': serializer.toJson<String>(tagId),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  QuestionTagRow copyWith({
    String? questionId,
    String? tagId,
    int? createdAt,
  }) => QuestionTagRow(
    questionId: questionId ?? this.questionId,
    tagId: tagId ?? this.tagId,
    createdAt: createdAt ?? this.createdAt,
  );
  QuestionTagRow copyWithCompanion(QuestionTagsCompanion data) {
    return QuestionTagRow(
      questionId: data.questionId.present
          ? data.questionId.value
          : this.questionId,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuestionTagRow(')
          ..write('questionId: $questionId, ')
          ..write('tagId: $tagId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(questionId, tagId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionTagRow &&
          other.questionId == this.questionId &&
          other.tagId == this.tagId &&
          other.createdAt == this.createdAt);
}

class QuestionTagsCompanion extends UpdateCompanion<QuestionTagRow> {
  final Value<String> questionId;
  final Value<String> tagId;
  final Value<int> createdAt;
  final Value<int> rowid;
  const QuestionTagsCompanion({
    this.questionId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionTagsCompanion.insert({
    required String questionId,
    required String tagId,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : questionId = Value(questionId),
       tagId = Value(tagId);
  static Insertable<QuestionTagRow> custom({
    Expression<String>? questionId,
    Expression<String>? tagId,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (questionId != null) 'question_id': questionId,
      if (tagId != null) 'tag_id': tagId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionTagsCompanion copyWith({
    Value<String>? questionId,
    Value<String>? tagId,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return QuestionTagsCompanion(
      questionId: questionId ?? this.questionId,
      tagId: tagId ?? this.tagId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (questionId.present) {
      map['question_id'] = Variable<String>(questionId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<String>(tagId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionTagsCompanion(')
          ..write('questionId: $questionId, ')
          ..write('tagId: $tagId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ImageAssetsTable extends ImageAssets
    with TableInfo<$ImageAssetsTable, ImageAssetRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ImageAssetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _sha256Meta = const VerificationMeta('sha256');
  @override
  late final GeneratedColumn<String> sha256 = GeneratedColumn<String>(
    'sha256',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _relPathMeta = const VerificationMeta(
    'relPath',
  );
  @override
  late final GeneratedColumn<String> relPath = GeneratedColumn<String>(
    'rel_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bytesMeta = const VerificationMeta('bytes');
  @override
  late final GeneratedColumn<int> bytes = GeneratedColumn<int>(
    'bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<int> width = GeneratedColumn<int>(
    'width',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<int> height = GeneratedColumn<int>(
    'height',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mimeMeta = const VerificationMeta('mime');
  @override
  late final GeneratedColumn<String> mime = GeneratedColumn<String>(
    'mime',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('image/jpeg'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    sha256,
    relPath,
    bytes,
    width,
    height,
    mime,
    createdAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'image_assets';
  @override
  VerificationContext validateIntegrity(
    Insertable<ImageAssetRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('sha256')) {
      context.handle(
        _sha256Meta,
        sha256.isAcceptableOrUnknown(data['sha256']!, _sha256Meta),
      );
    } else if (isInserting) {
      context.missing(_sha256Meta);
    }
    if (data.containsKey('rel_path')) {
      context.handle(
        _relPathMeta,
        relPath.isAcceptableOrUnknown(data['rel_path']!, _relPathMeta),
      );
    } else if (isInserting) {
      context.missing(_relPathMeta);
    }
    if (data.containsKey('bytes')) {
      context.handle(
        _bytesMeta,
        bytes.isAcceptableOrUnknown(data['bytes']!, _bytesMeta),
      );
    }
    if (data.containsKey('width')) {
      context.handle(
        _widthMeta,
        width.isAcceptableOrUnknown(data['width']!, _widthMeta),
      );
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    }
    if (data.containsKey('mime')) {
      context.handle(
        _mimeMeta,
        mime.isAcceptableOrUnknown(data['mime']!, _mimeMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sha256};
  @override
  ImageAssetRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ImageAssetRow(
      sha256: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sha256'],
      )!,
      relPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rel_path'],
      )!,
      bytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bytes'],
      )!,
      width: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}width'],
      ),
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}height'],
      ),
      mime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mime'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $ImageAssetsTable createAlias(String alias) {
    return $ImageAssetsTable(attachedDatabase, alias);
  }
}

class ImageAssetRow extends DataClass implements Insertable<ImageAssetRow> {
  final String sha256;
  final String relPath;
  final int bytes;
  final int? width;
  final int? height;
  final String mime;
  final int createdAt;
  final int? deletedAt;
  const ImageAssetRow({
    required this.sha256,
    required this.relPath,
    required this.bytes,
    this.width,
    this.height,
    required this.mime,
    required this.createdAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['sha256'] = Variable<String>(sha256);
    map['rel_path'] = Variable<String>(relPath);
    map['bytes'] = Variable<int>(bytes);
    if (!nullToAbsent || width != null) {
      map['width'] = Variable<int>(width);
    }
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<int>(height);
    }
    map['mime'] = Variable<String>(mime);
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  ImageAssetsCompanion toCompanion(bool nullToAbsent) {
    return ImageAssetsCompanion(
      sha256: Value(sha256),
      relPath: Value(relPath),
      bytes: Value(bytes),
      width: width == null && nullToAbsent
          ? const Value.absent()
          : Value(width),
      height: height == null && nullToAbsent
          ? const Value.absent()
          : Value(height),
      mime: Value(mime),
      createdAt: Value(createdAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory ImageAssetRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ImageAssetRow(
      sha256: serializer.fromJson<String>(json['sha256']),
      relPath: serializer.fromJson<String>(json['relPath']),
      bytes: serializer.fromJson<int>(json['bytes']),
      width: serializer.fromJson<int?>(json['width']),
      height: serializer.fromJson<int?>(json['height']),
      mime: serializer.fromJson<String>(json['mime']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sha256': serializer.toJson<String>(sha256),
      'relPath': serializer.toJson<String>(relPath),
      'bytes': serializer.toJson<int>(bytes),
      'width': serializer.toJson<int?>(width),
      'height': serializer.toJson<int?>(height),
      'mime': serializer.toJson<String>(mime),
      'createdAt': serializer.toJson<int>(createdAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  ImageAssetRow copyWith({
    String? sha256,
    String? relPath,
    int? bytes,
    Value<int?> width = const Value.absent(),
    Value<int?> height = const Value.absent(),
    String? mime,
    int? createdAt,
    Value<int?> deletedAt = const Value.absent(),
  }) => ImageAssetRow(
    sha256: sha256 ?? this.sha256,
    relPath: relPath ?? this.relPath,
    bytes: bytes ?? this.bytes,
    width: width.present ? width.value : this.width,
    height: height.present ? height.value : this.height,
    mime: mime ?? this.mime,
    createdAt: createdAt ?? this.createdAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  ImageAssetRow copyWithCompanion(ImageAssetsCompanion data) {
    return ImageAssetRow(
      sha256: data.sha256.present ? data.sha256.value : this.sha256,
      relPath: data.relPath.present ? data.relPath.value : this.relPath,
      bytes: data.bytes.present ? data.bytes.value : this.bytes,
      width: data.width.present ? data.width.value : this.width,
      height: data.height.present ? data.height.value : this.height,
      mime: data.mime.present ? data.mime.value : this.mime,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ImageAssetRow(')
          ..write('sha256: $sha256, ')
          ..write('relPath: $relPath, ')
          ..write('bytes: $bytes, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('mime: $mime, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    sha256,
    relPath,
    bytes,
    width,
    height,
    mime,
    createdAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ImageAssetRow &&
          other.sha256 == this.sha256 &&
          other.relPath == this.relPath &&
          other.bytes == this.bytes &&
          other.width == this.width &&
          other.height == this.height &&
          other.mime == this.mime &&
          other.createdAt == this.createdAt &&
          other.deletedAt == this.deletedAt);
}

class ImageAssetsCompanion extends UpdateCompanion<ImageAssetRow> {
  final Value<String> sha256;
  final Value<String> relPath;
  final Value<int> bytes;
  final Value<int?> width;
  final Value<int?> height;
  final Value<String> mime;
  final Value<int> createdAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const ImageAssetsCompanion({
    this.sha256 = const Value.absent(),
    this.relPath = const Value.absent(),
    this.bytes = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.mime = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ImageAssetsCompanion.insert({
    required String sha256,
    required String relPath,
    this.bytes = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.mime = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : sha256 = Value(sha256),
       relPath = Value(relPath);
  static Insertable<ImageAssetRow> custom({
    Expression<String>? sha256,
    Expression<String>? relPath,
    Expression<int>? bytes,
    Expression<int>? width,
    Expression<int>? height,
    Expression<String>? mime,
    Expression<int>? createdAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (sha256 != null) 'sha256': sha256,
      if (relPath != null) 'rel_path': relPath,
      if (bytes != null) 'bytes': bytes,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (mime != null) 'mime': mime,
      if (createdAt != null) 'created_at': createdAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ImageAssetsCompanion copyWith({
    Value<String>? sha256,
    Value<String>? relPath,
    Value<int>? bytes,
    Value<int?>? width,
    Value<int?>? height,
    Value<String>? mime,
    Value<int>? createdAt,
    Value<int?>? deletedAt,
    Value<int>? rowid,
  }) {
    return ImageAssetsCompanion(
      sha256: sha256 ?? this.sha256,
      relPath: relPath ?? this.relPath,
      bytes: bytes ?? this.bytes,
      width: width ?? this.width,
      height: height ?? this.height,
      mime: mime ?? this.mime,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sha256.present) {
      map['sha256'] = Variable<String>(sha256.value);
    }
    if (relPath.present) {
      map['rel_path'] = Variable<String>(relPath.value);
    }
    if (bytes.present) {
      map['bytes'] = Variable<int>(bytes.value);
    }
    if (width.present) {
      map['width'] = Variable<int>(width.value);
    }
    if (height.present) {
      map['height'] = Variable<int>(height.value);
    }
    if (mime.present) {
      map['mime'] = Variable<String>(mime.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImageAssetsCompanion(')
          ..write('sha256: $sha256, ')
          ..write('relPath: $relPath, ')
          ..write('bytes: $bytes, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('mime: $mime, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuestionImagesTable extends QuestionImages
    with TableInfo<$QuestionImagesTable, QuestionImageRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionImagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _questionIdMeta = const VerificationMeta(
    'questionId',
  );
  @override
  late final GeneratedColumn<String> questionId = GeneratedColumn<String>(
    'question_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES questions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _sha256Meta = const VerificationMeta('sha256');
  @override
  late final GeneratedColumn<String> sha256 = GeneratedColumn<String>(
    'sha256',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES image_assets (sha256) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('original'),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    questionId,
    sha256,
    role,
    sortOrder,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'question_images';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuestionImageRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('question_id')) {
      context.handle(
        _questionIdMeta,
        questionId.isAcceptableOrUnknown(data['question_id']!, _questionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('sha256')) {
      context.handle(
        _sha256Meta,
        sha256.isAcceptableOrUnknown(data['sha256']!, _sha256Meta),
      );
    } else if (isInserting) {
      context.missing(_sha256Meta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {questionId, sha256, role};
  @override
  QuestionImageRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionImageRow(
      questionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_id'],
      )!,
      sha256: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sha256'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $QuestionImagesTable createAlias(String alias) {
    return $QuestionImagesTable(attachedDatabase, alias);
  }
}

class QuestionImageRow extends DataClass
    implements Insertable<QuestionImageRow> {
  final String questionId;
  final String sha256;
  final String role;
  final int sortOrder;
  final int createdAt;
  const QuestionImageRow({
    required this.questionId,
    required this.sha256,
    required this.role,
    required this.sortOrder,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['question_id'] = Variable<String>(questionId);
    map['sha256'] = Variable<String>(sha256);
    map['role'] = Variable<String>(role);
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  QuestionImagesCompanion toCompanion(bool nullToAbsent) {
    return QuestionImagesCompanion(
      questionId: Value(questionId),
      sha256: Value(sha256),
      role: Value(role),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
    );
  }

  factory QuestionImageRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionImageRow(
      questionId: serializer.fromJson<String>(json['questionId']),
      sha256: serializer.fromJson<String>(json['sha256']),
      role: serializer.fromJson<String>(json['role']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'questionId': serializer.toJson<String>(questionId),
      'sha256': serializer.toJson<String>(sha256),
      'role': serializer.toJson<String>(role),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  QuestionImageRow copyWith({
    String? questionId,
    String? sha256,
    String? role,
    int? sortOrder,
    int? createdAt,
  }) => QuestionImageRow(
    questionId: questionId ?? this.questionId,
    sha256: sha256 ?? this.sha256,
    role: role ?? this.role,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
  );
  QuestionImageRow copyWithCompanion(QuestionImagesCompanion data) {
    return QuestionImageRow(
      questionId: data.questionId.present
          ? data.questionId.value
          : this.questionId,
      sha256: data.sha256.present ? data.sha256.value : this.sha256,
      role: data.role.present ? data.role.value : this.role,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuestionImageRow(')
          ..write('questionId: $questionId, ')
          ..write('sha256: $sha256, ')
          ..write('role: $role, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(questionId, sha256, role, sortOrder, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionImageRow &&
          other.questionId == this.questionId &&
          other.sha256 == this.sha256 &&
          other.role == this.role &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt);
}

class QuestionImagesCompanion extends UpdateCompanion<QuestionImageRow> {
  final Value<String> questionId;
  final Value<String> sha256;
  final Value<String> role;
  final Value<int> sortOrder;
  final Value<int> createdAt;
  final Value<int> rowid;
  const QuestionImagesCompanion({
    this.questionId = const Value.absent(),
    this.sha256 = const Value.absent(),
    this.role = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionImagesCompanion.insert({
    required String questionId,
    required String sha256,
    this.role = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : questionId = Value(questionId),
       sha256 = Value(sha256);
  static Insertable<QuestionImageRow> custom({
    Expression<String>? questionId,
    Expression<String>? sha256,
    Expression<String>? role,
    Expression<int>? sortOrder,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (questionId != null) 'question_id': questionId,
      if (sha256 != null) 'sha256': sha256,
      if (role != null) 'role': role,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionImagesCompanion copyWith({
    Value<String>? questionId,
    Value<String>? sha256,
    Value<String>? role,
    Value<int>? sortOrder,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return QuestionImagesCompanion(
      questionId: questionId ?? this.questionId,
      sha256: sha256 ?? this.sha256,
      role: role ?? this.role,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (questionId.present) {
      map['question_id'] = Variable<String>(questionId.value);
    }
    if (sha256.present) {
      map['sha256'] = Variable<String>(sha256.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionImagesCompanion(')
          ..write('questionId: $questionId, ')
          ..write('sha256: $sha256, ')
          ..write('role: $role, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReviewCardsTable extends ReviewCards
    with TableInfo<$ReviewCardsTable, ReviewCardRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewCardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _questionIdMeta = const VerificationMeta(
    'questionId',
  );
  @override
  late final GeneratedColumn<String> questionId = GeneratedColumn<String>(
    'question_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES questions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<int> state = GeneratedColumn<int>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _stepMeta = const VerificationMeta('step');
  @override
  late final GeneratedColumn<int> step = GeneratedColumn<int>(
    'step',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dueAtMeta = const VerificationMeta('dueAt');
  @override
  late final GeneratedColumn<int> dueAt = GeneratedColumn<int>(
    'due_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _stabilityMeta = const VerificationMeta(
    'stability',
  );
  @override
  late final GeneratedColumn<double> stability = GeneratedColumn<double>(
    'stability',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<double> difficulty = GeneratedColumn<double>(
    'difficulty',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _elapsedDaysMeta = const VerificationMeta(
    'elapsedDays',
  );
  @override
  late final GeneratedColumn<int> elapsedDays = GeneratedColumn<int>(
    'elapsed_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _scheduledDaysMeta = const VerificationMeta(
    'scheduledDays',
  );
  @override
  late final GeneratedColumn<int> scheduledDays = GeneratedColumn<int>(
    'scheduled_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
    'reps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lapsesMeta = const VerificationMeta('lapses');
  @override
  late final GeneratedColumn<int> lapses = GeneratedColumn<int>(
    'lapses',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastReviewAtMeta = const VerificationMeta(
    'lastReviewAt',
  );
  @override
  late final GeneratedColumn<int> lastReviewAt = GeneratedColumn<int>(
    'last_review_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _schedulerIdMeta = const VerificationMeta(
    'schedulerId',
  );
  @override
  late final GeneratedColumn<String> schedulerId = GeneratedColumn<String>(
    'scheduler_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('fsrs-6'),
  );
  static const VerificationMeta _paramsVersionMeta = const VerificationMeta(
    'paramsVersion',
  );
  @override
  late final GeneratedColumn<String> paramsVersion = GeneratedColumn<String>(
    'params_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('default-1'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    questionId,
    state,
    step,
    dueAt,
    stability,
    difficulty,
    elapsedDays,
    scheduledDays,
    reps,
    lapses,
    lastReviewAt,
    schedulerId,
    paramsVersion,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'review_cards';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReviewCardRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('question_id')) {
      context.handle(
        _questionIdMeta,
        questionId.isAcceptableOrUnknown(data['question_id']!, _questionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    }
    if (data.containsKey('step')) {
      context.handle(
        _stepMeta,
        step.isAcceptableOrUnknown(data['step']!, _stepMeta),
      );
    }
    if (data.containsKey('due_at')) {
      context.handle(
        _dueAtMeta,
        dueAt.isAcceptableOrUnknown(data['due_at']!, _dueAtMeta),
      );
    }
    if (data.containsKey('stability')) {
      context.handle(
        _stabilityMeta,
        stability.isAcceptableOrUnknown(data['stability']!, _stabilityMeta),
      );
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    }
    if (data.containsKey('elapsed_days')) {
      context.handle(
        _elapsedDaysMeta,
        elapsedDays.isAcceptableOrUnknown(
          data['elapsed_days']!,
          _elapsedDaysMeta,
        ),
      );
    }
    if (data.containsKey('scheduled_days')) {
      context.handle(
        _scheduledDaysMeta,
        scheduledDays.isAcceptableOrUnknown(
          data['scheduled_days']!,
          _scheduledDaysMeta,
        ),
      );
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    }
    if (data.containsKey('lapses')) {
      context.handle(
        _lapsesMeta,
        lapses.isAcceptableOrUnknown(data['lapses']!, _lapsesMeta),
      );
    }
    if (data.containsKey('last_review_at')) {
      context.handle(
        _lastReviewAtMeta,
        lastReviewAt.isAcceptableOrUnknown(
          data['last_review_at']!,
          _lastReviewAtMeta,
        ),
      );
    }
    if (data.containsKey('scheduler_id')) {
      context.handle(
        _schedulerIdMeta,
        schedulerId.isAcceptableOrUnknown(
          data['scheduler_id']!,
          _schedulerIdMeta,
        ),
      );
    }
    if (data.containsKey('params_version')) {
      context.handle(
        _paramsVersionMeta,
        paramsVersion.isAcceptableOrUnknown(
          data['params_version']!,
          _paramsVersionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {questionId};
  @override
  ReviewCardRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewCardRow(
      questionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_id'],
      )!,
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}state'],
      )!,
      step: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}step'],
      ),
      dueAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}due_at'],
      )!,
      stability: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}stability'],
      ),
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}difficulty'],
      ),
      elapsedDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}elapsed_days'],
      )!,
      scheduledDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}scheduled_days'],
      )!,
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reps'],
      )!,
      lapses: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lapses'],
      )!,
      lastReviewAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_review_at'],
      ),
      schedulerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scheduler_id'],
      )!,
      paramsVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}params_version'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ReviewCardsTable createAlias(String alias) {
    return $ReviewCardsTable(attachedDatabase, alias);
  }
}

class ReviewCardRow extends DataClass implements Insertable<ReviewCardRow> {
  final String questionId;
  final int state;
  final int? step;
  final int dueAt;
  final double? stability;
  final double? difficulty;
  final int elapsedDays;
  final int scheduledDays;
  final int reps;
  final int lapses;
  final int? lastReviewAt;
  final String schedulerId;
  final String paramsVersion;
  final int createdAt;
  final int updatedAt;
  const ReviewCardRow({
    required this.questionId,
    required this.state,
    this.step,
    required this.dueAt,
    this.stability,
    this.difficulty,
    required this.elapsedDays,
    required this.scheduledDays,
    required this.reps,
    required this.lapses,
    this.lastReviewAt,
    required this.schedulerId,
    required this.paramsVersion,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['question_id'] = Variable<String>(questionId);
    map['state'] = Variable<int>(state);
    if (!nullToAbsent || step != null) {
      map['step'] = Variable<int>(step);
    }
    map['due_at'] = Variable<int>(dueAt);
    if (!nullToAbsent || stability != null) {
      map['stability'] = Variable<double>(stability);
    }
    if (!nullToAbsent || difficulty != null) {
      map['difficulty'] = Variable<double>(difficulty);
    }
    map['elapsed_days'] = Variable<int>(elapsedDays);
    map['scheduled_days'] = Variable<int>(scheduledDays);
    map['reps'] = Variable<int>(reps);
    map['lapses'] = Variable<int>(lapses);
    if (!nullToAbsent || lastReviewAt != null) {
      map['last_review_at'] = Variable<int>(lastReviewAt);
    }
    map['scheduler_id'] = Variable<String>(schedulerId);
    map['params_version'] = Variable<String>(paramsVersion);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  ReviewCardsCompanion toCompanion(bool nullToAbsent) {
    return ReviewCardsCompanion(
      questionId: Value(questionId),
      state: Value(state),
      step: step == null && nullToAbsent ? const Value.absent() : Value(step),
      dueAt: Value(dueAt),
      stability: stability == null && nullToAbsent
          ? const Value.absent()
          : Value(stability),
      difficulty: difficulty == null && nullToAbsent
          ? const Value.absent()
          : Value(difficulty),
      elapsedDays: Value(elapsedDays),
      scheduledDays: Value(scheduledDays),
      reps: Value(reps),
      lapses: Value(lapses),
      lastReviewAt: lastReviewAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReviewAt),
      schedulerId: Value(schedulerId),
      paramsVersion: Value(paramsVersion),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ReviewCardRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewCardRow(
      questionId: serializer.fromJson<String>(json['questionId']),
      state: serializer.fromJson<int>(json['state']),
      step: serializer.fromJson<int?>(json['step']),
      dueAt: serializer.fromJson<int>(json['dueAt']),
      stability: serializer.fromJson<double?>(json['stability']),
      difficulty: serializer.fromJson<double?>(json['difficulty']),
      elapsedDays: serializer.fromJson<int>(json['elapsedDays']),
      scheduledDays: serializer.fromJson<int>(json['scheduledDays']),
      reps: serializer.fromJson<int>(json['reps']),
      lapses: serializer.fromJson<int>(json['lapses']),
      lastReviewAt: serializer.fromJson<int?>(json['lastReviewAt']),
      schedulerId: serializer.fromJson<String>(json['schedulerId']),
      paramsVersion: serializer.fromJson<String>(json['paramsVersion']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'questionId': serializer.toJson<String>(questionId),
      'state': serializer.toJson<int>(state),
      'step': serializer.toJson<int?>(step),
      'dueAt': serializer.toJson<int>(dueAt),
      'stability': serializer.toJson<double?>(stability),
      'difficulty': serializer.toJson<double?>(difficulty),
      'elapsedDays': serializer.toJson<int>(elapsedDays),
      'scheduledDays': serializer.toJson<int>(scheduledDays),
      'reps': serializer.toJson<int>(reps),
      'lapses': serializer.toJson<int>(lapses),
      'lastReviewAt': serializer.toJson<int?>(lastReviewAt),
      'schedulerId': serializer.toJson<String>(schedulerId),
      'paramsVersion': serializer.toJson<String>(paramsVersion),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  ReviewCardRow copyWith({
    String? questionId,
    int? state,
    Value<int?> step = const Value.absent(),
    int? dueAt,
    Value<double?> stability = const Value.absent(),
    Value<double?> difficulty = const Value.absent(),
    int? elapsedDays,
    int? scheduledDays,
    int? reps,
    int? lapses,
    Value<int?> lastReviewAt = const Value.absent(),
    String? schedulerId,
    String? paramsVersion,
    int? createdAt,
    int? updatedAt,
  }) => ReviewCardRow(
    questionId: questionId ?? this.questionId,
    state: state ?? this.state,
    step: step.present ? step.value : this.step,
    dueAt: dueAt ?? this.dueAt,
    stability: stability.present ? stability.value : this.stability,
    difficulty: difficulty.present ? difficulty.value : this.difficulty,
    elapsedDays: elapsedDays ?? this.elapsedDays,
    scheduledDays: scheduledDays ?? this.scheduledDays,
    reps: reps ?? this.reps,
    lapses: lapses ?? this.lapses,
    lastReviewAt: lastReviewAt.present ? lastReviewAt.value : this.lastReviewAt,
    schedulerId: schedulerId ?? this.schedulerId,
    paramsVersion: paramsVersion ?? this.paramsVersion,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ReviewCardRow copyWithCompanion(ReviewCardsCompanion data) {
    return ReviewCardRow(
      questionId: data.questionId.present
          ? data.questionId.value
          : this.questionId,
      state: data.state.present ? data.state.value : this.state,
      step: data.step.present ? data.step.value : this.step,
      dueAt: data.dueAt.present ? data.dueAt.value : this.dueAt,
      stability: data.stability.present ? data.stability.value : this.stability,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      elapsedDays: data.elapsedDays.present
          ? data.elapsedDays.value
          : this.elapsedDays,
      scheduledDays: data.scheduledDays.present
          ? data.scheduledDays.value
          : this.scheduledDays,
      reps: data.reps.present ? data.reps.value : this.reps,
      lapses: data.lapses.present ? data.lapses.value : this.lapses,
      lastReviewAt: data.lastReviewAt.present
          ? data.lastReviewAt.value
          : this.lastReviewAt,
      schedulerId: data.schedulerId.present
          ? data.schedulerId.value
          : this.schedulerId,
      paramsVersion: data.paramsVersion.present
          ? data.paramsVersion.value
          : this.paramsVersion,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReviewCardRow(')
          ..write('questionId: $questionId, ')
          ..write('state: $state, ')
          ..write('step: $step, ')
          ..write('dueAt: $dueAt, ')
          ..write('stability: $stability, ')
          ..write('difficulty: $difficulty, ')
          ..write('elapsedDays: $elapsedDays, ')
          ..write('scheduledDays: $scheduledDays, ')
          ..write('reps: $reps, ')
          ..write('lapses: $lapses, ')
          ..write('lastReviewAt: $lastReviewAt, ')
          ..write('schedulerId: $schedulerId, ')
          ..write('paramsVersion: $paramsVersion, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    questionId,
    state,
    step,
    dueAt,
    stability,
    difficulty,
    elapsedDays,
    scheduledDays,
    reps,
    lapses,
    lastReviewAt,
    schedulerId,
    paramsVersion,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewCardRow &&
          other.questionId == this.questionId &&
          other.state == this.state &&
          other.step == this.step &&
          other.dueAt == this.dueAt &&
          other.stability == this.stability &&
          other.difficulty == this.difficulty &&
          other.elapsedDays == this.elapsedDays &&
          other.scheduledDays == this.scheduledDays &&
          other.reps == this.reps &&
          other.lapses == this.lapses &&
          other.lastReviewAt == this.lastReviewAt &&
          other.schedulerId == this.schedulerId &&
          other.paramsVersion == this.paramsVersion &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ReviewCardsCompanion extends UpdateCompanion<ReviewCardRow> {
  final Value<String> questionId;
  final Value<int> state;
  final Value<int?> step;
  final Value<int> dueAt;
  final Value<double?> stability;
  final Value<double?> difficulty;
  final Value<int> elapsedDays;
  final Value<int> scheduledDays;
  final Value<int> reps;
  final Value<int> lapses;
  final Value<int?> lastReviewAt;
  final Value<String> schedulerId;
  final Value<String> paramsVersion;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const ReviewCardsCompanion({
    this.questionId = const Value.absent(),
    this.state = const Value.absent(),
    this.step = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.stability = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.elapsedDays = const Value.absent(),
    this.scheduledDays = const Value.absent(),
    this.reps = const Value.absent(),
    this.lapses = const Value.absent(),
    this.lastReviewAt = const Value.absent(),
    this.schedulerId = const Value.absent(),
    this.paramsVersion = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReviewCardsCompanion.insert({
    required String questionId,
    this.state = const Value.absent(),
    this.step = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.stability = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.elapsedDays = const Value.absent(),
    this.scheduledDays = const Value.absent(),
    this.reps = const Value.absent(),
    this.lapses = const Value.absent(),
    this.lastReviewAt = const Value.absent(),
    this.schedulerId = const Value.absent(),
    this.paramsVersion = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : questionId = Value(questionId);
  static Insertable<ReviewCardRow> custom({
    Expression<String>? questionId,
    Expression<int>? state,
    Expression<int>? step,
    Expression<int>? dueAt,
    Expression<double>? stability,
    Expression<double>? difficulty,
    Expression<int>? elapsedDays,
    Expression<int>? scheduledDays,
    Expression<int>? reps,
    Expression<int>? lapses,
    Expression<int>? lastReviewAt,
    Expression<String>? schedulerId,
    Expression<String>? paramsVersion,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (questionId != null) 'question_id': questionId,
      if (state != null) 'state': state,
      if (step != null) 'step': step,
      if (dueAt != null) 'due_at': dueAt,
      if (stability != null) 'stability': stability,
      if (difficulty != null) 'difficulty': difficulty,
      if (elapsedDays != null) 'elapsed_days': elapsedDays,
      if (scheduledDays != null) 'scheduled_days': scheduledDays,
      if (reps != null) 'reps': reps,
      if (lapses != null) 'lapses': lapses,
      if (lastReviewAt != null) 'last_review_at': lastReviewAt,
      if (schedulerId != null) 'scheduler_id': schedulerId,
      if (paramsVersion != null) 'params_version': paramsVersion,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReviewCardsCompanion copyWith({
    Value<String>? questionId,
    Value<int>? state,
    Value<int?>? step,
    Value<int>? dueAt,
    Value<double?>? stability,
    Value<double?>? difficulty,
    Value<int>? elapsedDays,
    Value<int>? scheduledDays,
    Value<int>? reps,
    Value<int>? lapses,
    Value<int?>? lastReviewAt,
    Value<String>? schedulerId,
    Value<String>? paramsVersion,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return ReviewCardsCompanion(
      questionId: questionId ?? this.questionId,
      state: state ?? this.state,
      step: step ?? this.step,
      dueAt: dueAt ?? this.dueAt,
      stability: stability ?? this.stability,
      difficulty: difficulty ?? this.difficulty,
      elapsedDays: elapsedDays ?? this.elapsedDays,
      scheduledDays: scheduledDays ?? this.scheduledDays,
      reps: reps ?? this.reps,
      lapses: lapses ?? this.lapses,
      lastReviewAt: lastReviewAt ?? this.lastReviewAt,
      schedulerId: schedulerId ?? this.schedulerId,
      paramsVersion: paramsVersion ?? this.paramsVersion,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (questionId.present) {
      map['question_id'] = Variable<String>(questionId.value);
    }
    if (state.present) {
      map['state'] = Variable<int>(state.value);
    }
    if (step.present) {
      map['step'] = Variable<int>(step.value);
    }
    if (dueAt.present) {
      map['due_at'] = Variable<int>(dueAt.value);
    }
    if (stability.present) {
      map['stability'] = Variable<double>(stability.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<double>(difficulty.value);
    }
    if (elapsedDays.present) {
      map['elapsed_days'] = Variable<int>(elapsedDays.value);
    }
    if (scheduledDays.present) {
      map['scheduled_days'] = Variable<int>(scheduledDays.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (lapses.present) {
      map['lapses'] = Variable<int>(lapses.value);
    }
    if (lastReviewAt.present) {
      map['last_review_at'] = Variable<int>(lastReviewAt.value);
    }
    if (schedulerId.present) {
      map['scheduler_id'] = Variable<String>(schedulerId.value);
    }
    if (paramsVersion.present) {
      map['params_version'] = Variable<String>(paramsVersion.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewCardsCompanion(')
          ..write('questionId: $questionId, ')
          ..write('state: $state, ')
          ..write('step: $step, ')
          ..write('dueAt: $dueAt, ')
          ..write('stability: $stability, ')
          ..write('difficulty: $difficulty, ')
          ..write('elapsedDays: $elapsedDays, ')
          ..write('scheduledDays: $scheduledDays, ')
          ..write('reps: $reps, ')
          ..write('lapses: $lapses, ')
          ..write('lastReviewAt: $lastReviewAt, ')
          ..write('schedulerId: $schedulerId, ')
          ..write('paramsVersion: $paramsVersion, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReviewLogsTable extends ReviewLogs
    with TableInfo<$ReviewLogsTable, ReviewLogRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _questionIdMeta = const VerificationMeta(
    'questionId',
  );
  @override
  late final GeneratedColumn<String> questionId = GeneratedColumn<String>(
    'question_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES questions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
    'rating',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reviewedAtMeta = const VerificationMeta(
    'reviewedAt',
  );
  @override
  late final GeneratedColumn<int> reviewedAt = GeneratedColumn<int>(
    'reviewed_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _durationMsMeta = const VerificationMeta(
    'durationMs',
  );
  @override
  late final GeneratedColumn<int> durationMs = GeneratedColumn<int>(
    'duration_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usedHintMeta = const VerificationMeta(
    'usedHint',
  );
  @override
  late final GeneratedColumn<bool> usedHint = GeneratedColumn<bool>(
    'used_hint',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("used_hint" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _viewedAnswerMeta = const VerificationMeta(
    'viewedAnswer',
  );
  @override
  late final GeneratedColumn<bool> viewedAnswer = GeneratedColumn<bool>(
    'viewed_answer',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("viewed_answer" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _independentMeta = const VerificationMeta(
    'independent',
  );
  @override
  late final GeneratedColumn<bool> independent = GeneratedColumn<bool>(
    'independent',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("independent" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('review'),
  );
  static const VerificationMeta _stuckNodeIdsJsonMeta = const VerificationMeta(
    'stuckNodeIdsJson',
  );
  @override
  late final GeneratedColumn<String> stuckNodeIdsJson = GeneratedColumn<String>(
    'stuck_node_ids_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _errorTypeMeta = const VerificationMeta(
    'errorType',
  );
  @override
  late final GeneratedColumn<String> errorType = GeneratedColumn<String>(
    'error_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stateBeforeJsonMeta = const VerificationMeta(
    'stateBeforeJson',
  );
  @override
  late final GeneratedColumn<String> stateBeforeJson = GeneratedColumn<String>(
    'state_before_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stateAfterJsonMeta = const VerificationMeta(
    'stateAfterJson',
  );
  @override
  late final GeneratedColumn<String> stateAfterJson = GeneratedColumn<String>(
    'state_after_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _schedulerIdMeta = const VerificationMeta(
    'schedulerId',
  );
  @override
  late final GeneratedColumn<String> schedulerId = GeneratedColumn<String>(
    'scheduler_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paramsVersionMeta = const VerificationMeta(
    'paramsVersion',
  );
  @override
  late final GeneratedColumn<String> paramsVersion = GeneratedColumn<String>(
    'params_version',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    questionId,
    rating,
    reviewedAt,
    durationMs,
    usedHint,
    viewedAnswer,
    independent,
    kind,
    stuckNodeIdsJson,
    errorType,
    stateBeforeJson,
    stateAfterJson,
    schedulerId,
    paramsVersion,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'review_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReviewLogRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('question_id')) {
      context.handle(
        _questionIdMeta,
        questionId.isAcceptableOrUnknown(data['question_id']!, _questionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    }
    if (data.containsKey('reviewed_at')) {
      context.handle(
        _reviewedAtMeta,
        reviewedAt.isAcceptableOrUnknown(data['reviewed_at']!, _reviewedAtMeta),
      );
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
        _durationMsMeta,
        durationMs.isAcceptableOrUnknown(data['duration_ms']!, _durationMsMeta),
      );
    }
    if (data.containsKey('used_hint')) {
      context.handle(
        _usedHintMeta,
        usedHint.isAcceptableOrUnknown(data['used_hint']!, _usedHintMeta),
      );
    }
    if (data.containsKey('viewed_answer')) {
      context.handle(
        _viewedAnswerMeta,
        viewedAnswer.isAcceptableOrUnknown(
          data['viewed_answer']!,
          _viewedAnswerMeta,
        ),
      );
    }
    if (data.containsKey('independent')) {
      context.handle(
        _independentMeta,
        independent.isAcceptableOrUnknown(
          data['independent']!,
          _independentMeta,
        ),
      );
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    }
    if (data.containsKey('stuck_node_ids_json')) {
      context.handle(
        _stuckNodeIdsJsonMeta,
        stuckNodeIdsJson.isAcceptableOrUnknown(
          data['stuck_node_ids_json']!,
          _stuckNodeIdsJsonMeta,
        ),
      );
    }
    if (data.containsKey('error_type')) {
      context.handle(
        _errorTypeMeta,
        errorType.isAcceptableOrUnknown(data['error_type']!, _errorTypeMeta),
      );
    }
    if (data.containsKey('state_before_json')) {
      context.handle(
        _stateBeforeJsonMeta,
        stateBeforeJson.isAcceptableOrUnknown(
          data['state_before_json']!,
          _stateBeforeJsonMeta,
        ),
      );
    }
    if (data.containsKey('state_after_json')) {
      context.handle(
        _stateAfterJsonMeta,
        stateAfterJson.isAcceptableOrUnknown(
          data['state_after_json']!,
          _stateAfterJsonMeta,
        ),
      );
    }
    if (data.containsKey('scheduler_id')) {
      context.handle(
        _schedulerIdMeta,
        schedulerId.isAcceptableOrUnknown(
          data['scheduler_id']!,
          _schedulerIdMeta,
        ),
      );
    }
    if (data.containsKey('params_version')) {
      context.handle(
        _paramsVersionMeta,
        paramsVersion.isAcceptableOrUnknown(
          data['params_version']!,
          _paramsVersionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReviewLogRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewLogRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      questionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_id'],
      )!,
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rating'],
      ),
      reviewedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reviewed_at'],
      )!,
      durationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_ms'],
      ),
      usedHint: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}used_hint'],
      )!,
      viewedAnswer: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}viewed_answer'],
      )!,
      independent: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}independent'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      stuckNodeIdsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stuck_node_ids_json'],
      ),
      errorType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_type'],
      ),
      stateBeforeJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state_before_json'],
      ),
      stateAfterJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state_after_json'],
      ),
      schedulerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scheduler_id'],
      ),
      paramsVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}params_version'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ReviewLogsTable createAlias(String alias) {
    return $ReviewLogsTable(attachedDatabase, alias);
  }
}

class ReviewLogRow extends DataClass implements Insertable<ReviewLogRow> {
  final String id;
  final String questionId;
  final int? rating;
  final int reviewedAt;
  final int? durationMs;
  final bool usedHint;
  final bool viewedAnswer;
  final bool independent;
  final String kind;
  final String? stuckNodeIdsJson;
  final String? errorType;
  final String? stateBeforeJson;
  final String? stateAfterJson;
  final String? schedulerId;
  final String? paramsVersion;
  final int createdAt;
  const ReviewLogRow({
    required this.id,
    required this.questionId,
    this.rating,
    required this.reviewedAt,
    this.durationMs,
    required this.usedHint,
    required this.viewedAnswer,
    required this.independent,
    required this.kind,
    this.stuckNodeIdsJson,
    this.errorType,
    this.stateBeforeJson,
    this.stateAfterJson,
    this.schedulerId,
    this.paramsVersion,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['question_id'] = Variable<String>(questionId);
    if (!nullToAbsent || rating != null) {
      map['rating'] = Variable<int>(rating);
    }
    map['reviewed_at'] = Variable<int>(reviewedAt);
    if (!nullToAbsent || durationMs != null) {
      map['duration_ms'] = Variable<int>(durationMs);
    }
    map['used_hint'] = Variable<bool>(usedHint);
    map['viewed_answer'] = Variable<bool>(viewedAnswer);
    map['independent'] = Variable<bool>(independent);
    map['kind'] = Variable<String>(kind);
    if (!nullToAbsent || stuckNodeIdsJson != null) {
      map['stuck_node_ids_json'] = Variable<String>(stuckNodeIdsJson);
    }
    if (!nullToAbsent || errorType != null) {
      map['error_type'] = Variable<String>(errorType);
    }
    if (!nullToAbsent || stateBeforeJson != null) {
      map['state_before_json'] = Variable<String>(stateBeforeJson);
    }
    if (!nullToAbsent || stateAfterJson != null) {
      map['state_after_json'] = Variable<String>(stateAfterJson);
    }
    if (!nullToAbsent || schedulerId != null) {
      map['scheduler_id'] = Variable<String>(schedulerId);
    }
    if (!nullToAbsent || paramsVersion != null) {
      map['params_version'] = Variable<String>(paramsVersion);
    }
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  ReviewLogsCompanion toCompanion(bool nullToAbsent) {
    return ReviewLogsCompanion(
      id: Value(id),
      questionId: Value(questionId),
      rating: rating == null && nullToAbsent
          ? const Value.absent()
          : Value(rating),
      reviewedAt: Value(reviewedAt),
      durationMs: durationMs == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMs),
      usedHint: Value(usedHint),
      viewedAnswer: Value(viewedAnswer),
      independent: Value(independent),
      kind: Value(kind),
      stuckNodeIdsJson: stuckNodeIdsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(stuckNodeIdsJson),
      errorType: errorType == null && nullToAbsent
          ? const Value.absent()
          : Value(errorType),
      stateBeforeJson: stateBeforeJson == null && nullToAbsent
          ? const Value.absent()
          : Value(stateBeforeJson),
      stateAfterJson: stateAfterJson == null && nullToAbsent
          ? const Value.absent()
          : Value(stateAfterJson),
      schedulerId: schedulerId == null && nullToAbsent
          ? const Value.absent()
          : Value(schedulerId),
      paramsVersion: paramsVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(paramsVersion),
      createdAt: Value(createdAt),
    );
  }

  factory ReviewLogRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewLogRow(
      id: serializer.fromJson<String>(json['id']),
      questionId: serializer.fromJson<String>(json['questionId']),
      rating: serializer.fromJson<int?>(json['rating']),
      reviewedAt: serializer.fromJson<int>(json['reviewedAt']),
      durationMs: serializer.fromJson<int?>(json['durationMs']),
      usedHint: serializer.fromJson<bool>(json['usedHint']),
      viewedAnswer: serializer.fromJson<bool>(json['viewedAnswer']),
      independent: serializer.fromJson<bool>(json['independent']),
      kind: serializer.fromJson<String>(json['kind']),
      stuckNodeIdsJson: serializer.fromJson<String?>(json['stuckNodeIdsJson']),
      errorType: serializer.fromJson<String?>(json['errorType']),
      stateBeforeJson: serializer.fromJson<String?>(json['stateBeforeJson']),
      stateAfterJson: serializer.fromJson<String?>(json['stateAfterJson']),
      schedulerId: serializer.fromJson<String?>(json['schedulerId']),
      paramsVersion: serializer.fromJson<String?>(json['paramsVersion']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'questionId': serializer.toJson<String>(questionId),
      'rating': serializer.toJson<int?>(rating),
      'reviewedAt': serializer.toJson<int>(reviewedAt),
      'durationMs': serializer.toJson<int?>(durationMs),
      'usedHint': serializer.toJson<bool>(usedHint),
      'viewedAnswer': serializer.toJson<bool>(viewedAnswer),
      'independent': serializer.toJson<bool>(independent),
      'kind': serializer.toJson<String>(kind),
      'stuckNodeIdsJson': serializer.toJson<String?>(stuckNodeIdsJson),
      'errorType': serializer.toJson<String?>(errorType),
      'stateBeforeJson': serializer.toJson<String?>(stateBeforeJson),
      'stateAfterJson': serializer.toJson<String?>(stateAfterJson),
      'schedulerId': serializer.toJson<String?>(schedulerId),
      'paramsVersion': serializer.toJson<String?>(paramsVersion),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  ReviewLogRow copyWith({
    String? id,
    String? questionId,
    Value<int?> rating = const Value.absent(),
    int? reviewedAt,
    Value<int?> durationMs = const Value.absent(),
    bool? usedHint,
    bool? viewedAnswer,
    bool? independent,
    String? kind,
    Value<String?> stuckNodeIdsJson = const Value.absent(),
    Value<String?> errorType = const Value.absent(),
    Value<String?> stateBeforeJson = const Value.absent(),
    Value<String?> stateAfterJson = const Value.absent(),
    Value<String?> schedulerId = const Value.absent(),
    Value<String?> paramsVersion = const Value.absent(),
    int? createdAt,
  }) => ReviewLogRow(
    id: id ?? this.id,
    questionId: questionId ?? this.questionId,
    rating: rating.present ? rating.value : this.rating,
    reviewedAt: reviewedAt ?? this.reviewedAt,
    durationMs: durationMs.present ? durationMs.value : this.durationMs,
    usedHint: usedHint ?? this.usedHint,
    viewedAnswer: viewedAnswer ?? this.viewedAnswer,
    independent: independent ?? this.independent,
    kind: kind ?? this.kind,
    stuckNodeIdsJson: stuckNodeIdsJson.present
        ? stuckNodeIdsJson.value
        : this.stuckNodeIdsJson,
    errorType: errorType.present ? errorType.value : this.errorType,
    stateBeforeJson: stateBeforeJson.present
        ? stateBeforeJson.value
        : this.stateBeforeJson,
    stateAfterJson: stateAfterJson.present
        ? stateAfterJson.value
        : this.stateAfterJson,
    schedulerId: schedulerId.present ? schedulerId.value : this.schedulerId,
    paramsVersion: paramsVersion.present
        ? paramsVersion.value
        : this.paramsVersion,
    createdAt: createdAt ?? this.createdAt,
  );
  ReviewLogRow copyWithCompanion(ReviewLogsCompanion data) {
    return ReviewLogRow(
      id: data.id.present ? data.id.value : this.id,
      questionId: data.questionId.present
          ? data.questionId.value
          : this.questionId,
      rating: data.rating.present ? data.rating.value : this.rating,
      reviewedAt: data.reviewedAt.present
          ? data.reviewedAt.value
          : this.reviewedAt,
      durationMs: data.durationMs.present
          ? data.durationMs.value
          : this.durationMs,
      usedHint: data.usedHint.present ? data.usedHint.value : this.usedHint,
      viewedAnswer: data.viewedAnswer.present
          ? data.viewedAnswer.value
          : this.viewedAnswer,
      independent: data.independent.present
          ? data.independent.value
          : this.independent,
      kind: data.kind.present ? data.kind.value : this.kind,
      stuckNodeIdsJson: data.stuckNodeIdsJson.present
          ? data.stuckNodeIdsJson.value
          : this.stuckNodeIdsJson,
      errorType: data.errorType.present ? data.errorType.value : this.errorType,
      stateBeforeJson: data.stateBeforeJson.present
          ? data.stateBeforeJson.value
          : this.stateBeforeJson,
      stateAfterJson: data.stateAfterJson.present
          ? data.stateAfterJson.value
          : this.stateAfterJson,
      schedulerId: data.schedulerId.present
          ? data.schedulerId.value
          : this.schedulerId,
      paramsVersion: data.paramsVersion.present
          ? data.paramsVersion.value
          : this.paramsVersion,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReviewLogRow(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('rating: $rating, ')
          ..write('reviewedAt: $reviewedAt, ')
          ..write('durationMs: $durationMs, ')
          ..write('usedHint: $usedHint, ')
          ..write('viewedAnswer: $viewedAnswer, ')
          ..write('independent: $independent, ')
          ..write('kind: $kind, ')
          ..write('stuckNodeIdsJson: $stuckNodeIdsJson, ')
          ..write('errorType: $errorType, ')
          ..write('stateBeforeJson: $stateBeforeJson, ')
          ..write('stateAfterJson: $stateAfterJson, ')
          ..write('schedulerId: $schedulerId, ')
          ..write('paramsVersion: $paramsVersion, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    questionId,
    rating,
    reviewedAt,
    durationMs,
    usedHint,
    viewedAnswer,
    independent,
    kind,
    stuckNodeIdsJson,
    errorType,
    stateBeforeJson,
    stateAfterJson,
    schedulerId,
    paramsVersion,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewLogRow &&
          other.id == this.id &&
          other.questionId == this.questionId &&
          other.rating == this.rating &&
          other.reviewedAt == this.reviewedAt &&
          other.durationMs == this.durationMs &&
          other.usedHint == this.usedHint &&
          other.viewedAnswer == this.viewedAnswer &&
          other.independent == this.independent &&
          other.kind == this.kind &&
          other.stuckNodeIdsJson == this.stuckNodeIdsJson &&
          other.errorType == this.errorType &&
          other.stateBeforeJson == this.stateBeforeJson &&
          other.stateAfterJson == this.stateAfterJson &&
          other.schedulerId == this.schedulerId &&
          other.paramsVersion == this.paramsVersion &&
          other.createdAt == this.createdAt);
}

class ReviewLogsCompanion extends UpdateCompanion<ReviewLogRow> {
  final Value<String> id;
  final Value<String> questionId;
  final Value<int?> rating;
  final Value<int> reviewedAt;
  final Value<int?> durationMs;
  final Value<bool> usedHint;
  final Value<bool> viewedAnswer;
  final Value<bool> independent;
  final Value<String> kind;
  final Value<String?> stuckNodeIdsJson;
  final Value<String?> errorType;
  final Value<String?> stateBeforeJson;
  final Value<String?> stateAfterJson;
  final Value<String?> schedulerId;
  final Value<String?> paramsVersion;
  final Value<int> createdAt;
  final Value<int> rowid;
  const ReviewLogsCompanion({
    this.id = const Value.absent(),
    this.questionId = const Value.absent(),
    this.rating = const Value.absent(),
    this.reviewedAt = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.usedHint = const Value.absent(),
    this.viewedAnswer = const Value.absent(),
    this.independent = const Value.absent(),
    this.kind = const Value.absent(),
    this.stuckNodeIdsJson = const Value.absent(),
    this.errorType = const Value.absent(),
    this.stateBeforeJson = const Value.absent(),
    this.stateAfterJson = const Value.absent(),
    this.schedulerId = const Value.absent(),
    this.paramsVersion = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReviewLogsCompanion.insert({
    required String id,
    required String questionId,
    this.rating = const Value.absent(),
    this.reviewedAt = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.usedHint = const Value.absent(),
    this.viewedAnswer = const Value.absent(),
    this.independent = const Value.absent(),
    this.kind = const Value.absent(),
    this.stuckNodeIdsJson = const Value.absent(),
    this.errorType = const Value.absent(),
    this.stateBeforeJson = const Value.absent(),
    this.stateAfterJson = const Value.absent(),
    this.schedulerId = const Value.absent(),
    this.paramsVersion = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       questionId = Value(questionId);
  static Insertable<ReviewLogRow> custom({
    Expression<String>? id,
    Expression<String>? questionId,
    Expression<int>? rating,
    Expression<int>? reviewedAt,
    Expression<int>? durationMs,
    Expression<bool>? usedHint,
    Expression<bool>? viewedAnswer,
    Expression<bool>? independent,
    Expression<String>? kind,
    Expression<String>? stuckNodeIdsJson,
    Expression<String>? errorType,
    Expression<String>? stateBeforeJson,
    Expression<String>? stateAfterJson,
    Expression<String>? schedulerId,
    Expression<String>? paramsVersion,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (questionId != null) 'question_id': questionId,
      if (rating != null) 'rating': rating,
      if (reviewedAt != null) 'reviewed_at': reviewedAt,
      if (durationMs != null) 'duration_ms': durationMs,
      if (usedHint != null) 'used_hint': usedHint,
      if (viewedAnswer != null) 'viewed_answer': viewedAnswer,
      if (independent != null) 'independent': independent,
      if (kind != null) 'kind': kind,
      if (stuckNodeIdsJson != null) 'stuck_node_ids_json': stuckNodeIdsJson,
      if (errorType != null) 'error_type': errorType,
      if (stateBeforeJson != null) 'state_before_json': stateBeforeJson,
      if (stateAfterJson != null) 'state_after_json': stateAfterJson,
      if (schedulerId != null) 'scheduler_id': schedulerId,
      if (paramsVersion != null) 'params_version': paramsVersion,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReviewLogsCompanion copyWith({
    Value<String>? id,
    Value<String>? questionId,
    Value<int?>? rating,
    Value<int>? reviewedAt,
    Value<int?>? durationMs,
    Value<bool>? usedHint,
    Value<bool>? viewedAnswer,
    Value<bool>? independent,
    Value<String>? kind,
    Value<String?>? stuckNodeIdsJson,
    Value<String?>? errorType,
    Value<String?>? stateBeforeJson,
    Value<String?>? stateAfterJson,
    Value<String?>? schedulerId,
    Value<String?>? paramsVersion,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return ReviewLogsCompanion(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      rating: rating ?? this.rating,
      reviewedAt: reviewedAt ?? this.reviewedAt,
      durationMs: durationMs ?? this.durationMs,
      usedHint: usedHint ?? this.usedHint,
      viewedAnswer: viewedAnswer ?? this.viewedAnswer,
      independent: independent ?? this.independent,
      kind: kind ?? this.kind,
      stuckNodeIdsJson: stuckNodeIdsJson ?? this.stuckNodeIdsJson,
      errorType: errorType ?? this.errorType,
      stateBeforeJson: stateBeforeJson ?? this.stateBeforeJson,
      stateAfterJson: stateAfterJson ?? this.stateAfterJson,
      schedulerId: schedulerId ?? this.schedulerId,
      paramsVersion: paramsVersion ?? this.paramsVersion,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<String>(questionId.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (reviewedAt.present) {
      map['reviewed_at'] = Variable<int>(reviewedAt.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    if (usedHint.present) {
      map['used_hint'] = Variable<bool>(usedHint.value);
    }
    if (viewedAnswer.present) {
      map['viewed_answer'] = Variable<bool>(viewedAnswer.value);
    }
    if (independent.present) {
      map['independent'] = Variable<bool>(independent.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (stuckNodeIdsJson.present) {
      map['stuck_node_ids_json'] = Variable<String>(stuckNodeIdsJson.value);
    }
    if (errorType.present) {
      map['error_type'] = Variable<String>(errorType.value);
    }
    if (stateBeforeJson.present) {
      map['state_before_json'] = Variable<String>(stateBeforeJson.value);
    }
    if (stateAfterJson.present) {
      map['state_after_json'] = Variable<String>(stateAfterJson.value);
    }
    if (schedulerId.present) {
      map['scheduler_id'] = Variable<String>(schedulerId.value);
    }
    if (paramsVersion.present) {
      map['params_version'] = Variable<String>(paramsVersion.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewLogsCompanion(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('rating: $rating, ')
          ..write('reviewedAt: $reviewedAt, ')
          ..write('durationMs: $durationMs, ')
          ..write('usedHint: $usedHint, ')
          ..write('viewedAnswer: $viewedAnswer, ')
          ..write('independent: $independent, ')
          ..write('kind: $kind, ')
          ..write('stuckNodeIdsJson: $stuckNodeIdsJson, ')
          ..write('errorType: $errorType, ')
          ..write('stateBeforeJson: $stateBeforeJson, ')
          ..write('stateAfterJson: $stateAfterJson, ')
          ..write('schedulerId: $schedulerId, ')
          ..write('paramsVersion: $paramsVersion, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DraftsTable extends Drafts with TableInfo<$DraftsTable, DraftRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DraftsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('camera'),
  );
  static const VerificationMeta _imageSha256Meta = const VerificationMeta(
    'imageSha256',
  );
  @override
  late final GeneratedColumn<String> imageSha256 = GeneratedColumn<String>(
    'image_sha256',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tempImagePathMeta = const VerificationMeta(
    'tempImagePath',
  );
  @override
  late final GeneratedColumn<String> tempImagePath = GeneratedColumn<String>(
    'temp_image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _aiRawJsonMeta = const VerificationMeta(
    'aiRawJson',
  );
  @override
  late final GeneratedColumn<String> aiRawJson = GeneratedColumn<String>(
    'ai_raw_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _aiProviderMeta = const VerificationMeta(
    'aiProvider',
  );
  @override
  late final GeneratedColumn<String> aiProvider = GeneratedColumn<String>(
    'ai_provider',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _aiModelMeta = const VerificationMeta(
    'aiModel',
  );
  @override
  late final GeneratedColumn<String> aiModel = GeneratedColumn<String>(
    'ai_model',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _aiPromptVersionMeta = const VerificationMeta(
    'aiPromptVersion',
  );
  @override
  late final GeneratedColumn<String> aiPromptVersion = GeneratedColumn<String>(
    'ai_prompt_version',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('captured'),
  );
  static const VerificationMeta _errorCodeMeta = const VerificationMeta(
    'errorCode',
  );
  @override
  late final GeneratedColumn<String> errorCode = GeneratedColumn<String>(
    'error_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<int> expiresAt = GeneratedColumn<int>(
    'expires_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    source,
    imageSha256,
    tempImagePath,
    aiRawJson,
    aiProvider,
    aiModel,
    aiPromptVersion,
    status,
    errorCode,
    createdAt,
    expiresAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drafts';
  @override
  VerificationContext validateIntegrity(
    Insertable<DraftRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('image_sha256')) {
      context.handle(
        _imageSha256Meta,
        imageSha256.isAcceptableOrUnknown(
          data['image_sha256']!,
          _imageSha256Meta,
        ),
      );
    }
    if (data.containsKey('temp_image_path')) {
      context.handle(
        _tempImagePathMeta,
        tempImagePath.isAcceptableOrUnknown(
          data['temp_image_path']!,
          _tempImagePathMeta,
        ),
      );
    }
    if (data.containsKey('ai_raw_json')) {
      context.handle(
        _aiRawJsonMeta,
        aiRawJson.isAcceptableOrUnknown(data['ai_raw_json']!, _aiRawJsonMeta),
      );
    }
    if (data.containsKey('ai_provider')) {
      context.handle(
        _aiProviderMeta,
        aiProvider.isAcceptableOrUnknown(data['ai_provider']!, _aiProviderMeta),
      );
    }
    if (data.containsKey('ai_model')) {
      context.handle(
        _aiModelMeta,
        aiModel.isAcceptableOrUnknown(data['ai_model']!, _aiModelMeta),
      );
    }
    if (data.containsKey('ai_prompt_version')) {
      context.handle(
        _aiPromptVersionMeta,
        aiPromptVersion.isAcceptableOrUnknown(
          data['ai_prompt_version']!,
          _aiPromptVersionMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('error_code')) {
      context.handle(
        _errorCodeMeta,
        errorCode.isAcceptableOrUnknown(data['error_code']!, _errorCodeMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DraftRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DraftRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      imageSha256: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_sha256'],
      ),
      tempImagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}temp_image_path'],
      ),
      aiRawJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ai_raw_json'],
      ),
      aiProvider: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ai_provider'],
      ),
      aiModel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ai_model'],
      ),
      aiPromptVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ai_prompt_version'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      errorCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_code'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expires_at'],
      )!,
    );
  }

  @override
  $DraftsTable createAlias(String alias) {
    return $DraftsTable(attachedDatabase, alias);
  }
}

class DraftRow extends DataClass implements Insertable<DraftRow> {
  final String id;
  final String source;
  final String? imageSha256;
  final String? tempImagePath;
  final String? aiRawJson;
  final String? aiProvider;
  final String? aiModel;
  final String? aiPromptVersion;
  final String status;
  final String? errorCode;
  final int createdAt;
  final int expiresAt;
  const DraftRow({
    required this.id,
    required this.source,
    this.imageSha256,
    this.tempImagePath,
    this.aiRawJson,
    this.aiProvider,
    this.aiModel,
    this.aiPromptVersion,
    required this.status,
    this.errorCode,
    required this.createdAt,
    required this.expiresAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || imageSha256 != null) {
      map['image_sha256'] = Variable<String>(imageSha256);
    }
    if (!nullToAbsent || tempImagePath != null) {
      map['temp_image_path'] = Variable<String>(tempImagePath);
    }
    if (!nullToAbsent || aiRawJson != null) {
      map['ai_raw_json'] = Variable<String>(aiRawJson);
    }
    if (!nullToAbsent || aiProvider != null) {
      map['ai_provider'] = Variable<String>(aiProvider);
    }
    if (!nullToAbsent || aiModel != null) {
      map['ai_model'] = Variable<String>(aiModel);
    }
    if (!nullToAbsent || aiPromptVersion != null) {
      map['ai_prompt_version'] = Variable<String>(aiPromptVersion);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || errorCode != null) {
      map['error_code'] = Variable<String>(errorCode);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['expires_at'] = Variable<int>(expiresAt);
    return map;
  }

  DraftsCompanion toCompanion(bool nullToAbsent) {
    return DraftsCompanion(
      id: Value(id),
      source: Value(source),
      imageSha256: imageSha256 == null && nullToAbsent
          ? const Value.absent()
          : Value(imageSha256),
      tempImagePath: tempImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(tempImagePath),
      aiRawJson: aiRawJson == null && nullToAbsent
          ? const Value.absent()
          : Value(aiRawJson),
      aiProvider: aiProvider == null && nullToAbsent
          ? const Value.absent()
          : Value(aiProvider),
      aiModel: aiModel == null && nullToAbsent
          ? const Value.absent()
          : Value(aiModel),
      aiPromptVersion: aiPromptVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(aiPromptVersion),
      status: Value(status),
      errorCode: errorCode == null && nullToAbsent
          ? const Value.absent()
          : Value(errorCode),
      createdAt: Value(createdAt),
      expiresAt: Value(expiresAt),
    );
  }

  factory DraftRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DraftRow(
      id: serializer.fromJson<String>(json['id']),
      source: serializer.fromJson<String>(json['source']),
      imageSha256: serializer.fromJson<String?>(json['imageSha256']),
      tempImagePath: serializer.fromJson<String?>(json['tempImagePath']),
      aiRawJson: serializer.fromJson<String?>(json['aiRawJson']),
      aiProvider: serializer.fromJson<String?>(json['aiProvider']),
      aiModel: serializer.fromJson<String?>(json['aiModel']),
      aiPromptVersion: serializer.fromJson<String?>(json['aiPromptVersion']),
      status: serializer.fromJson<String>(json['status']),
      errorCode: serializer.fromJson<String?>(json['errorCode']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      expiresAt: serializer.fromJson<int>(json['expiresAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'source': serializer.toJson<String>(source),
      'imageSha256': serializer.toJson<String?>(imageSha256),
      'tempImagePath': serializer.toJson<String?>(tempImagePath),
      'aiRawJson': serializer.toJson<String?>(aiRawJson),
      'aiProvider': serializer.toJson<String?>(aiProvider),
      'aiModel': serializer.toJson<String?>(aiModel),
      'aiPromptVersion': serializer.toJson<String?>(aiPromptVersion),
      'status': serializer.toJson<String>(status),
      'errorCode': serializer.toJson<String?>(errorCode),
      'createdAt': serializer.toJson<int>(createdAt),
      'expiresAt': serializer.toJson<int>(expiresAt),
    };
  }

  DraftRow copyWith({
    String? id,
    String? source,
    Value<String?> imageSha256 = const Value.absent(),
    Value<String?> tempImagePath = const Value.absent(),
    Value<String?> aiRawJson = const Value.absent(),
    Value<String?> aiProvider = const Value.absent(),
    Value<String?> aiModel = const Value.absent(),
    Value<String?> aiPromptVersion = const Value.absent(),
    String? status,
    Value<String?> errorCode = const Value.absent(),
    int? createdAt,
    int? expiresAt,
  }) => DraftRow(
    id: id ?? this.id,
    source: source ?? this.source,
    imageSha256: imageSha256.present ? imageSha256.value : this.imageSha256,
    tempImagePath: tempImagePath.present
        ? tempImagePath.value
        : this.tempImagePath,
    aiRawJson: aiRawJson.present ? aiRawJson.value : this.aiRawJson,
    aiProvider: aiProvider.present ? aiProvider.value : this.aiProvider,
    aiModel: aiModel.present ? aiModel.value : this.aiModel,
    aiPromptVersion: aiPromptVersion.present
        ? aiPromptVersion.value
        : this.aiPromptVersion,
    status: status ?? this.status,
    errorCode: errorCode.present ? errorCode.value : this.errorCode,
    createdAt: createdAt ?? this.createdAt,
    expiresAt: expiresAt ?? this.expiresAt,
  );
  DraftRow copyWithCompanion(DraftsCompanion data) {
    return DraftRow(
      id: data.id.present ? data.id.value : this.id,
      source: data.source.present ? data.source.value : this.source,
      imageSha256: data.imageSha256.present
          ? data.imageSha256.value
          : this.imageSha256,
      tempImagePath: data.tempImagePath.present
          ? data.tempImagePath.value
          : this.tempImagePath,
      aiRawJson: data.aiRawJson.present ? data.aiRawJson.value : this.aiRawJson,
      aiProvider: data.aiProvider.present
          ? data.aiProvider.value
          : this.aiProvider,
      aiModel: data.aiModel.present ? data.aiModel.value : this.aiModel,
      aiPromptVersion: data.aiPromptVersion.present
          ? data.aiPromptVersion.value
          : this.aiPromptVersion,
      status: data.status.present ? data.status.value : this.status,
      errorCode: data.errorCode.present ? data.errorCode.value : this.errorCode,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DraftRow(')
          ..write('id: $id, ')
          ..write('source: $source, ')
          ..write('imageSha256: $imageSha256, ')
          ..write('tempImagePath: $tempImagePath, ')
          ..write('aiRawJson: $aiRawJson, ')
          ..write('aiProvider: $aiProvider, ')
          ..write('aiModel: $aiModel, ')
          ..write('aiPromptVersion: $aiPromptVersion, ')
          ..write('status: $status, ')
          ..write('errorCode: $errorCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('expiresAt: $expiresAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    source,
    imageSha256,
    tempImagePath,
    aiRawJson,
    aiProvider,
    aiModel,
    aiPromptVersion,
    status,
    errorCode,
    createdAt,
    expiresAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DraftRow &&
          other.id == this.id &&
          other.source == this.source &&
          other.imageSha256 == this.imageSha256 &&
          other.tempImagePath == this.tempImagePath &&
          other.aiRawJson == this.aiRawJson &&
          other.aiProvider == this.aiProvider &&
          other.aiModel == this.aiModel &&
          other.aiPromptVersion == this.aiPromptVersion &&
          other.status == this.status &&
          other.errorCode == this.errorCode &&
          other.createdAt == this.createdAt &&
          other.expiresAt == this.expiresAt);
}

class DraftsCompanion extends UpdateCompanion<DraftRow> {
  final Value<String> id;
  final Value<String> source;
  final Value<String?> imageSha256;
  final Value<String?> tempImagePath;
  final Value<String?> aiRawJson;
  final Value<String?> aiProvider;
  final Value<String?> aiModel;
  final Value<String?> aiPromptVersion;
  final Value<String> status;
  final Value<String?> errorCode;
  final Value<int> createdAt;
  final Value<int> expiresAt;
  final Value<int> rowid;
  const DraftsCompanion({
    this.id = const Value.absent(),
    this.source = const Value.absent(),
    this.imageSha256 = const Value.absent(),
    this.tempImagePath = const Value.absent(),
    this.aiRawJson = const Value.absent(),
    this.aiProvider = const Value.absent(),
    this.aiModel = const Value.absent(),
    this.aiPromptVersion = const Value.absent(),
    this.status = const Value.absent(),
    this.errorCode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DraftsCompanion.insert({
    required String id,
    this.source = const Value.absent(),
    this.imageSha256 = const Value.absent(),
    this.tempImagePath = const Value.absent(),
    this.aiRawJson = const Value.absent(),
    this.aiProvider = const Value.absent(),
    this.aiModel = const Value.absent(),
    this.aiPromptVersion = const Value.absent(),
    this.status = const Value.absent(),
    this.errorCode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<DraftRow> custom({
    Expression<String>? id,
    Expression<String>? source,
    Expression<String>? imageSha256,
    Expression<String>? tempImagePath,
    Expression<String>? aiRawJson,
    Expression<String>? aiProvider,
    Expression<String>? aiModel,
    Expression<String>? aiPromptVersion,
    Expression<String>? status,
    Expression<String>? errorCode,
    Expression<int>? createdAt,
    Expression<int>? expiresAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (source != null) 'source': source,
      if (imageSha256 != null) 'image_sha256': imageSha256,
      if (tempImagePath != null) 'temp_image_path': tempImagePath,
      if (aiRawJson != null) 'ai_raw_json': aiRawJson,
      if (aiProvider != null) 'ai_provider': aiProvider,
      if (aiModel != null) 'ai_model': aiModel,
      if (aiPromptVersion != null) 'ai_prompt_version': aiPromptVersion,
      if (status != null) 'status': status,
      if (errorCode != null) 'error_code': errorCode,
      if (createdAt != null) 'created_at': createdAt,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DraftsCompanion copyWith({
    Value<String>? id,
    Value<String>? source,
    Value<String?>? imageSha256,
    Value<String?>? tempImagePath,
    Value<String?>? aiRawJson,
    Value<String?>? aiProvider,
    Value<String?>? aiModel,
    Value<String?>? aiPromptVersion,
    Value<String>? status,
    Value<String?>? errorCode,
    Value<int>? createdAt,
    Value<int>? expiresAt,
    Value<int>? rowid,
  }) {
    return DraftsCompanion(
      id: id ?? this.id,
      source: source ?? this.source,
      imageSha256: imageSha256 ?? this.imageSha256,
      tempImagePath: tempImagePath ?? this.tempImagePath,
      aiRawJson: aiRawJson ?? this.aiRawJson,
      aiProvider: aiProvider ?? this.aiProvider,
      aiModel: aiModel ?? this.aiModel,
      aiPromptVersion: aiPromptVersion ?? this.aiPromptVersion,
      status: status ?? this.status,
      errorCode: errorCode ?? this.errorCode,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (imageSha256.present) {
      map['image_sha256'] = Variable<String>(imageSha256.value);
    }
    if (tempImagePath.present) {
      map['temp_image_path'] = Variable<String>(tempImagePath.value);
    }
    if (aiRawJson.present) {
      map['ai_raw_json'] = Variable<String>(aiRawJson.value);
    }
    if (aiProvider.present) {
      map['ai_provider'] = Variable<String>(aiProvider.value);
    }
    if (aiModel.present) {
      map['ai_model'] = Variable<String>(aiModel.value);
    }
    if (aiPromptVersion.present) {
      map['ai_prompt_version'] = Variable<String>(aiPromptVersion.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (errorCode.present) {
      map['error_code'] = Variable<String>(errorCode.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<int>(expiresAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DraftsCompanion(')
          ..write('id: $id, ')
          ..write('source: $source, ')
          ..write('imageSha256: $imageSha256, ')
          ..write('tempImagePath: $tempImagePath, ')
          ..write('aiRawJson: $aiRawJson, ')
          ..write('aiProvider: $aiProvider, ')
          ..write('aiModel: $aiModel, ')
          ..write('aiPromptVersion: $aiPromptVersion, ')
          ..write('status: $status, ')
          ..write('errorCode: $errorCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DraftItemsTable extends DraftItems
    with TableInfo<$DraftItemsTable, DraftItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DraftItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _draftIdMeta = const VerificationMeta(
    'draftId',
  );
  @override
  late final GeneratedColumn<String> draftId = GeneratedColumn<String>(
    'draft_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES drafts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _promptLatexMeta = const VerificationMeta(
    'promptLatex',
  );
  @override
  late final GeneratedColumn<String> promptLatex = GeneratedColumn<String>(
    'prompt_latex',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _answerLatexMeta = const VerificationMeta(
    'answerLatex',
  );
  @override
  late final GeneratedColumn<String> answerLatex = GeneratedColumn<String>(
    'answer_latex',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _solutionLatexMeta = const VerificationMeta(
    'solutionLatex',
  );
  @override
  late final GeneratedColumn<String> solutionLatex = GeneratedColumn<String>(
    'solution_latex',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _knowledgePointsJsonMeta =
      const VerificationMeta('knowledgePointsJson');
  @override
  late final GeneratedColumn<String> knowledgePointsJson =
      GeneratedColumn<String>(
        'knowledge_points_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSelectedMeta = const VerificationMeta(
    'isSelected',
  );
  @override
  late final GeneratedColumn<bool> isSelected = GeneratedColumn<bool>(
    'is_selected',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_selected" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdQuestionIdMeta = const VerificationMeta(
    'createdQuestionId',
  );
  @override
  late final GeneratedColumn<String> createdQuestionId =
      GeneratedColumn<String>(
        'created_question_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    draftId,
    sortOrder,
    promptLatex,
    answerLatex,
    solutionLatex,
    knowledgePointsJson,
    confidence,
    isSelected,
    createdQuestionId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'draft_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<DraftItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('draft_id')) {
      context.handle(
        _draftIdMeta,
        draftId.isAcceptableOrUnknown(data['draft_id']!, _draftIdMeta),
      );
    } else if (isInserting) {
      context.missing(_draftIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('prompt_latex')) {
      context.handle(
        _promptLatexMeta,
        promptLatex.isAcceptableOrUnknown(
          data['prompt_latex']!,
          _promptLatexMeta,
        ),
      );
    }
    if (data.containsKey('answer_latex')) {
      context.handle(
        _answerLatexMeta,
        answerLatex.isAcceptableOrUnknown(
          data['answer_latex']!,
          _answerLatexMeta,
        ),
      );
    }
    if (data.containsKey('solution_latex')) {
      context.handle(
        _solutionLatexMeta,
        solutionLatex.isAcceptableOrUnknown(
          data['solution_latex']!,
          _solutionLatexMeta,
        ),
      );
    }
    if (data.containsKey('knowledge_points_json')) {
      context.handle(
        _knowledgePointsJsonMeta,
        knowledgePointsJson.isAcceptableOrUnknown(
          data['knowledge_points_json']!,
          _knowledgePointsJsonMeta,
        ),
      );
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    }
    if (data.containsKey('is_selected')) {
      context.handle(
        _isSelectedMeta,
        isSelected.isAcceptableOrUnknown(data['is_selected']!, _isSelectedMeta),
      );
    }
    if (data.containsKey('created_question_id')) {
      context.handle(
        _createdQuestionIdMeta,
        createdQuestionId.isAcceptableOrUnknown(
          data['created_question_id']!,
          _createdQuestionIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DraftItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DraftItemRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      draftId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}draft_id'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      promptLatex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prompt_latex'],
      ),
      answerLatex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}answer_latex'],
      ),
      solutionLatex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}solution_latex'],
      ),
      knowledgePointsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}knowledge_points_json'],
      ),
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      ),
      isSelected: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_selected'],
      )!,
      createdQuestionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_question_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $DraftItemsTable createAlias(String alias) {
    return $DraftItemsTable(attachedDatabase, alias);
  }
}

class DraftItemRow extends DataClass implements Insertable<DraftItemRow> {
  final String id;
  final String draftId;
  final int sortOrder;
  final String? promptLatex;
  final String? answerLatex;
  final String? solutionLatex;
  final String? knowledgePointsJson;
  final double? confidence;
  final bool isSelected;
  final String? createdQuestionId;
  final int createdAt;
  const DraftItemRow({
    required this.id,
    required this.draftId,
    required this.sortOrder,
    this.promptLatex,
    this.answerLatex,
    this.solutionLatex,
    this.knowledgePointsJson,
    this.confidence,
    required this.isSelected,
    this.createdQuestionId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['draft_id'] = Variable<String>(draftId);
    map['sort_order'] = Variable<int>(sortOrder);
    if (!nullToAbsent || promptLatex != null) {
      map['prompt_latex'] = Variable<String>(promptLatex);
    }
    if (!nullToAbsent || answerLatex != null) {
      map['answer_latex'] = Variable<String>(answerLatex);
    }
    if (!nullToAbsent || solutionLatex != null) {
      map['solution_latex'] = Variable<String>(solutionLatex);
    }
    if (!nullToAbsent || knowledgePointsJson != null) {
      map['knowledge_points_json'] = Variable<String>(knowledgePointsJson);
    }
    if (!nullToAbsent || confidence != null) {
      map['confidence'] = Variable<double>(confidence);
    }
    map['is_selected'] = Variable<bool>(isSelected);
    if (!nullToAbsent || createdQuestionId != null) {
      map['created_question_id'] = Variable<String>(createdQuestionId);
    }
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  DraftItemsCompanion toCompanion(bool nullToAbsent) {
    return DraftItemsCompanion(
      id: Value(id),
      draftId: Value(draftId),
      sortOrder: Value(sortOrder),
      promptLatex: promptLatex == null && nullToAbsent
          ? const Value.absent()
          : Value(promptLatex),
      answerLatex: answerLatex == null && nullToAbsent
          ? const Value.absent()
          : Value(answerLatex),
      solutionLatex: solutionLatex == null && nullToAbsent
          ? const Value.absent()
          : Value(solutionLatex),
      knowledgePointsJson: knowledgePointsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(knowledgePointsJson),
      confidence: confidence == null && nullToAbsent
          ? const Value.absent()
          : Value(confidence),
      isSelected: Value(isSelected),
      createdQuestionId: createdQuestionId == null && nullToAbsent
          ? const Value.absent()
          : Value(createdQuestionId),
      createdAt: Value(createdAt),
    );
  }

  factory DraftItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DraftItemRow(
      id: serializer.fromJson<String>(json['id']),
      draftId: serializer.fromJson<String>(json['draftId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      promptLatex: serializer.fromJson<String?>(json['promptLatex']),
      answerLatex: serializer.fromJson<String?>(json['answerLatex']),
      solutionLatex: serializer.fromJson<String?>(json['solutionLatex']),
      knowledgePointsJson: serializer.fromJson<String?>(
        json['knowledgePointsJson'],
      ),
      confidence: serializer.fromJson<double?>(json['confidence']),
      isSelected: serializer.fromJson<bool>(json['isSelected']),
      createdQuestionId: serializer.fromJson<String?>(
        json['createdQuestionId'],
      ),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'draftId': serializer.toJson<String>(draftId),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'promptLatex': serializer.toJson<String?>(promptLatex),
      'answerLatex': serializer.toJson<String?>(answerLatex),
      'solutionLatex': serializer.toJson<String?>(solutionLatex),
      'knowledgePointsJson': serializer.toJson<String?>(knowledgePointsJson),
      'confidence': serializer.toJson<double?>(confidence),
      'isSelected': serializer.toJson<bool>(isSelected),
      'createdQuestionId': serializer.toJson<String?>(createdQuestionId),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  DraftItemRow copyWith({
    String? id,
    String? draftId,
    int? sortOrder,
    Value<String?> promptLatex = const Value.absent(),
    Value<String?> answerLatex = const Value.absent(),
    Value<String?> solutionLatex = const Value.absent(),
    Value<String?> knowledgePointsJson = const Value.absent(),
    Value<double?> confidence = const Value.absent(),
    bool? isSelected,
    Value<String?> createdQuestionId = const Value.absent(),
    int? createdAt,
  }) => DraftItemRow(
    id: id ?? this.id,
    draftId: draftId ?? this.draftId,
    sortOrder: sortOrder ?? this.sortOrder,
    promptLatex: promptLatex.present ? promptLatex.value : this.promptLatex,
    answerLatex: answerLatex.present ? answerLatex.value : this.answerLatex,
    solutionLatex: solutionLatex.present
        ? solutionLatex.value
        : this.solutionLatex,
    knowledgePointsJson: knowledgePointsJson.present
        ? knowledgePointsJson.value
        : this.knowledgePointsJson,
    confidence: confidence.present ? confidence.value : this.confidence,
    isSelected: isSelected ?? this.isSelected,
    createdQuestionId: createdQuestionId.present
        ? createdQuestionId.value
        : this.createdQuestionId,
    createdAt: createdAt ?? this.createdAt,
  );
  DraftItemRow copyWithCompanion(DraftItemsCompanion data) {
    return DraftItemRow(
      id: data.id.present ? data.id.value : this.id,
      draftId: data.draftId.present ? data.draftId.value : this.draftId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      promptLatex: data.promptLatex.present
          ? data.promptLatex.value
          : this.promptLatex,
      answerLatex: data.answerLatex.present
          ? data.answerLatex.value
          : this.answerLatex,
      solutionLatex: data.solutionLatex.present
          ? data.solutionLatex.value
          : this.solutionLatex,
      knowledgePointsJson: data.knowledgePointsJson.present
          ? data.knowledgePointsJson.value
          : this.knowledgePointsJson,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      isSelected: data.isSelected.present
          ? data.isSelected.value
          : this.isSelected,
      createdQuestionId: data.createdQuestionId.present
          ? data.createdQuestionId.value
          : this.createdQuestionId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DraftItemRow(')
          ..write('id: $id, ')
          ..write('draftId: $draftId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('promptLatex: $promptLatex, ')
          ..write('answerLatex: $answerLatex, ')
          ..write('solutionLatex: $solutionLatex, ')
          ..write('knowledgePointsJson: $knowledgePointsJson, ')
          ..write('confidence: $confidence, ')
          ..write('isSelected: $isSelected, ')
          ..write('createdQuestionId: $createdQuestionId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    draftId,
    sortOrder,
    promptLatex,
    answerLatex,
    solutionLatex,
    knowledgePointsJson,
    confidence,
    isSelected,
    createdQuestionId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DraftItemRow &&
          other.id == this.id &&
          other.draftId == this.draftId &&
          other.sortOrder == this.sortOrder &&
          other.promptLatex == this.promptLatex &&
          other.answerLatex == this.answerLatex &&
          other.solutionLatex == this.solutionLatex &&
          other.knowledgePointsJson == this.knowledgePointsJson &&
          other.confidence == this.confidence &&
          other.isSelected == this.isSelected &&
          other.createdQuestionId == this.createdQuestionId &&
          other.createdAt == this.createdAt);
}

class DraftItemsCompanion extends UpdateCompanion<DraftItemRow> {
  final Value<String> id;
  final Value<String> draftId;
  final Value<int> sortOrder;
  final Value<String?> promptLatex;
  final Value<String?> answerLatex;
  final Value<String?> solutionLatex;
  final Value<String?> knowledgePointsJson;
  final Value<double?> confidence;
  final Value<bool> isSelected;
  final Value<String?> createdQuestionId;
  final Value<int> createdAt;
  final Value<int> rowid;
  const DraftItemsCompanion({
    this.id = const Value.absent(),
    this.draftId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.promptLatex = const Value.absent(),
    this.answerLatex = const Value.absent(),
    this.solutionLatex = const Value.absent(),
    this.knowledgePointsJson = const Value.absent(),
    this.confidence = const Value.absent(),
    this.isSelected = const Value.absent(),
    this.createdQuestionId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DraftItemsCompanion.insert({
    required String id,
    required String draftId,
    this.sortOrder = const Value.absent(),
    this.promptLatex = const Value.absent(),
    this.answerLatex = const Value.absent(),
    this.solutionLatex = const Value.absent(),
    this.knowledgePointsJson = const Value.absent(),
    this.confidence = const Value.absent(),
    this.isSelected = const Value.absent(),
    this.createdQuestionId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       draftId = Value(draftId);
  static Insertable<DraftItemRow> custom({
    Expression<String>? id,
    Expression<String>? draftId,
    Expression<int>? sortOrder,
    Expression<String>? promptLatex,
    Expression<String>? answerLatex,
    Expression<String>? solutionLatex,
    Expression<String>? knowledgePointsJson,
    Expression<double>? confidence,
    Expression<bool>? isSelected,
    Expression<String>? createdQuestionId,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (draftId != null) 'draft_id': draftId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (promptLatex != null) 'prompt_latex': promptLatex,
      if (answerLatex != null) 'answer_latex': answerLatex,
      if (solutionLatex != null) 'solution_latex': solutionLatex,
      if (knowledgePointsJson != null)
        'knowledge_points_json': knowledgePointsJson,
      if (confidence != null) 'confidence': confidence,
      if (isSelected != null) 'is_selected': isSelected,
      if (createdQuestionId != null) 'created_question_id': createdQuestionId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DraftItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? draftId,
    Value<int>? sortOrder,
    Value<String?>? promptLatex,
    Value<String?>? answerLatex,
    Value<String?>? solutionLatex,
    Value<String?>? knowledgePointsJson,
    Value<double?>? confidence,
    Value<bool>? isSelected,
    Value<String?>? createdQuestionId,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return DraftItemsCompanion(
      id: id ?? this.id,
      draftId: draftId ?? this.draftId,
      sortOrder: sortOrder ?? this.sortOrder,
      promptLatex: promptLatex ?? this.promptLatex,
      answerLatex: answerLatex ?? this.answerLatex,
      solutionLatex: solutionLatex ?? this.solutionLatex,
      knowledgePointsJson: knowledgePointsJson ?? this.knowledgePointsJson,
      confidence: confidence ?? this.confidence,
      isSelected: isSelected ?? this.isSelected,
      createdQuestionId: createdQuestionId ?? this.createdQuestionId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (draftId.present) {
      map['draft_id'] = Variable<String>(draftId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (promptLatex.present) {
      map['prompt_latex'] = Variable<String>(promptLatex.value);
    }
    if (answerLatex.present) {
      map['answer_latex'] = Variable<String>(answerLatex.value);
    }
    if (solutionLatex.present) {
      map['solution_latex'] = Variable<String>(solutionLatex.value);
    }
    if (knowledgePointsJson.present) {
      map['knowledge_points_json'] = Variable<String>(
        knowledgePointsJson.value,
      );
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (isSelected.present) {
      map['is_selected'] = Variable<bool>(isSelected.value);
    }
    if (createdQuestionId.present) {
      map['created_question_id'] = Variable<String>(createdQuestionId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DraftItemsCompanion(')
          ..write('id: $id, ')
          ..write('draftId: $draftId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('promptLatex: $promptLatex, ')
          ..write('answerLatex: $answerLatex, ')
          ..write('solutionLatex: $solutionLatex, ')
          ..write('knowledgePointsJson: $knowledgePointsJson, ')
          ..write('confidence: $confidence, ')
          ..write('isSelected: $isSelected, ')
          ..write('createdQuestionId: $createdQuestionId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DraftItemImagesTable extends DraftItemImages
    with TableInfo<$DraftItemImagesTable, DraftItemImageRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DraftItemImagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _draftItemIdMeta = const VerificationMeta(
    'draftItemId',
  );
  @override
  late final GeneratedColumn<String> draftItemId = GeneratedColumn<String>(
    'draft_item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES draft_items (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _sha256Meta = const VerificationMeta('sha256');
  @override
  late final GeneratedColumn<String> sha256 = GeneratedColumn<String>(
    'sha256',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES image_assets (sha256) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    draftItemId,
    sha256,
    sortOrder,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'draft_item_images';
  @override
  VerificationContext validateIntegrity(
    Insertable<DraftItemImageRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('draft_item_id')) {
      context.handle(
        _draftItemIdMeta,
        draftItemId.isAcceptableOrUnknown(
          data['draft_item_id']!,
          _draftItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_draftItemIdMeta);
    }
    if (data.containsKey('sha256')) {
      context.handle(
        _sha256Meta,
        sha256.isAcceptableOrUnknown(data['sha256']!, _sha256Meta),
      );
    } else if (isInserting) {
      context.missing(_sha256Meta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {draftItemId, sha256};
  @override
  DraftItemImageRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DraftItemImageRow(
      draftItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}draft_item_id'],
      )!,
      sha256: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sha256'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $DraftItemImagesTable createAlias(String alias) {
    return $DraftItemImagesTable(attachedDatabase, alias);
  }
}

class DraftItemImageRow extends DataClass
    implements Insertable<DraftItemImageRow> {
  final String draftItemId;
  final String sha256;
  final int sortOrder;
  final int createdAt;
  const DraftItemImageRow({
    required this.draftItemId,
    required this.sha256,
    required this.sortOrder,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['draft_item_id'] = Variable<String>(draftItemId);
    map['sha256'] = Variable<String>(sha256);
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  DraftItemImagesCompanion toCompanion(bool nullToAbsent) {
    return DraftItemImagesCompanion(
      draftItemId: Value(draftItemId),
      sha256: Value(sha256),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
    );
  }

  factory DraftItemImageRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DraftItemImageRow(
      draftItemId: serializer.fromJson<String>(json['draftItemId']),
      sha256: serializer.fromJson<String>(json['sha256']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'draftItemId': serializer.toJson<String>(draftItemId),
      'sha256': serializer.toJson<String>(sha256),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  DraftItemImageRow copyWith({
    String? draftItemId,
    String? sha256,
    int? sortOrder,
    int? createdAt,
  }) => DraftItemImageRow(
    draftItemId: draftItemId ?? this.draftItemId,
    sha256: sha256 ?? this.sha256,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
  );
  DraftItemImageRow copyWithCompanion(DraftItemImagesCompanion data) {
    return DraftItemImageRow(
      draftItemId: data.draftItemId.present
          ? data.draftItemId.value
          : this.draftItemId,
      sha256: data.sha256.present ? data.sha256.value : this.sha256,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DraftItemImageRow(')
          ..write('draftItemId: $draftItemId, ')
          ..write('sha256: $sha256, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(draftItemId, sha256, sortOrder, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DraftItemImageRow &&
          other.draftItemId == this.draftItemId &&
          other.sha256 == this.sha256 &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt);
}

class DraftItemImagesCompanion extends UpdateCompanion<DraftItemImageRow> {
  final Value<String> draftItemId;
  final Value<String> sha256;
  final Value<int> sortOrder;
  final Value<int> createdAt;
  final Value<int> rowid;
  const DraftItemImagesCompanion({
    this.draftItemId = const Value.absent(),
    this.sha256 = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DraftItemImagesCompanion.insert({
    required String draftItemId,
    required String sha256,
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : draftItemId = Value(draftItemId),
       sha256 = Value(sha256);
  static Insertable<DraftItemImageRow> custom({
    Expression<String>? draftItemId,
    Expression<String>? sha256,
    Expression<int>? sortOrder,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (draftItemId != null) 'draft_item_id': draftItemId,
      if (sha256 != null) 'sha256': sha256,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DraftItemImagesCompanion copyWith({
    Value<String>? draftItemId,
    Value<String>? sha256,
    Value<int>? sortOrder,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return DraftItemImagesCompanion(
      draftItemId: draftItemId ?? this.draftItemId,
      sha256: sha256 ?? this.sha256,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (draftItemId.present) {
      map['draft_item_id'] = Variable<String>(draftItemId.value);
    }
    if (sha256.present) {
      map['sha256'] = Variable<String>(sha256.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DraftItemImagesCompanion(')
          ..write('draftItemId: $draftItemId, ')
          ..write('sha256: $sha256, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MasterySnapshotsTable extends MasterySnapshots
    with TableInfo<$MasterySnapshotsTable, MasterySnapshotRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MasterySnapshotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nodeIdMeta = const VerificationMeta('nodeId');
  @override
  late final GeneratedColumn<String> nodeId = GeneratedColumn<String>(
    'node_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES knowledge_nodes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<double> score = GeneratedColumn<double>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _uncertaintyMeta = const VerificationMeta(
    'uncertainty',
  );
  @override
  late final GeneratedColumn<double> uncertainty = GeneratedColumn<double>(
    'uncertainty',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _evidenceCountMeta = const VerificationMeta(
    'evidenceCount',
  );
  @override
  late final GeneratedColumn<int> evidenceCount = GeneratedColumn<int>(
    'evidence_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _computedAtMeta = const VerificationMeta(
    'computedAt',
  );
  @override
  late final GeneratedColumn<int> computedAt = GeneratedColumn<int>(
    'computed_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _watermarkLogIdMeta = const VerificationMeta(
    'watermarkLogId',
  );
  @override
  late final GeneratedColumn<String> watermarkLogId = GeneratedColumn<String>(
    'watermark_log_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _modelVersionMeta = const VerificationMeta(
    'modelVersion',
  );
  @override
  late final GeneratedColumn<String> modelVersion = GeneratedColumn<String>(
    'model_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('m1'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    nodeId,
    score,
    uncertainty,
    evidenceCount,
    computedAt,
    watermarkLogId,
    modelVersion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mastery_snapshots';
  @override
  VerificationContext validateIntegrity(
    Insertable<MasterySnapshotRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('node_id')) {
      context.handle(
        _nodeIdMeta,
        nodeId.isAcceptableOrUnknown(data['node_id']!, _nodeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_nodeIdMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('uncertainty')) {
      context.handle(
        _uncertaintyMeta,
        uncertainty.isAcceptableOrUnknown(
          data['uncertainty']!,
          _uncertaintyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_uncertaintyMeta);
    }
    if (data.containsKey('evidence_count')) {
      context.handle(
        _evidenceCountMeta,
        evidenceCount.isAcceptableOrUnknown(
          data['evidence_count']!,
          _evidenceCountMeta,
        ),
      );
    }
    if (data.containsKey('computed_at')) {
      context.handle(
        _computedAtMeta,
        computedAt.isAcceptableOrUnknown(data['computed_at']!, _computedAtMeta),
      );
    }
    if (data.containsKey('watermark_log_id')) {
      context.handle(
        _watermarkLogIdMeta,
        watermarkLogId.isAcceptableOrUnknown(
          data['watermark_log_id']!,
          _watermarkLogIdMeta,
        ),
      );
    }
    if (data.containsKey('model_version')) {
      context.handle(
        _modelVersionMeta,
        modelVersion.isAcceptableOrUnknown(
          data['model_version']!,
          _modelVersionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {nodeId};
  @override
  MasterySnapshotRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MasterySnapshotRow(
      nodeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}node_id'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}score'],
      )!,
      uncertainty: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}uncertainty'],
      )!,
      evidenceCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}evidence_count'],
      )!,
      computedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}computed_at'],
      )!,
      watermarkLogId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}watermark_log_id'],
      ),
      modelVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model_version'],
      )!,
    );
  }

  @override
  $MasterySnapshotsTable createAlias(String alias) {
    return $MasterySnapshotsTable(attachedDatabase, alias);
  }
}

class MasterySnapshotRow extends DataClass
    implements Insertable<MasterySnapshotRow> {
  final String nodeId;
  final double score;
  final double uncertainty;
  final int evidenceCount;
  final int computedAt;
  final String? watermarkLogId;
  final String modelVersion;
  const MasterySnapshotRow({
    required this.nodeId,
    required this.score,
    required this.uncertainty,
    required this.evidenceCount,
    required this.computedAt,
    this.watermarkLogId,
    required this.modelVersion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['node_id'] = Variable<String>(nodeId);
    map['score'] = Variable<double>(score);
    map['uncertainty'] = Variable<double>(uncertainty);
    map['evidence_count'] = Variable<int>(evidenceCount);
    map['computed_at'] = Variable<int>(computedAt);
    if (!nullToAbsent || watermarkLogId != null) {
      map['watermark_log_id'] = Variable<String>(watermarkLogId);
    }
    map['model_version'] = Variable<String>(modelVersion);
    return map;
  }

  MasterySnapshotsCompanion toCompanion(bool nullToAbsent) {
    return MasterySnapshotsCompanion(
      nodeId: Value(nodeId),
      score: Value(score),
      uncertainty: Value(uncertainty),
      evidenceCount: Value(evidenceCount),
      computedAt: Value(computedAt),
      watermarkLogId: watermarkLogId == null && nullToAbsent
          ? const Value.absent()
          : Value(watermarkLogId),
      modelVersion: Value(modelVersion),
    );
  }

  factory MasterySnapshotRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MasterySnapshotRow(
      nodeId: serializer.fromJson<String>(json['nodeId']),
      score: serializer.fromJson<double>(json['score']),
      uncertainty: serializer.fromJson<double>(json['uncertainty']),
      evidenceCount: serializer.fromJson<int>(json['evidenceCount']),
      computedAt: serializer.fromJson<int>(json['computedAt']),
      watermarkLogId: serializer.fromJson<String?>(json['watermarkLogId']),
      modelVersion: serializer.fromJson<String>(json['modelVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'nodeId': serializer.toJson<String>(nodeId),
      'score': serializer.toJson<double>(score),
      'uncertainty': serializer.toJson<double>(uncertainty),
      'evidenceCount': serializer.toJson<int>(evidenceCount),
      'computedAt': serializer.toJson<int>(computedAt),
      'watermarkLogId': serializer.toJson<String?>(watermarkLogId),
      'modelVersion': serializer.toJson<String>(modelVersion),
    };
  }

  MasterySnapshotRow copyWith({
    String? nodeId,
    double? score,
    double? uncertainty,
    int? evidenceCount,
    int? computedAt,
    Value<String?> watermarkLogId = const Value.absent(),
    String? modelVersion,
  }) => MasterySnapshotRow(
    nodeId: nodeId ?? this.nodeId,
    score: score ?? this.score,
    uncertainty: uncertainty ?? this.uncertainty,
    evidenceCount: evidenceCount ?? this.evidenceCount,
    computedAt: computedAt ?? this.computedAt,
    watermarkLogId: watermarkLogId.present
        ? watermarkLogId.value
        : this.watermarkLogId,
    modelVersion: modelVersion ?? this.modelVersion,
  );
  MasterySnapshotRow copyWithCompanion(MasterySnapshotsCompanion data) {
    return MasterySnapshotRow(
      nodeId: data.nodeId.present ? data.nodeId.value : this.nodeId,
      score: data.score.present ? data.score.value : this.score,
      uncertainty: data.uncertainty.present
          ? data.uncertainty.value
          : this.uncertainty,
      evidenceCount: data.evidenceCount.present
          ? data.evidenceCount.value
          : this.evidenceCount,
      computedAt: data.computedAt.present
          ? data.computedAt.value
          : this.computedAt,
      watermarkLogId: data.watermarkLogId.present
          ? data.watermarkLogId.value
          : this.watermarkLogId,
      modelVersion: data.modelVersion.present
          ? data.modelVersion.value
          : this.modelVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MasterySnapshotRow(')
          ..write('nodeId: $nodeId, ')
          ..write('score: $score, ')
          ..write('uncertainty: $uncertainty, ')
          ..write('evidenceCount: $evidenceCount, ')
          ..write('computedAt: $computedAt, ')
          ..write('watermarkLogId: $watermarkLogId, ')
          ..write('modelVersion: $modelVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    nodeId,
    score,
    uncertainty,
    evidenceCount,
    computedAt,
    watermarkLogId,
    modelVersion,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MasterySnapshotRow &&
          other.nodeId == this.nodeId &&
          other.score == this.score &&
          other.uncertainty == this.uncertainty &&
          other.evidenceCount == this.evidenceCount &&
          other.computedAt == this.computedAt &&
          other.watermarkLogId == this.watermarkLogId &&
          other.modelVersion == this.modelVersion);
}

class MasterySnapshotsCompanion extends UpdateCompanion<MasterySnapshotRow> {
  final Value<String> nodeId;
  final Value<double> score;
  final Value<double> uncertainty;
  final Value<int> evidenceCount;
  final Value<int> computedAt;
  final Value<String?> watermarkLogId;
  final Value<String> modelVersion;
  final Value<int> rowid;
  const MasterySnapshotsCompanion({
    this.nodeId = const Value.absent(),
    this.score = const Value.absent(),
    this.uncertainty = const Value.absent(),
    this.evidenceCount = const Value.absent(),
    this.computedAt = const Value.absent(),
    this.watermarkLogId = const Value.absent(),
    this.modelVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MasterySnapshotsCompanion.insert({
    required String nodeId,
    required double score,
    required double uncertainty,
    this.evidenceCount = const Value.absent(),
    this.computedAt = const Value.absent(),
    this.watermarkLogId = const Value.absent(),
    this.modelVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : nodeId = Value(nodeId),
       score = Value(score),
       uncertainty = Value(uncertainty);
  static Insertable<MasterySnapshotRow> custom({
    Expression<String>? nodeId,
    Expression<double>? score,
    Expression<double>? uncertainty,
    Expression<int>? evidenceCount,
    Expression<int>? computedAt,
    Expression<String>? watermarkLogId,
    Expression<String>? modelVersion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (nodeId != null) 'node_id': nodeId,
      if (score != null) 'score': score,
      if (uncertainty != null) 'uncertainty': uncertainty,
      if (evidenceCount != null) 'evidence_count': evidenceCount,
      if (computedAt != null) 'computed_at': computedAt,
      if (watermarkLogId != null) 'watermark_log_id': watermarkLogId,
      if (modelVersion != null) 'model_version': modelVersion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MasterySnapshotsCompanion copyWith({
    Value<String>? nodeId,
    Value<double>? score,
    Value<double>? uncertainty,
    Value<int>? evidenceCount,
    Value<int>? computedAt,
    Value<String?>? watermarkLogId,
    Value<String>? modelVersion,
    Value<int>? rowid,
  }) {
    return MasterySnapshotsCompanion(
      nodeId: nodeId ?? this.nodeId,
      score: score ?? this.score,
      uncertainty: uncertainty ?? this.uncertainty,
      evidenceCount: evidenceCount ?? this.evidenceCount,
      computedAt: computedAt ?? this.computedAt,
      watermarkLogId: watermarkLogId ?? this.watermarkLogId,
      modelVersion: modelVersion ?? this.modelVersion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (nodeId.present) {
      map['node_id'] = Variable<String>(nodeId.value);
    }
    if (score.present) {
      map['score'] = Variable<double>(score.value);
    }
    if (uncertainty.present) {
      map['uncertainty'] = Variable<double>(uncertainty.value);
    }
    if (evidenceCount.present) {
      map['evidence_count'] = Variable<int>(evidenceCount.value);
    }
    if (computedAt.present) {
      map['computed_at'] = Variable<int>(computedAt.value);
    }
    if (watermarkLogId.present) {
      map['watermark_log_id'] = Variable<String>(watermarkLogId.value);
    }
    if (modelVersion.present) {
      map['model_version'] = Variable<String>(modelVersion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MasterySnapshotsCompanion(')
          ..write('nodeId: $nodeId, ')
          ..write('score: $score, ')
          ..write('uncertainty: $uncertainty, ')
          ..write('evidenceCount: $evidenceCount, ')
          ..write('computedAt: $computedAt, ')
          ..write('watermarkLogId: $watermarkLogId, ')
          ..write('modelVersion: $modelVersion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuestionMasteryTable extends QuestionMastery
    with TableInfo<$QuestionMasteryTable, QuestionMasteryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionMasteryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _questionIdMeta = const VerificationMeta(
    'questionId',
  );
  @override
  late final GeneratedColumn<String> questionId = GeneratedColumn<String>(
    'question_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES questions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<double> score = GeneratedColumn<double>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _uncertaintyMeta = const VerificationMeta(
    'uncertainty',
  );
  @override
  late final GeneratedColumn<double> uncertainty = GeneratedColumn<double>(
    'uncertainty',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _computedAtMeta = const VerificationMeta(
    'computedAt',
  );
  @override
  late final GeneratedColumn<int> computedAt = GeneratedColumn<int>(
    'computed_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _watermarkLogIdMeta = const VerificationMeta(
    'watermarkLogId',
  );
  @override
  late final GeneratedColumn<String> watermarkLogId = GeneratedColumn<String>(
    'watermark_log_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    questionId,
    score,
    uncertainty,
    computedAt,
    watermarkLogId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'question_mastery';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuestionMasteryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('question_id')) {
      context.handle(
        _questionIdMeta,
        questionId.isAcceptableOrUnknown(data['question_id']!, _questionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('uncertainty')) {
      context.handle(
        _uncertaintyMeta,
        uncertainty.isAcceptableOrUnknown(
          data['uncertainty']!,
          _uncertaintyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_uncertaintyMeta);
    }
    if (data.containsKey('computed_at')) {
      context.handle(
        _computedAtMeta,
        computedAt.isAcceptableOrUnknown(data['computed_at']!, _computedAtMeta),
      );
    }
    if (data.containsKey('watermark_log_id')) {
      context.handle(
        _watermarkLogIdMeta,
        watermarkLogId.isAcceptableOrUnknown(
          data['watermark_log_id']!,
          _watermarkLogIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {questionId};
  @override
  QuestionMasteryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionMasteryRow(
      questionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_id'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}score'],
      )!,
      uncertainty: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}uncertainty'],
      )!,
      computedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}computed_at'],
      )!,
      watermarkLogId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}watermark_log_id'],
      ),
    );
  }

  @override
  $QuestionMasteryTable createAlias(String alias) {
    return $QuestionMasteryTable(attachedDatabase, alias);
  }
}

class QuestionMasteryRow extends DataClass
    implements Insertable<QuestionMasteryRow> {
  final String questionId;
  final double score;
  final double uncertainty;
  final int computedAt;
  final String? watermarkLogId;
  const QuestionMasteryRow({
    required this.questionId,
    required this.score,
    required this.uncertainty,
    required this.computedAt,
    this.watermarkLogId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['question_id'] = Variable<String>(questionId);
    map['score'] = Variable<double>(score);
    map['uncertainty'] = Variable<double>(uncertainty);
    map['computed_at'] = Variable<int>(computedAt);
    if (!nullToAbsent || watermarkLogId != null) {
      map['watermark_log_id'] = Variable<String>(watermarkLogId);
    }
    return map;
  }

  QuestionMasteryCompanion toCompanion(bool nullToAbsent) {
    return QuestionMasteryCompanion(
      questionId: Value(questionId),
      score: Value(score),
      uncertainty: Value(uncertainty),
      computedAt: Value(computedAt),
      watermarkLogId: watermarkLogId == null && nullToAbsent
          ? const Value.absent()
          : Value(watermarkLogId),
    );
  }

  factory QuestionMasteryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionMasteryRow(
      questionId: serializer.fromJson<String>(json['questionId']),
      score: serializer.fromJson<double>(json['score']),
      uncertainty: serializer.fromJson<double>(json['uncertainty']),
      computedAt: serializer.fromJson<int>(json['computedAt']),
      watermarkLogId: serializer.fromJson<String?>(json['watermarkLogId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'questionId': serializer.toJson<String>(questionId),
      'score': serializer.toJson<double>(score),
      'uncertainty': serializer.toJson<double>(uncertainty),
      'computedAt': serializer.toJson<int>(computedAt),
      'watermarkLogId': serializer.toJson<String?>(watermarkLogId),
    };
  }

  QuestionMasteryRow copyWith({
    String? questionId,
    double? score,
    double? uncertainty,
    int? computedAt,
    Value<String?> watermarkLogId = const Value.absent(),
  }) => QuestionMasteryRow(
    questionId: questionId ?? this.questionId,
    score: score ?? this.score,
    uncertainty: uncertainty ?? this.uncertainty,
    computedAt: computedAt ?? this.computedAt,
    watermarkLogId: watermarkLogId.present
        ? watermarkLogId.value
        : this.watermarkLogId,
  );
  QuestionMasteryRow copyWithCompanion(QuestionMasteryCompanion data) {
    return QuestionMasteryRow(
      questionId: data.questionId.present
          ? data.questionId.value
          : this.questionId,
      score: data.score.present ? data.score.value : this.score,
      uncertainty: data.uncertainty.present
          ? data.uncertainty.value
          : this.uncertainty,
      computedAt: data.computedAt.present
          ? data.computedAt.value
          : this.computedAt,
      watermarkLogId: data.watermarkLogId.present
          ? data.watermarkLogId.value
          : this.watermarkLogId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuestionMasteryRow(')
          ..write('questionId: $questionId, ')
          ..write('score: $score, ')
          ..write('uncertainty: $uncertainty, ')
          ..write('computedAt: $computedAt, ')
          ..write('watermarkLogId: $watermarkLogId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(questionId, score, uncertainty, computedAt, watermarkLogId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionMasteryRow &&
          other.questionId == this.questionId &&
          other.score == this.score &&
          other.uncertainty == this.uncertainty &&
          other.computedAt == this.computedAt &&
          other.watermarkLogId == this.watermarkLogId);
}

class QuestionMasteryCompanion extends UpdateCompanion<QuestionMasteryRow> {
  final Value<String> questionId;
  final Value<double> score;
  final Value<double> uncertainty;
  final Value<int> computedAt;
  final Value<String?> watermarkLogId;
  final Value<int> rowid;
  const QuestionMasteryCompanion({
    this.questionId = const Value.absent(),
    this.score = const Value.absent(),
    this.uncertainty = const Value.absent(),
    this.computedAt = const Value.absent(),
    this.watermarkLogId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionMasteryCompanion.insert({
    required String questionId,
    required double score,
    required double uncertainty,
    this.computedAt = const Value.absent(),
    this.watermarkLogId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : questionId = Value(questionId),
       score = Value(score),
       uncertainty = Value(uncertainty);
  static Insertable<QuestionMasteryRow> custom({
    Expression<String>? questionId,
    Expression<double>? score,
    Expression<double>? uncertainty,
    Expression<int>? computedAt,
    Expression<String>? watermarkLogId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (questionId != null) 'question_id': questionId,
      if (score != null) 'score': score,
      if (uncertainty != null) 'uncertainty': uncertainty,
      if (computedAt != null) 'computed_at': computedAt,
      if (watermarkLogId != null) 'watermark_log_id': watermarkLogId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionMasteryCompanion copyWith({
    Value<String>? questionId,
    Value<double>? score,
    Value<double>? uncertainty,
    Value<int>? computedAt,
    Value<String?>? watermarkLogId,
    Value<int>? rowid,
  }) {
    return QuestionMasteryCompanion(
      questionId: questionId ?? this.questionId,
      score: score ?? this.score,
      uncertainty: uncertainty ?? this.uncertainty,
      computedAt: computedAt ?? this.computedAt,
      watermarkLogId: watermarkLogId ?? this.watermarkLogId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (questionId.present) {
      map['question_id'] = Variable<String>(questionId.value);
    }
    if (score.present) {
      map['score'] = Variable<double>(score.value);
    }
    if (uncertainty.present) {
      map['uncertainty'] = Variable<double>(uncertainty.value);
    }
    if (computedAt.present) {
      map['computed_at'] = Variable<int>(computedAt.value);
    }
    if (watermarkLogId.present) {
      map['watermark_log_id'] = Variable<String>(watermarkLogId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionMasteryCompanion(')
          ..write('questionId: $questionId, ')
          ..write('score: $score, ')
          ..write('uncertainty: $uncertainty, ')
          ..write('computedAt: $computedAt, ')
          ..write('watermarkLogId: $watermarkLogId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AppMetaTable appMeta = $AppMetaTable(this);
  late final $SettingsTableTable settingsTable = $SettingsTableTable(this);
  late final $KnowledgeNodesTable knowledgeNodes = $KnowledgeNodesTable(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $QuestionsTable questions = $QuestionsTable(this);
  late final $QuestionKnowledgeTable questionKnowledge =
      $QuestionKnowledgeTable(this);
  late final $QuestionTagsTable questionTags = $QuestionTagsTable(this);
  late final $ImageAssetsTable imageAssets = $ImageAssetsTable(this);
  late final $QuestionImagesTable questionImages = $QuestionImagesTable(this);
  late final $ReviewCardsTable reviewCards = $ReviewCardsTable(this);
  late final $ReviewLogsTable reviewLogs = $ReviewLogsTable(this);
  late final $DraftsTable drafts = $DraftsTable(this);
  late final $DraftItemsTable draftItems = $DraftItemsTable(this);
  late final $DraftItemImagesTable draftItemImages = $DraftItemImagesTable(
    this,
  );
  late final $MasterySnapshotsTable masterySnapshots = $MasterySnapshotsTable(
    this,
  );
  late final $QuestionMasteryTable questionMastery = $QuestionMasteryTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    appMeta,
    settingsTable,
    knowledgeNodes,
    tags,
    questions,
    questionKnowledge,
    questionTags,
    imageAssets,
    questionImages,
    reviewCards,
    reviewLogs,
    drafts,
    draftItems,
    draftItemImages,
    masterySnapshots,
    questionMastery,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'questions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('question_knowledge', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'questions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('question_tags', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tags',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('question_tags', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'questions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('question_images', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'questions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('review_cards', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'questions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('review_logs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'drafts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('draft_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'draft_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('draft_item_images', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'knowledge_nodes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('mastery_snapshots', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'questions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('question_mastery', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$AppMetaTableCreateCompanionBuilder = AppMetaCompanion Function({
  required String key,
  required String value,
  Value<int> updatedAt,
  Value<int> rowid,
});
typedef $$AppMetaTableUpdateCompanionBuilder = AppMetaCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<int> updatedAt,
  Value<int> rowid,
});

class $$AppMetaTableFilterComposer
    extends Composer<_$AppDatabase, $AppMetaTable> {
  $$AppMetaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppMetaTableOrderingComposer
    extends Composer<_$AppDatabase, $AppMetaTable> {
  $$AppMetaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppMetaTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppMetaTable> {
  $$AppMetaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppMetaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppMetaTable,
          AppMetaRow,
          $$AppMetaTableFilterComposer,
          $$AppMetaTableOrderingComposer,
          $$AppMetaTableAnnotationComposer,
          $$AppMetaTableCreateCompanionBuilder,
          $$AppMetaTableUpdateCompanionBuilder,
          (
            AppMetaRow,
            BaseReferences<_$AppDatabase, $AppMetaTable, AppMetaRow>,
          ),
          AppMetaRow,
          PrefetchHooks Function()
        > {
  $$AppMetaTableTableManager(_$AppDatabase db, $AppMetaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppMetaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppMetaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppMetaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppMetaCompanion(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppMetaCompanion.insert(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppMetaTable, AppMetaRow>(table),
                  BaseReferences<_$AppDatabase, $AppMetaTable, AppMetaRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppMetaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppMetaTable,
      AppMetaRow,
      $$AppMetaTableFilterComposer,
      $$AppMetaTableOrderingComposer,
      $$AppMetaTableAnnotationComposer,
      $$AppMetaTableCreateCompanionBuilder,
      $$AppMetaTableUpdateCompanionBuilder,
      (AppMetaRow, BaseReferences<_$AppDatabase, $AppMetaTable, AppMetaRow>),
      AppMetaRow,
      PrefetchHooks Function()
    >;
typedef $$SettingsTableTableCreateCompanionBuilder =
    SettingsTableCompanion Function({
      required String key,
      Value<String> valueJson,
      Value<int> updatedAt,
      Value<int> rowid,
    });
typedef $$SettingsTableTableUpdateCompanionBuilder =
    SettingsTableCompanion Function({
      Value<String> key,
      Value<String> valueJson,
      Value<int> updatedAt,
      Value<int> rowid,
    });

class $$SettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get valueJson => $composableBuilder(
    column: $table.valueJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get valueJson => $composableBuilder(
    column: $table.valueJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get valueJson =>
      $composableBuilder(column: $table.valueJson, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SettingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTableTable,
          SettingsRow,
          $$SettingsTableTableFilterComposer,
          $$SettingsTableTableOrderingComposer,
          $$SettingsTableTableAnnotationComposer,
          $$SettingsTableTableCreateCompanionBuilder,
          $$SettingsTableTableUpdateCompanionBuilder,
          (
            SettingsRow,
            BaseReferences<_$AppDatabase, $SettingsTableTable, SettingsRow>,
          ),
          SettingsRow,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableTableManager(_$AppDatabase db, $SettingsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> valueJson = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SettingsTableCompanion(
                key: key,
                valueJson: valueJson,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                Value<String> valueJson = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SettingsTableCompanion.insert(
                key: key,
                valueJson: valueJson,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SettingsTableTable, SettingsRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $SettingsTableTable,
                    SettingsRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTableTable,
      SettingsRow,
      $$SettingsTableTableFilterComposer,
      $$SettingsTableTableOrderingComposer,
      $$SettingsTableTableAnnotationComposer,
      $$SettingsTableTableCreateCompanionBuilder,
      $$SettingsTableTableUpdateCompanionBuilder,
      (
        SettingsRow,
        BaseReferences<_$AppDatabase, $SettingsTableTable, SettingsRow>,
      ),
      SettingsRow,
      PrefetchHooks Function()
    >;
typedef $$KnowledgeNodesTableCreateCompanionBuilder =
    KnowledgeNodesCompanion Function({
      required String id,
      Value<String?> parentId,
      required int level,
      required String name,
      Value<int> sortOrder,
      Value<bool> isSystem,
      Value<bool> isActive,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> rowid,
    });
typedef $$KnowledgeNodesTableUpdateCompanionBuilder =
    KnowledgeNodesCompanion Function({
      Value<String> id,
      Value<String?> parentId,
      Value<int> level,
      Value<String> name,
      Value<int> sortOrder,
      Value<bool> isSystem,
      Value<bool> isActive,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> rowid,
    });

final class $$KnowledgeNodesTableReferences
    extends
        BaseReferences<_$AppDatabase, $KnowledgeNodesTable, KnowledgeNodeRow> {
  $$KnowledgeNodesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $KnowledgeNodesTable _parentIdTable(_$AppDatabase db) => db
      .knowledgeNodes
      .createAlias('knowledge_nodes__parent_id__knowledge_nodes__id');

  $$KnowledgeNodesTableProcessedTableManager? get parentId {
    final $_column = $_itemColumn<String>('parent_id');
    if ($_column == null) return null;
    final manager = $$KnowledgeNodesTableTableManager(
      $_db,
      $_db.knowledgeNodes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $QuestionKnowledgeTable,
    List<QuestionKnowledgeRow>
  >
  _questionKnowledgeRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.questionKnowledge,
        aliasName: 'knowledge_nodes__id__question_knowledge__node_id',
      );

  $$QuestionKnowledgeTableProcessedTableManager get questionKnowledgeRefs {
    final manager = $$QuestionKnowledgeTableTableManager(
      $_db,
      $_db.questionKnowledge,
    ).filter((f) => f.nodeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _questionKnowledgeRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MasterySnapshotsTable, List<MasterySnapshotRow>>
  _masterySnapshotsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.masterySnapshots,
    aliasName: 'knowledge_nodes__id__mastery_snapshots__node_id',
  );

  $$MasterySnapshotsTableProcessedTableManager get masterySnapshotsRefs {
    final manager = $$MasterySnapshotsTableTableManager(
      $_db,
      $_db.masterySnapshots,
    ).filter((f) => f.nodeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _masterySnapshotsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$KnowledgeNodesTableFilterComposer
    extends Composer<_$AppDatabase, $KnowledgeNodesTable> {
  $$KnowledgeNodesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$KnowledgeNodesTableFilterComposer get parentId {
    final $$KnowledgeNodesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.knowledgeNodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KnowledgeNodesTableFilterComposer(
            $db: $db,
            $table: $db.knowledgeNodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> questionKnowledgeRefs(
    Expression<bool> Function($$QuestionKnowledgeTableFilterComposer f) f,
  ) {
    final $$QuestionKnowledgeTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questionKnowledge,
      getReferencedColumn: (t) => t.nodeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionKnowledgeTableFilterComposer(
            $db: $db,
            $table: $db.questionKnowledge,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> masterySnapshotsRefs(
    Expression<bool> Function($$MasterySnapshotsTableFilterComposer f) f,
  ) {
    final $$MasterySnapshotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.masterySnapshots,
      getReferencedColumn: (t) => t.nodeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterySnapshotsTableFilterComposer(
            $db: $db,
            $table: $db.masterySnapshots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$KnowledgeNodesTableOrderingComposer
    extends Composer<_$AppDatabase, $KnowledgeNodesTable> {
  $$KnowledgeNodesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$KnowledgeNodesTableOrderingComposer get parentId {
    final $$KnowledgeNodesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.knowledgeNodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KnowledgeNodesTableOrderingComposer(
            $db: $db,
            $table: $db.knowledgeNodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$KnowledgeNodesTableAnnotationComposer
    extends Composer<_$AppDatabase, $KnowledgeNodesTable> {
  $$KnowledgeNodesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isSystem =>
      $composableBuilder(column: $table.isSystem, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$KnowledgeNodesTableAnnotationComposer get parentId {
    final $$KnowledgeNodesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.knowledgeNodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KnowledgeNodesTableAnnotationComposer(
            $db: $db,
            $table: $db.knowledgeNodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> questionKnowledgeRefs<T extends Object>(
    Expression<T> Function($$QuestionKnowledgeTableAnnotationComposer a) f,
  ) {
    final $$QuestionKnowledgeTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.questionKnowledge,
          getReferencedColumn: (t) => t.nodeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$QuestionKnowledgeTableAnnotationComposer(
                $db: $db,
                $table: $db.questionKnowledge,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> masterySnapshotsRefs<T extends Object>(
    Expression<T> Function($$MasterySnapshotsTableAnnotationComposer a) f,
  ) {
    final $$MasterySnapshotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.masterySnapshots,
      getReferencedColumn: (t) => t.nodeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MasterySnapshotsTableAnnotationComposer(
            $db: $db,
            $table: $db.masterySnapshots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$KnowledgeNodesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $KnowledgeNodesTable,
          KnowledgeNodeRow,
          $$KnowledgeNodesTableFilterComposer,
          $$KnowledgeNodesTableOrderingComposer,
          $$KnowledgeNodesTableAnnotationComposer,
          $$KnowledgeNodesTableCreateCompanionBuilder,
          $$KnowledgeNodesTableUpdateCompanionBuilder,
          (KnowledgeNodeRow, $$KnowledgeNodesTableReferences),
          KnowledgeNodeRow,
          PrefetchHooks Function({
            bool parentId,
            bool questionKnowledgeRefs,
            bool masterySnapshotsRefs,
          })
        > {
  $$KnowledgeNodesTableTableManager(
    _$AppDatabase db,
    $KnowledgeNodesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KnowledgeNodesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KnowledgeNodesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KnowledgeNodesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> parentId = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isSystem = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => KnowledgeNodesCompanion(
                id: id,
                parentId: parentId,
                level: level,
                name: name,
                sortOrder: sortOrder,
                isSystem: isSystem,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> parentId = const Value.absent(),
                required int level,
                required String name,
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isSystem = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => KnowledgeNodesCompanion.insert(
                id: id,
                parentId: parentId,
                level: level,
                name: name,
                sortOrder: sortOrder,
                isSystem: isSystem,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$KnowledgeNodesTable, KnowledgeNodeRow>(table),
                  $$KnowledgeNodesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                parentId = false,
                questionKnowledgeRefs = false,
                masterySnapshotsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (questionKnowledgeRefs) db.questionKnowledge,
                    if (masterySnapshotsRefs) db.masterySnapshots,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (parentId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.parentId,
                            referencedTable: $$KnowledgeNodesTableReferences
                                ._parentIdTable(db),
                            referencedColumn: $$KnowledgeNodesTableReferences
                                ._parentIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (questionKnowledgeRefs)
                        await $_getPrefetchedDataByColumns<
                          KnowledgeNodeRow,
                          $KnowledgeNodesTable,
                          QuestionKnowledgeRow,
                          $QuestionKnowledgeTable
                        >(
                          currentTable: table,
                          referencedTable: $$KnowledgeNodesTableReferences
                              ._questionKnowledgeRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$KnowledgeNodesTableReferences(
                                db,
                                table,
                                p0,
                              ).questionKnowledgeRefs,
                          currentColumn: 'id',
                          referencedColumn: 'node_id',
                          typedResults: items,
                        ),
                      if (masterySnapshotsRefs)
                        await $_getPrefetchedDataByColumns<
                          KnowledgeNodeRow,
                          $KnowledgeNodesTable,
                          MasterySnapshotRow,
                          $MasterySnapshotsTable
                        >(
                          currentTable: table,
                          referencedTable: $$KnowledgeNodesTableReferences
                              ._masterySnapshotsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$KnowledgeNodesTableReferences(
                                db,
                                table,
                                p0,
                              ).masterySnapshotsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'node_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$KnowledgeNodesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $KnowledgeNodesTable,
      KnowledgeNodeRow,
      $$KnowledgeNodesTableFilterComposer,
      $$KnowledgeNodesTableOrderingComposer,
      $$KnowledgeNodesTableAnnotationComposer,
      $$KnowledgeNodesTableCreateCompanionBuilder,
      $$KnowledgeNodesTableUpdateCompanionBuilder,
      (KnowledgeNodeRow, $$KnowledgeNodesTableReferences),
      KnowledgeNodeRow,
      PrefetchHooks Function({
        bool parentId,
        bool questionKnowledgeRefs,
        bool masterySnapshotsRefs,
      })
    >;
typedef $$TagsTableCreateCompanionBuilder = TagsCompanion Function({
  required String id,
  required String name,
  Value<int> createdAt,
  Value<int> rowid,
});
typedef $$TagsTableUpdateCompanionBuilder = TagsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<int> createdAt,
  Value<int> rowid,
});

final class $$TagsTableReferences
    extends BaseReferences<_$AppDatabase, $TagsTable, TagRow> {
  $$TagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$QuestionTagsTable, List<QuestionTagRow>>
  _questionTagsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.questionTags,
    aliasName: 'tags__id__question_tags__tag_id',
  );

  $$QuestionTagsTableProcessedTableManager get questionTagsRefs {
    final manager = $$QuestionTagsTableTableManager(
      $_db,
      $_db.questionTags,
    ).filter((f) => f.tagId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_questionTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TagsTableFilterComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> questionTagsRefs(
    Expression<bool> Function($$QuestionTagsTableFilterComposer f) f,
  ) {
    final $$QuestionTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questionTags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionTagsTableFilterComposer(
            $db: $db,
            $table: $db.questionTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TagsTableOrderingComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> questionTagsRefs<T extends Object>(
    Expression<T> Function($$QuestionTagsTableAnnotationComposer a) f,
  ) {
    final $$QuestionTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questionTags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.questionTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TagsTable,
          TagRow,
          $$TagsTableFilterComposer,
          $$TagsTableOrderingComposer,
          $$TagsTableAnnotationComposer,
          $$TagsTableCreateCompanionBuilder,
          $$TagsTableUpdateCompanionBuilder,
          (TagRow, $$TagsTableReferences),
          TagRow,
          PrefetchHooks Function({bool questionTagsRefs})
        > {
  $$TagsTableTableManager(_$AppDatabase db, $TagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TagsCompanion(
                id: id,
                name: name,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TagsCompanion.insert(
                id: id,
                name: name,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TagsTable, TagRow>(table),
                  $$TagsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({questionTagsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (questionTagsRefs) db.questionTags],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (questionTagsRefs)
                    await $_getPrefetchedDataByColumns<
                      TagRow,
                      $TagsTable,
                      QuestionTagRow,
                      $QuestionTagsTable
                    >(
                      currentTable: table,
                      referencedTable: $$TagsTableReferences
                          ._questionTagsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TagsTableReferences(db, table, p0).questionTagsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'tag_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TagsTable,
      TagRow,
      $$TagsTableFilterComposer,
      $$TagsTableOrderingComposer,
      $$TagsTableAnnotationComposer,
      $$TagsTableCreateCompanionBuilder,
      $$TagsTableUpdateCompanionBuilder,
      (TagRow, $$TagsTableReferences),
      TagRow,
      PrefetchHooks Function({bool questionTagsRefs})
    >;
typedef $$QuestionsTableCreateCompanionBuilder = QuestionsCompanion Function({
  required String id,
  required String promptLatex,
  Value<String?> answerLatex,
  Value<String?> solutionLatex,
  Value<String?> hintLatex,
  Value<int?> difficulty,
  Value<String?> sourceText,
  Value<String?> errorReason,
  Value<bool> isStarred,
  Value<int> createdAt,
  Value<int> updatedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});
typedef $$QuestionsTableUpdateCompanionBuilder = QuestionsCompanion Function({
  Value<String> id,
  Value<String> promptLatex,
  Value<String?> answerLatex,
  Value<String?> solutionLatex,
  Value<String?> hintLatex,
  Value<int?> difficulty,
  Value<String?> sourceText,
  Value<String?> errorReason,
  Value<bool> isStarred,
  Value<int> createdAt,
  Value<int> updatedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});

final class $$QuestionsTableReferences
    extends BaseReferences<_$AppDatabase, $QuestionsTable, QuestionRow> {
  $$QuestionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $QuestionKnowledgeTable,
    List<QuestionKnowledgeRow>
  >
  _questionKnowledgeRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.questionKnowledge,
        aliasName: 'questions__id__question_knowledge__question_id',
      );

  $$QuestionKnowledgeTableProcessedTableManager get questionKnowledgeRefs {
    final manager = $$QuestionKnowledgeTableTableManager(
      $_db,
      $_db.questionKnowledge,
    ).filter((f) => f.questionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _questionKnowledgeRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$QuestionTagsTable, List<QuestionTagRow>>
  _questionTagsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.questionTags,
    aliasName: 'questions__id__question_tags__question_id',
  );

  $$QuestionTagsTableProcessedTableManager get questionTagsRefs {
    final manager = $$QuestionTagsTableTableManager(
      $_db,
      $_db.questionTags,
    ).filter((f) => f.questionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_questionTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$QuestionImagesTable, List<QuestionImageRow>>
  _questionImagesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.questionImages,
    aliasName: 'questions__id__question_images__question_id',
  );

  $$QuestionImagesTableProcessedTableManager get questionImagesRefs {
    final manager = $$QuestionImagesTableTableManager(
      $_db,
      $_db.questionImages,
    ).filter((f) => f.questionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_questionImagesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReviewCardsTable, List<ReviewCardRow>>
  _reviewCardsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reviewCards,
    aliasName: 'questions__id__review_cards__question_id',
  );

  $$ReviewCardsTableProcessedTableManager get reviewCardsRefs {
    final manager = $$ReviewCardsTableTableManager(
      $_db,
      $_db.reviewCards,
    ).filter((f) => f.questionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_reviewCardsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReviewLogsTable, List<ReviewLogRow>>
  _reviewLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reviewLogs,
    aliasName: 'questions__id__review_logs__question_id',
  );

  $$ReviewLogsTableProcessedTableManager get reviewLogsRefs {
    final manager = $$ReviewLogsTableTableManager(
      $_db,
      $_db.reviewLogs,
    ).filter((f) => f.questionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_reviewLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$QuestionMasteryTable, List<QuestionMasteryRow>>
  _questionMasteryRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.questionMastery,
    aliasName: 'questions__id__question_mastery__question_id',
  );

  $$QuestionMasteryTableProcessedTableManager get questionMasteryRefs {
    final manager = $$QuestionMasteryTableTableManager(
      $_db,
      $_db.questionMastery,
    ).filter((f) => f.questionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _questionMasteryRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$QuestionsTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionsTable> {
  $$QuestionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get promptLatex => $composableBuilder(
    column: $table.promptLatex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get answerLatex => $composableBuilder(
    column: $table.answerLatex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get solutionLatex => $composableBuilder(
    column: $table.solutionLatex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hintLatex => $composableBuilder(
    column: $table.hintLatex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceText => $composableBuilder(
    column: $table.sourceText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorReason => $composableBuilder(
    column: $table.errorReason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isStarred => $composableBuilder(
    column: $table.isStarred,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> questionKnowledgeRefs(
    Expression<bool> Function($$QuestionKnowledgeTableFilterComposer f) f,
  ) {
    final $$QuestionKnowledgeTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questionKnowledge,
      getReferencedColumn: (t) => t.questionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionKnowledgeTableFilterComposer(
            $db: $db,
            $table: $db.questionKnowledge,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> questionTagsRefs(
    Expression<bool> Function($$QuestionTagsTableFilterComposer f) f,
  ) {
    final $$QuestionTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questionTags,
      getReferencedColumn: (t) => t.questionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionTagsTableFilterComposer(
            $db: $db,
            $table: $db.questionTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> questionImagesRefs(
    Expression<bool> Function($$QuestionImagesTableFilterComposer f) f,
  ) {
    final $$QuestionImagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questionImages,
      getReferencedColumn: (t) => t.questionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionImagesTableFilterComposer(
            $db: $db,
            $table: $db.questionImages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> reviewCardsRefs(
    Expression<bool> Function($$ReviewCardsTableFilterComposer f) f,
  ) {
    final $$ReviewCardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewCards,
      getReferencedColumn: (t) => t.questionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewCardsTableFilterComposer(
            $db: $db,
            $table: $db.reviewCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> reviewLogsRefs(
    Expression<bool> Function($$ReviewLogsTableFilterComposer f) f,
  ) {
    final $$ReviewLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewLogs,
      getReferencedColumn: (t) => t.questionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewLogsTableFilterComposer(
            $db: $db,
            $table: $db.reviewLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> questionMasteryRefs(
    Expression<bool> Function($$QuestionMasteryTableFilterComposer f) f,
  ) {
    final $$QuestionMasteryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questionMastery,
      getReferencedColumn: (t) => t.questionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionMasteryTableFilterComposer(
            $db: $db,
            $table: $db.questionMastery,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$QuestionsTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionsTable> {
  $$QuestionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get promptLatex => $composableBuilder(
    column: $table.promptLatex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get answerLatex => $composableBuilder(
    column: $table.answerLatex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get solutionLatex => $composableBuilder(
    column: $table.solutionLatex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hintLatex => $composableBuilder(
    column: $table.hintLatex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceText => $composableBuilder(
    column: $table.sourceText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorReason => $composableBuilder(
    column: $table.errorReason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isStarred => $composableBuilder(
    column: $table.isStarred,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$QuestionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionsTable> {
  $$QuestionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get promptLatex => $composableBuilder(
    column: $table.promptLatex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get answerLatex => $composableBuilder(
    column: $table.answerLatex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get solutionLatex => $composableBuilder(
    column: $table.solutionLatex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get hintLatex =>
      $composableBuilder(column: $table.hintLatex, builder: (column) => column);

  GeneratedColumn<int> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceText => $composableBuilder(
    column: $table.sourceText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get errorReason => $composableBuilder(
    column: $table.errorReason,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isStarred =>
      $composableBuilder(column: $table.isStarred, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  Expression<T> questionKnowledgeRefs<T extends Object>(
    Expression<T> Function($$QuestionKnowledgeTableAnnotationComposer a) f,
  ) {
    final $$QuestionKnowledgeTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.questionKnowledge,
          getReferencedColumn: (t) => t.questionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$QuestionKnowledgeTableAnnotationComposer(
                $db: $db,
                $table: $db.questionKnowledge,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> questionTagsRefs<T extends Object>(
    Expression<T> Function($$QuestionTagsTableAnnotationComposer a) f,
  ) {
    final $$QuestionTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questionTags,
      getReferencedColumn: (t) => t.questionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.questionTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> questionImagesRefs<T extends Object>(
    Expression<T> Function($$QuestionImagesTableAnnotationComposer a) f,
  ) {
    final $$QuestionImagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questionImages,
      getReferencedColumn: (t) => t.questionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionImagesTableAnnotationComposer(
            $db: $db,
            $table: $db.questionImages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> reviewCardsRefs<T extends Object>(
    Expression<T> Function($$ReviewCardsTableAnnotationComposer a) f,
  ) {
    final $$ReviewCardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewCards,
      getReferencedColumn: (t) => t.questionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewCardsTableAnnotationComposer(
            $db: $db,
            $table: $db.reviewCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> reviewLogsRefs<T extends Object>(
    Expression<T> Function($$ReviewLogsTableAnnotationComposer a) f,
  ) {
    final $$ReviewLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewLogs,
      getReferencedColumn: (t) => t.questionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.reviewLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> questionMasteryRefs<T extends Object>(
    Expression<T> Function($$QuestionMasteryTableAnnotationComposer a) f,
  ) {
    final $$QuestionMasteryTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questionMastery,
      getReferencedColumn: (t) => t.questionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionMasteryTableAnnotationComposer(
            $db: $db,
            $table: $db.questionMastery,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$QuestionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuestionsTable,
          QuestionRow,
          $$QuestionsTableFilterComposer,
          $$QuestionsTableOrderingComposer,
          $$QuestionsTableAnnotationComposer,
          $$QuestionsTableCreateCompanionBuilder,
          $$QuestionsTableUpdateCompanionBuilder,
          (QuestionRow, $$QuestionsTableReferences),
          QuestionRow,
          PrefetchHooks Function({
            bool questionKnowledgeRefs,
            bool questionTagsRefs,
            bool questionImagesRefs,
            bool reviewCardsRefs,
            bool reviewLogsRefs,
            bool questionMasteryRefs,
          })
        > {
  $$QuestionsTableTableManager(_$AppDatabase db, $QuestionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuestionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> promptLatex = const Value.absent(),
                Value<String?> answerLatex = const Value.absent(),
                Value<String?> solutionLatex = const Value.absent(),
                Value<String?> hintLatex = const Value.absent(),
                Value<int?> difficulty = const Value.absent(),
                Value<String?> sourceText = const Value.absent(),
                Value<String?> errorReason = const Value.absent(),
                Value<bool> isStarred = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuestionsCompanion(
                id: id,
                promptLatex: promptLatex,
                answerLatex: answerLatex,
                solutionLatex: solutionLatex,
                hintLatex: hintLatex,
                difficulty: difficulty,
                sourceText: sourceText,
                errorReason: errorReason,
                isStarred: isStarred,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String promptLatex,
                Value<String?> answerLatex = const Value.absent(),
                Value<String?> solutionLatex = const Value.absent(),
                Value<String?> hintLatex = const Value.absent(),
                Value<int?> difficulty = const Value.absent(),
                Value<String?> sourceText = const Value.absent(),
                Value<String?> errorReason = const Value.absent(),
                Value<bool> isStarred = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuestionsCompanion.insert(
                id: id,
                promptLatex: promptLatex,
                answerLatex: answerLatex,
                solutionLatex: solutionLatex,
                hintLatex: hintLatex,
                difficulty: difficulty,
                sourceText: sourceText,
                errorReason: errorReason,
                isStarred: isStarred,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$QuestionsTable, QuestionRow>(table),
                  $$QuestionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                questionKnowledgeRefs = false,
                questionTagsRefs = false,
                questionImagesRefs = false,
                reviewCardsRefs = false,
                reviewLogsRefs = false,
                questionMasteryRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (questionKnowledgeRefs) db.questionKnowledge,
                    if (questionTagsRefs) db.questionTags,
                    if (questionImagesRefs) db.questionImages,
                    if (reviewCardsRefs) db.reviewCards,
                    if (reviewLogsRefs) db.reviewLogs,
                    if (questionMasteryRefs) db.questionMastery,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (questionKnowledgeRefs)
                        await $_getPrefetchedDataByColumns<
                          QuestionRow,
                          $QuestionsTable,
                          QuestionKnowledgeRow,
                          $QuestionKnowledgeTable
                        >(
                          currentTable: table,
                          referencedTable: $$QuestionsTableReferences
                              ._questionKnowledgeRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$QuestionsTableReferences(
                                db,
                                table,
                                p0,
                              ).questionKnowledgeRefs,
                          currentColumn: 'id',
                          referencedColumn: 'question_id',
                          typedResults: items,
                        ),
                      if (questionTagsRefs)
                        await $_getPrefetchedDataByColumns<
                          QuestionRow,
                          $QuestionsTable,
                          QuestionTagRow,
                          $QuestionTagsTable
                        >(
                          currentTable: table,
                          referencedTable: $$QuestionsTableReferences
                              ._questionTagsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$QuestionsTableReferences(
                                db,
                                table,
                                p0,
                              ).questionTagsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'question_id',
                          typedResults: items,
                        ),
                      if (questionImagesRefs)
                        await $_getPrefetchedDataByColumns<
                          QuestionRow,
                          $QuestionsTable,
                          QuestionImageRow,
                          $QuestionImagesTable
                        >(
                          currentTable: table,
                          referencedTable: $$QuestionsTableReferences
                              ._questionImagesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$QuestionsTableReferences(
                                db,
                                table,
                                p0,
                              ).questionImagesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'question_id',
                          typedResults: items,
                        ),
                      if (reviewCardsRefs)
                        await $_getPrefetchedDataByColumns<
                          QuestionRow,
                          $QuestionsTable,
                          ReviewCardRow,
                          $ReviewCardsTable
                        >(
                          currentTable: table,
                          referencedTable: $$QuestionsTableReferences
                              ._reviewCardsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$QuestionsTableReferences(
                                db,
                                table,
                                p0,
                              ).reviewCardsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'question_id',
                          typedResults: items,
                        ),
                      if (reviewLogsRefs)
                        await $_getPrefetchedDataByColumns<
                          QuestionRow,
                          $QuestionsTable,
                          ReviewLogRow,
                          $ReviewLogsTable
                        >(
                          currentTable: table,
                          referencedTable: $$QuestionsTableReferences
                              ._reviewLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$QuestionsTableReferences(
                                db,
                                table,
                                p0,
                              ).reviewLogsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'question_id',
                          typedResults: items,
                        ),
                      if (questionMasteryRefs)
                        await $_getPrefetchedDataByColumns<
                          QuestionRow,
                          $QuestionsTable,
                          QuestionMasteryRow,
                          $QuestionMasteryTable
                        >(
                          currentTable: table,
                          referencedTable: $$QuestionsTableReferences
                              ._questionMasteryRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$QuestionsTableReferences(
                                db,
                                table,
                                p0,
                              ).questionMasteryRefs,
                          currentColumn: 'id',
                          referencedColumn: 'question_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$QuestionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuestionsTable,
      QuestionRow,
      $$QuestionsTableFilterComposer,
      $$QuestionsTableOrderingComposer,
      $$QuestionsTableAnnotationComposer,
      $$QuestionsTableCreateCompanionBuilder,
      $$QuestionsTableUpdateCompanionBuilder,
      (QuestionRow, $$QuestionsTableReferences),
      QuestionRow,
      PrefetchHooks Function({
        bool questionKnowledgeRefs,
        bool questionTagsRefs,
        bool questionImagesRefs,
        bool reviewCardsRefs,
        bool reviewLogsRefs,
        bool questionMasteryRefs,
      })
    >;
typedef $$QuestionKnowledgeTableCreateCompanionBuilder =
    QuestionKnowledgeCompanion Function({
      required String questionId,
      required String nodeId,
      Value<double> relevance,
      Value<bool> isPrimary,
      Value<int> createdAt,
      Value<int> rowid,
    });
typedef $$QuestionKnowledgeTableUpdateCompanionBuilder =
    QuestionKnowledgeCompanion Function({
      Value<String> questionId,
      Value<String> nodeId,
      Value<double> relevance,
      Value<bool> isPrimary,
      Value<int> createdAt,
      Value<int> rowid,
    });

final class $$QuestionKnowledgeTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $QuestionKnowledgeTable,
          QuestionKnowledgeRow
        > {
  $$QuestionKnowledgeTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $QuestionsTable _questionIdTable(_$AppDatabase db) => db.questions
      .createAlias('question_knowledge__question_id__questions__id');

  $$QuestionsTableProcessedTableManager get questionId {
    final $_column = $_itemColumn<String>('question_id')!;

    final manager = $$QuestionsTableTableManager(
      $_db,
      $_db.questions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_questionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $KnowledgeNodesTable _nodeIdTable(_$AppDatabase db) => db
      .knowledgeNodes
      .createAlias('question_knowledge__node_id__knowledge_nodes__id');

  $$KnowledgeNodesTableProcessedTableManager get nodeId {
    final $_column = $_itemColumn<String>('node_id')!;

    final manager = $$KnowledgeNodesTableTableManager(
      $_db,
      $_db.knowledgeNodes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_nodeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$QuestionKnowledgeTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionKnowledgeTable> {
  $$QuestionKnowledgeTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<double> get relevance => $composableBuilder(
    column: $table.relevance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPrimary => $composableBuilder(
    column: $table.isPrimary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$QuestionsTableFilterComposer get questionId {
    final $$QuestionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableFilterComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$KnowledgeNodesTableFilterComposer get nodeId {
    final $$KnowledgeNodesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nodeId,
      referencedTable: $db.knowledgeNodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KnowledgeNodesTableFilterComposer(
            $db: $db,
            $table: $db.knowledgeNodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionKnowledgeTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionKnowledgeTable> {
  $$QuestionKnowledgeTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<double> get relevance => $composableBuilder(
    column: $table.relevance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPrimary => $composableBuilder(
    column: $table.isPrimary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$QuestionsTableOrderingComposer get questionId {
    final $$QuestionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableOrderingComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$KnowledgeNodesTableOrderingComposer get nodeId {
    final $$KnowledgeNodesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nodeId,
      referencedTable: $db.knowledgeNodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KnowledgeNodesTableOrderingComposer(
            $db: $db,
            $table: $db.knowledgeNodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionKnowledgeTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionKnowledgeTable> {
  $$QuestionKnowledgeTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<double> get relevance =>
      $composableBuilder(column: $table.relevance, builder: (column) => column);

  GeneratedColumn<bool> get isPrimary =>
      $composableBuilder(column: $table.isPrimary, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$QuestionsTableAnnotationComposer get questionId {
    final $$QuestionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableAnnotationComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$KnowledgeNodesTableAnnotationComposer get nodeId {
    final $$KnowledgeNodesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nodeId,
      referencedTable: $db.knowledgeNodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KnowledgeNodesTableAnnotationComposer(
            $db: $db,
            $table: $db.knowledgeNodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionKnowledgeTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuestionKnowledgeTable,
          QuestionKnowledgeRow,
          $$QuestionKnowledgeTableFilterComposer,
          $$QuestionKnowledgeTableOrderingComposer,
          $$QuestionKnowledgeTableAnnotationComposer,
          $$QuestionKnowledgeTableCreateCompanionBuilder,
          $$QuestionKnowledgeTableUpdateCompanionBuilder,
          (QuestionKnowledgeRow, $$QuestionKnowledgeTableReferences),
          QuestionKnowledgeRow,
          PrefetchHooks Function({bool questionId, bool nodeId})
        > {
  $$QuestionKnowledgeTableTableManager(
    _$AppDatabase db,
    $QuestionKnowledgeTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionKnowledgeTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestionKnowledgeTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuestionKnowledgeTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> questionId = const Value.absent(),
                Value<String> nodeId = const Value.absent(),
                Value<double> relevance = const Value.absent(),
                Value<bool> isPrimary = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuestionKnowledgeCompanion(
                questionId: questionId,
                nodeId: nodeId,
                relevance: relevance,
                isPrimary: isPrimary,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String questionId,
                required String nodeId,
                Value<double> relevance = const Value.absent(),
                Value<bool> isPrimary = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuestionKnowledgeCompanion.insert(
                questionId: questionId,
                nodeId: nodeId,
                relevance: relevance,
                isPrimary: isPrimary,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$QuestionKnowledgeTable, QuestionKnowledgeRow>(
                    table,
                  ),
                  $$QuestionKnowledgeTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({questionId = false, nodeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (questionId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.questionId,
                        referencedTable: $$QuestionKnowledgeTableReferences
                            ._questionIdTable(db),
                        referencedColumn: $$QuestionKnowledgeTableReferences
                            ._questionIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (nodeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.nodeId,
                        referencedTable: $$QuestionKnowledgeTableReferences
                            ._nodeIdTable(db),
                        referencedColumn: $$QuestionKnowledgeTableReferences
                            ._nodeIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$QuestionKnowledgeTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuestionKnowledgeTable,
      QuestionKnowledgeRow,
      $$QuestionKnowledgeTableFilterComposer,
      $$QuestionKnowledgeTableOrderingComposer,
      $$QuestionKnowledgeTableAnnotationComposer,
      $$QuestionKnowledgeTableCreateCompanionBuilder,
      $$QuestionKnowledgeTableUpdateCompanionBuilder,
      (QuestionKnowledgeRow, $$QuestionKnowledgeTableReferences),
      QuestionKnowledgeRow,
      PrefetchHooks Function({bool questionId, bool nodeId})
    >;
typedef $$QuestionTagsTableCreateCompanionBuilder =
    QuestionTagsCompanion Function({
      required String questionId,
      required String tagId,
      Value<int> createdAt,
      Value<int> rowid,
    });
typedef $$QuestionTagsTableUpdateCompanionBuilder =
    QuestionTagsCompanion Function({
      Value<String> questionId,
      Value<String> tagId,
      Value<int> createdAt,
      Value<int> rowid,
    });

final class $$QuestionTagsTableReferences
    extends BaseReferences<_$AppDatabase, $QuestionTagsTable, QuestionTagRow> {
  $$QuestionTagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $QuestionsTable _questionIdTable(_$AppDatabase db) =>
      db.questions.createAlias('question_tags__question_id__questions__id');

  $$QuestionsTableProcessedTableManager get questionId {
    final $_column = $_itemColumn<String>('question_id')!;

    final manager = $$QuestionsTableTableManager(
      $_db,
      $_db.questions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_questionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TagsTable _tagIdTable(_$AppDatabase db) =>
      db.tags.createAlias('question_tags__tag_id__tags__id');

  $$TagsTableProcessedTableManager get tagId {
    final $_column = $_itemColumn<String>('tag_id')!;

    final manager = $$TagsTableTableManager(
      $_db,
      $_db.tags,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tagIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$QuestionTagsTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionTagsTable> {
  $$QuestionTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$QuestionsTableFilterComposer get questionId {
    final $$QuestionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableFilterComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableFilterComposer get tagId {
    final $$TagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableFilterComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionTagsTable> {
  $$QuestionTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$QuestionsTableOrderingComposer get questionId {
    final $$QuestionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableOrderingComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableOrderingComposer get tagId {
    final $$TagsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableOrderingComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionTagsTable> {
  $$QuestionTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$QuestionsTableAnnotationComposer get questionId {
    final $$QuestionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableAnnotationComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableAnnotationComposer get tagId {
    final $$TagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableAnnotationComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionTagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuestionTagsTable,
          QuestionTagRow,
          $$QuestionTagsTableFilterComposer,
          $$QuestionTagsTableOrderingComposer,
          $$QuestionTagsTableAnnotationComposer,
          $$QuestionTagsTableCreateCompanionBuilder,
          $$QuestionTagsTableUpdateCompanionBuilder,
          (QuestionTagRow, $$QuestionTagsTableReferences),
          QuestionTagRow,
          PrefetchHooks Function({bool questionId, bool tagId})
        > {
  $$QuestionTagsTableTableManager(_$AppDatabase db, $QuestionTagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestionTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuestionTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> questionId = const Value.absent(),
                Value<String> tagId = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuestionTagsCompanion(
                questionId: questionId,
                tagId: tagId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String questionId,
                required String tagId,
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuestionTagsCompanion.insert(
                questionId: questionId,
                tagId: tagId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$QuestionTagsTable, QuestionTagRow>(table),
                  $$QuestionTagsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({questionId = false, tagId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (questionId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.questionId,
                        referencedTable: $$QuestionTagsTableReferences
                            ._questionIdTable(db),
                        referencedColumn: $$QuestionTagsTableReferences
                            ._questionIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (tagId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.tagId,
                        referencedTable: $$QuestionTagsTableReferences
                            ._tagIdTable(db),
                        referencedColumn: $$QuestionTagsTableReferences
                            ._tagIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$QuestionTagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuestionTagsTable,
      QuestionTagRow,
      $$QuestionTagsTableFilterComposer,
      $$QuestionTagsTableOrderingComposer,
      $$QuestionTagsTableAnnotationComposer,
      $$QuestionTagsTableCreateCompanionBuilder,
      $$QuestionTagsTableUpdateCompanionBuilder,
      (QuestionTagRow, $$QuestionTagsTableReferences),
      QuestionTagRow,
      PrefetchHooks Function({bool questionId, bool tagId})
    >;
typedef $$ImageAssetsTableCreateCompanionBuilder =
    ImageAssetsCompanion Function({
      required String sha256,
      required String relPath,
      Value<int> bytes,
      Value<int?> width,
      Value<int?> height,
      Value<String> mime,
      Value<int> createdAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });
typedef $$ImageAssetsTableUpdateCompanionBuilder =
    ImageAssetsCompanion Function({
      Value<String> sha256,
      Value<String> relPath,
      Value<int> bytes,
      Value<int?> width,
      Value<int?> height,
      Value<String> mime,
      Value<int> createdAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });

final class $$ImageAssetsTableReferences
    extends BaseReferences<_$AppDatabase, $ImageAssetsTable, ImageAssetRow> {
  $$ImageAssetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$QuestionImagesTable, List<QuestionImageRow>>
  _questionImagesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.questionImages,
    aliasName: 'image_assets__sha256__question_images__sha256',
  );

  $$QuestionImagesTableProcessedTableManager get questionImagesRefs {
    final manager = $$QuestionImagesTableTableManager(
      $_db,
      $_db.questionImages,
    ).filter((f) => f.sha256.sha256.sqlEquals($_itemColumn<String>('sha256')!));

    final cache = $_typedResult.readTableOrNull(_questionImagesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DraftItemImagesTable, List<DraftItemImageRow>>
  _draftItemImagesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.draftItemImages,
    aliasName: 'image_assets__sha256__draft_item_images__sha256',
  );

  $$DraftItemImagesTableProcessedTableManager get draftItemImagesRefs {
    final manager = $$DraftItemImagesTableTableManager(
      $_db,
      $_db.draftItemImages,
    ).filter((f) => f.sha256.sha256.sqlEquals($_itemColumn<String>('sha256')!));

    final cache = $_typedResult.readTableOrNull(
      _draftItemImagesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ImageAssetsTableFilterComposer
    extends Composer<_$AppDatabase, $ImageAssetsTable> {
  $$ImageAssetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relPath => $composableBuilder(
    column: $table.relPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bytes => $composableBuilder(
    column: $table.bytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mime => $composableBuilder(
    column: $table.mime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> questionImagesRefs(
    Expression<bool> Function($$QuestionImagesTableFilterComposer f) f,
  ) {
    final $$QuestionImagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sha256,
      referencedTable: $db.questionImages,
      getReferencedColumn: (t) => t.sha256,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionImagesTableFilterComposer(
            $db: $db,
            $table: $db.questionImages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> draftItemImagesRefs(
    Expression<bool> Function($$DraftItemImagesTableFilterComposer f) f,
  ) {
    final $$DraftItemImagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sha256,
      referencedTable: $db.draftItemImages,
      getReferencedColumn: (t) => t.sha256,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DraftItemImagesTableFilterComposer(
            $db: $db,
            $table: $db.draftItemImages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ImageAssetsTableOrderingComposer
    extends Composer<_$AppDatabase, $ImageAssetsTable> {
  $$ImageAssetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relPath => $composableBuilder(
    column: $table.relPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bytes => $composableBuilder(
    column: $table.bytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mime => $composableBuilder(
    column: $table.mime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ImageAssetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ImageAssetsTable> {
  $$ImageAssetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get sha256 =>
      $composableBuilder(column: $table.sha256, builder: (column) => column);

  GeneratedColumn<String> get relPath =>
      $composableBuilder(column: $table.relPath, builder: (column) => column);

  GeneratedColumn<int> get bytes =>
      $composableBuilder(column: $table.bytes, builder: (column) => column);

  GeneratedColumn<int> get width =>
      $composableBuilder(column: $table.width, builder: (column) => column);

  GeneratedColumn<int> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<String> get mime =>
      $composableBuilder(column: $table.mime, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  Expression<T> questionImagesRefs<T extends Object>(
    Expression<T> Function($$QuestionImagesTableAnnotationComposer a) f,
  ) {
    final $$QuestionImagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sha256,
      referencedTable: $db.questionImages,
      getReferencedColumn: (t) => t.sha256,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionImagesTableAnnotationComposer(
            $db: $db,
            $table: $db.questionImages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> draftItemImagesRefs<T extends Object>(
    Expression<T> Function($$DraftItemImagesTableAnnotationComposer a) f,
  ) {
    final $$DraftItemImagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sha256,
      referencedTable: $db.draftItemImages,
      getReferencedColumn: (t) => t.sha256,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DraftItemImagesTableAnnotationComposer(
            $db: $db,
            $table: $db.draftItemImages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ImageAssetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ImageAssetsTable,
          ImageAssetRow,
          $$ImageAssetsTableFilterComposer,
          $$ImageAssetsTableOrderingComposer,
          $$ImageAssetsTableAnnotationComposer,
          $$ImageAssetsTableCreateCompanionBuilder,
          $$ImageAssetsTableUpdateCompanionBuilder,
          (ImageAssetRow, $$ImageAssetsTableReferences),
          ImageAssetRow,
          PrefetchHooks Function({
            bool questionImagesRefs,
            bool draftItemImagesRefs,
          })
        > {
  $$ImageAssetsTableTableManager(_$AppDatabase db, $ImageAssetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ImageAssetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ImageAssetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ImageAssetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> sha256 = const Value.absent(),
                Value<String> relPath = const Value.absent(),
                Value<int> bytes = const Value.absent(),
                Value<int?> width = const Value.absent(),
                Value<int?> height = const Value.absent(),
                Value<String> mime = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ImageAssetsCompanion(
                sha256: sha256,
                relPath: relPath,
                bytes: bytes,
                width: width,
                height: height,
                mime: mime,
                createdAt: createdAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String sha256,
                required String relPath,
                Value<int> bytes = const Value.absent(),
                Value<int?> width = const Value.absent(),
                Value<int?> height = const Value.absent(),
                Value<String> mime = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ImageAssetsCompanion.insert(
                sha256: sha256,
                relPath: relPath,
                bytes: bytes,
                width: width,
                height: height,
                mime: mime,
                createdAt: createdAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ImageAssetsTable, ImageAssetRow>(table),
                  $$ImageAssetsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({questionImagesRefs = false, draftItemImagesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (questionImagesRefs) db.questionImages,
                    if (draftItemImagesRefs) db.draftItemImages,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (questionImagesRefs)
                        await $_getPrefetchedDataByColumns<
                          ImageAssetRow,
                          $ImageAssetsTable,
                          QuestionImageRow,
                          $QuestionImagesTable
                        >(
                          currentTable: table,
                          referencedTable: $$ImageAssetsTableReferences
                              ._questionImagesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ImageAssetsTableReferences(
                                db,
                                table,
                                p0,
                              ).questionImagesRefs,
                          currentColumn: 'sha256',
                          referencedColumn: 'sha256',
                          typedResults: items,
                        ),
                      if (draftItemImagesRefs)
                        await $_getPrefetchedDataByColumns<
                          ImageAssetRow,
                          $ImageAssetsTable,
                          DraftItemImageRow,
                          $DraftItemImagesTable
                        >(
                          currentTable: table,
                          referencedTable: $$ImageAssetsTableReferences
                              ._draftItemImagesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ImageAssetsTableReferences(
                                db,
                                table,
                                p0,
                              ).draftItemImagesRefs,
                          currentColumn: 'sha256',
                          referencedColumn: 'sha256',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ImageAssetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ImageAssetsTable,
      ImageAssetRow,
      $$ImageAssetsTableFilterComposer,
      $$ImageAssetsTableOrderingComposer,
      $$ImageAssetsTableAnnotationComposer,
      $$ImageAssetsTableCreateCompanionBuilder,
      $$ImageAssetsTableUpdateCompanionBuilder,
      (ImageAssetRow, $$ImageAssetsTableReferences),
      ImageAssetRow,
      PrefetchHooks Function({
        bool questionImagesRefs,
        bool draftItemImagesRefs,
      })
    >;
typedef $$QuestionImagesTableCreateCompanionBuilder =
    QuestionImagesCompanion Function({
      required String questionId,
      required String sha256,
      Value<String> role,
      Value<int> sortOrder,
      Value<int> createdAt,
      Value<int> rowid,
    });
typedef $$QuestionImagesTableUpdateCompanionBuilder =
    QuestionImagesCompanion Function({
      Value<String> questionId,
      Value<String> sha256,
      Value<String> role,
      Value<int> sortOrder,
      Value<int> createdAt,
      Value<int> rowid,
    });

final class $$QuestionImagesTableReferences
    extends
        BaseReferences<_$AppDatabase, $QuestionImagesTable, QuestionImageRow> {
  $$QuestionImagesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $QuestionsTable _questionIdTable(_$AppDatabase db) =>
      db.questions.createAlias('question_images__question_id__questions__id');

  $$QuestionsTableProcessedTableManager get questionId {
    final $_column = $_itemColumn<String>('question_id')!;

    final manager = $$QuestionsTableTableManager(
      $_db,
      $_db.questions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_questionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ImageAssetsTable _sha256Table(_$AppDatabase db) => db.imageAssets
      .createAlias('question_images__sha256__image_assets__sha256');

  $$ImageAssetsTableProcessedTableManager get sha256 {
    final $_column = $_itemColumn<String>('sha256')!;

    final manager = $$ImageAssetsTableTableManager(
      $_db,
      $_db.imageAssets,
    ).filter((f) => f.sha256.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sha256Table($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$QuestionImagesTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionImagesTable> {
  $$QuestionImagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$QuestionsTableFilterComposer get questionId {
    final $$QuestionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableFilterComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ImageAssetsTableFilterComposer get sha256 {
    final $$ImageAssetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sha256,
      referencedTable: $db.imageAssets,
      getReferencedColumn: (t) => t.sha256,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ImageAssetsTableFilterComposer(
            $db: $db,
            $table: $db.imageAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionImagesTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionImagesTable> {
  $$QuestionImagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$QuestionsTableOrderingComposer get questionId {
    final $$QuestionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableOrderingComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ImageAssetsTableOrderingComposer get sha256 {
    final $$ImageAssetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sha256,
      referencedTable: $db.imageAssets,
      getReferencedColumn: (t) => t.sha256,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ImageAssetsTableOrderingComposer(
            $db: $db,
            $table: $db.imageAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionImagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionImagesTable> {
  $$QuestionImagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$QuestionsTableAnnotationComposer get questionId {
    final $$QuestionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableAnnotationComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ImageAssetsTableAnnotationComposer get sha256 {
    final $$ImageAssetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sha256,
      referencedTable: $db.imageAssets,
      getReferencedColumn: (t) => t.sha256,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ImageAssetsTableAnnotationComposer(
            $db: $db,
            $table: $db.imageAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionImagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuestionImagesTable,
          QuestionImageRow,
          $$QuestionImagesTableFilterComposer,
          $$QuestionImagesTableOrderingComposer,
          $$QuestionImagesTableAnnotationComposer,
          $$QuestionImagesTableCreateCompanionBuilder,
          $$QuestionImagesTableUpdateCompanionBuilder,
          (QuestionImageRow, $$QuestionImagesTableReferences),
          QuestionImageRow,
          PrefetchHooks Function({bool questionId, bool sha256})
        > {
  $$QuestionImagesTableTableManager(
    _$AppDatabase db,
    $QuestionImagesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionImagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestionImagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuestionImagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> questionId = const Value.absent(),
                Value<String> sha256 = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuestionImagesCompanion(
                questionId: questionId,
                sha256: sha256,
                role: role,
                sortOrder: sortOrder,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String questionId,
                required String sha256,
                Value<String> role = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuestionImagesCompanion.insert(
                questionId: questionId,
                sha256: sha256,
                role: role,
                sortOrder: sortOrder,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$QuestionImagesTable, QuestionImageRow>(table),
                  $$QuestionImagesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({questionId = false, sha256 = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (questionId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.questionId,
                        referencedTable: $$QuestionImagesTableReferences
                            ._questionIdTable(db),
                        referencedColumn: $$QuestionImagesTableReferences
                            ._questionIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (sha256) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.sha256,
                        referencedTable: $$QuestionImagesTableReferences
                            ._sha256Table(db),
                        referencedColumn: $$QuestionImagesTableReferences
                            ._sha256Table(db)
                            .sha256,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$QuestionImagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuestionImagesTable,
      QuestionImageRow,
      $$QuestionImagesTableFilterComposer,
      $$QuestionImagesTableOrderingComposer,
      $$QuestionImagesTableAnnotationComposer,
      $$QuestionImagesTableCreateCompanionBuilder,
      $$QuestionImagesTableUpdateCompanionBuilder,
      (QuestionImageRow, $$QuestionImagesTableReferences),
      QuestionImageRow,
      PrefetchHooks Function({bool questionId, bool sha256})
    >;
typedef $$ReviewCardsTableCreateCompanionBuilder =
    ReviewCardsCompanion Function({
      required String questionId,
      Value<int> state,
      Value<int?> step,
      Value<int> dueAt,
      Value<double?> stability,
      Value<double?> difficulty,
      Value<int> elapsedDays,
      Value<int> scheduledDays,
      Value<int> reps,
      Value<int> lapses,
      Value<int?> lastReviewAt,
      Value<String> schedulerId,
      Value<String> paramsVersion,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> rowid,
    });
typedef $$ReviewCardsTableUpdateCompanionBuilder =
    ReviewCardsCompanion Function({
      Value<String> questionId,
      Value<int> state,
      Value<int?> step,
      Value<int> dueAt,
      Value<double?> stability,
      Value<double?> difficulty,
      Value<int> elapsedDays,
      Value<int> scheduledDays,
      Value<int> reps,
      Value<int> lapses,
      Value<int?> lastReviewAt,
      Value<String> schedulerId,
      Value<String> paramsVersion,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> rowid,
    });

final class $$ReviewCardsTableReferences
    extends BaseReferences<_$AppDatabase, $ReviewCardsTable, ReviewCardRow> {
  $$ReviewCardsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $QuestionsTable _questionIdTable(_$AppDatabase db) =>
      db.questions.createAlias('review_cards__question_id__questions__id');

  $$QuestionsTableProcessedTableManager get questionId {
    final $_column = $_itemColumn<String>('question_id')!;

    final manager = $$QuestionsTableTableManager(
      $_db,
      $_db.questions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_questionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReviewCardsTableFilterComposer
    extends Composer<_$AppDatabase, $ReviewCardsTable> {
  $$ReviewCardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get step => $composableBuilder(
    column: $table.step,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get stability => $composableBuilder(
    column: $table.stability,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get elapsedDays => $composableBuilder(
    column: $table.elapsedDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scheduledDays => $composableBuilder(
    column: $table.scheduledDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lapses => $composableBuilder(
    column: $table.lapses,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastReviewAt => $composableBuilder(
    column: $table.lastReviewAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get schedulerId => $composableBuilder(
    column: $table.schedulerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paramsVersion => $composableBuilder(
    column: $table.paramsVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$QuestionsTableFilterComposer get questionId {
    final $$QuestionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableFilterComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewCardsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReviewCardsTable> {
  $$ReviewCardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get step => $composableBuilder(
    column: $table.step,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get stability => $composableBuilder(
    column: $table.stability,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get elapsedDays => $composableBuilder(
    column: $table.elapsedDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scheduledDays => $composableBuilder(
    column: $table.scheduledDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lapses => $composableBuilder(
    column: $table.lapses,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastReviewAt => $composableBuilder(
    column: $table.lastReviewAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get schedulerId => $composableBuilder(
    column: $table.schedulerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paramsVersion => $composableBuilder(
    column: $table.paramsVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$QuestionsTableOrderingComposer get questionId {
    final $$QuestionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableOrderingComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewCardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReviewCardsTable> {
  $$ReviewCardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<int> get step =>
      $composableBuilder(column: $table.step, builder: (column) => column);

  GeneratedColumn<int> get dueAt =>
      $composableBuilder(column: $table.dueAt, builder: (column) => column);

  GeneratedColumn<double> get stability =>
      $composableBuilder(column: $table.stability, builder: (column) => column);

  GeneratedColumn<double> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<int> get elapsedDays => $composableBuilder(
    column: $table.elapsedDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get scheduledDays => $composableBuilder(
    column: $table.scheduledDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<int> get lapses =>
      $composableBuilder(column: $table.lapses, builder: (column) => column);

  GeneratedColumn<int> get lastReviewAt => $composableBuilder(
    column: $table.lastReviewAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get schedulerId => $composableBuilder(
    column: $table.schedulerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paramsVersion => $composableBuilder(
    column: $table.paramsVersion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$QuestionsTableAnnotationComposer get questionId {
    final $$QuestionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableAnnotationComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewCardsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReviewCardsTable,
          ReviewCardRow,
          $$ReviewCardsTableFilterComposer,
          $$ReviewCardsTableOrderingComposer,
          $$ReviewCardsTableAnnotationComposer,
          $$ReviewCardsTableCreateCompanionBuilder,
          $$ReviewCardsTableUpdateCompanionBuilder,
          (ReviewCardRow, $$ReviewCardsTableReferences),
          ReviewCardRow,
          PrefetchHooks Function({bool questionId})
        > {
  $$ReviewCardsTableTableManager(_$AppDatabase db, $ReviewCardsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReviewCardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReviewCardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReviewCardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> questionId = const Value.absent(),
                Value<int> state = const Value.absent(),
                Value<int?> step = const Value.absent(),
                Value<int> dueAt = const Value.absent(),
                Value<double?> stability = const Value.absent(),
                Value<double?> difficulty = const Value.absent(),
                Value<int> elapsedDays = const Value.absent(),
                Value<int> scheduledDays = const Value.absent(),
                Value<int> reps = const Value.absent(),
                Value<int> lapses = const Value.absent(),
                Value<int?> lastReviewAt = const Value.absent(),
                Value<String> schedulerId = const Value.absent(),
                Value<String> paramsVersion = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReviewCardsCompanion(
                questionId: questionId,
                state: state,
                step: step,
                dueAt: dueAt,
                stability: stability,
                difficulty: difficulty,
                elapsedDays: elapsedDays,
                scheduledDays: scheduledDays,
                reps: reps,
                lapses: lapses,
                lastReviewAt: lastReviewAt,
                schedulerId: schedulerId,
                paramsVersion: paramsVersion,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String questionId,
                Value<int> state = const Value.absent(),
                Value<int?> step = const Value.absent(),
                Value<int> dueAt = const Value.absent(),
                Value<double?> stability = const Value.absent(),
                Value<double?> difficulty = const Value.absent(),
                Value<int> elapsedDays = const Value.absent(),
                Value<int> scheduledDays = const Value.absent(),
                Value<int> reps = const Value.absent(),
                Value<int> lapses = const Value.absent(),
                Value<int?> lastReviewAt = const Value.absent(),
                Value<String> schedulerId = const Value.absent(),
                Value<String> paramsVersion = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReviewCardsCompanion.insert(
                questionId: questionId,
                state: state,
                step: step,
                dueAt: dueAt,
                stability: stability,
                difficulty: difficulty,
                elapsedDays: elapsedDays,
                scheduledDays: scheduledDays,
                reps: reps,
                lapses: lapses,
                lastReviewAt: lastReviewAt,
                schedulerId: schedulerId,
                paramsVersion: paramsVersion,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ReviewCardsTable, ReviewCardRow>(table),
                  $$ReviewCardsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({questionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (questionId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.questionId,
                        referencedTable: $$ReviewCardsTableReferences
                            ._questionIdTable(db),
                        referencedColumn: $$ReviewCardsTableReferences
                            ._questionIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ReviewCardsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReviewCardsTable,
      ReviewCardRow,
      $$ReviewCardsTableFilterComposer,
      $$ReviewCardsTableOrderingComposer,
      $$ReviewCardsTableAnnotationComposer,
      $$ReviewCardsTableCreateCompanionBuilder,
      $$ReviewCardsTableUpdateCompanionBuilder,
      (ReviewCardRow, $$ReviewCardsTableReferences),
      ReviewCardRow,
      PrefetchHooks Function({bool questionId})
    >;
typedef $$ReviewLogsTableCreateCompanionBuilder = ReviewLogsCompanion Function({
  required String id,
  required String questionId,
  Value<int?> rating,
  Value<int> reviewedAt,
  Value<int?> durationMs,
  Value<bool> usedHint,
  Value<bool> viewedAnswer,
  Value<bool> independent,
  Value<String> kind,
  Value<String?> stuckNodeIdsJson,
  Value<String?> errorType,
  Value<String?> stateBeforeJson,
  Value<String?> stateAfterJson,
  Value<String?> schedulerId,
  Value<String?> paramsVersion,
  Value<int> createdAt,
  Value<int> rowid,
});
typedef $$ReviewLogsTableUpdateCompanionBuilder = ReviewLogsCompanion Function({
  Value<String> id,
  Value<String> questionId,
  Value<int?> rating,
  Value<int> reviewedAt,
  Value<int?> durationMs,
  Value<bool> usedHint,
  Value<bool> viewedAnswer,
  Value<bool> independent,
  Value<String> kind,
  Value<String?> stuckNodeIdsJson,
  Value<String?> errorType,
  Value<String?> stateBeforeJson,
  Value<String?> stateAfterJson,
  Value<String?> schedulerId,
  Value<String?> paramsVersion,
  Value<int> createdAt,
  Value<int> rowid,
});

final class $$ReviewLogsTableReferences
    extends BaseReferences<_$AppDatabase, $ReviewLogsTable, ReviewLogRow> {
  $$ReviewLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $QuestionsTable _questionIdTable(_$AppDatabase db) =>
      db.questions.createAlias('review_logs__question_id__questions__id');

  $$QuestionsTableProcessedTableManager get questionId {
    final $_column = $_itemColumn<String>('question_id')!;

    final manager = $$QuestionsTableTableManager(
      $_db,
      $_db.questions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_questionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReviewLogsTableFilterComposer
    extends Composer<_$AppDatabase, $ReviewLogsTable> {
  $$ReviewLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get usedHint => $composableBuilder(
    column: $table.usedHint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get viewedAnswer => $composableBuilder(
    column: $table.viewedAnswer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get independent => $composableBuilder(
    column: $table.independent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stuckNodeIdsJson => $composableBuilder(
    column: $table.stuckNodeIdsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorType => $composableBuilder(
    column: $table.errorType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stateBeforeJson => $composableBuilder(
    column: $table.stateBeforeJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stateAfterJson => $composableBuilder(
    column: $table.stateAfterJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get schedulerId => $composableBuilder(
    column: $table.schedulerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paramsVersion => $composableBuilder(
    column: $table.paramsVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$QuestionsTableFilterComposer get questionId {
    final $$QuestionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableFilterComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReviewLogsTable> {
  $$ReviewLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get usedHint => $composableBuilder(
    column: $table.usedHint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get viewedAnswer => $composableBuilder(
    column: $table.viewedAnswer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get independent => $composableBuilder(
    column: $table.independent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stuckNodeIdsJson => $composableBuilder(
    column: $table.stuckNodeIdsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorType => $composableBuilder(
    column: $table.errorType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stateBeforeJson => $composableBuilder(
    column: $table.stateBeforeJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stateAfterJson => $composableBuilder(
    column: $table.stateAfterJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get schedulerId => $composableBuilder(
    column: $table.schedulerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paramsVersion => $composableBuilder(
    column: $table.paramsVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$QuestionsTableOrderingComposer get questionId {
    final $$QuestionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableOrderingComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReviewLogsTable> {
  $$ReviewLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<int> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get usedHint =>
      $composableBuilder(column: $table.usedHint, builder: (column) => column);

  GeneratedColumn<bool> get viewedAnswer => $composableBuilder(
    column: $table.viewedAnswer,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get independent => $composableBuilder(
    column: $table.independent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get stuckNodeIdsJson => $composableBuilder(
    column: $table.stuckNodeIdsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get errorType =>
      $composableBuilder(column: $table.errorType, builder: (column) => column);

  GeneratedColumn<String> get stateBeforeJson => $composableBuilder(
    column: $table.stateBeforeJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get stateAfterJson => $composableBuilder(
    column: $table.stateAfterJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get schedulerId => $composableBuilder(
    column: $table.schedulerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paramsVersion => $composableBuilder(
    column: $table.paramsVersion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$QuestionsTableAnnotationComposer get questionId {
    final $$QuestionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableAnnotationComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReviewLogsTable,
          ReviewLogRow,
          $$ReviewLogsTableFilterComposer,
          $$ReviewLogsTableOrderingComposer,
          $$ReviewLogsTableAnnotationComposer,
          $$ReviewLogsTableCreateCompanionBuilder,
          $$ReviewLogsTableUpdateCompanionBuilder,
          (ReviewLogRow, $$ReviewLogsTableReferences),
          ReviewLogRow,
          PrefetchHooks Function({bool questionId})
        > {
  $$ReviewLogsTableTableManager(_$AppDatabase db, $ReviewLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReviewLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReviewLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReviewLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> questionId = const Value.absent(),
                Value<int?> rating = const Value.absent(),
                Value<int> reviewedAt = const Value.absent(),
                Value<int?> durationMs = const Value.absent(),
                Value<bool> usedHint = const Value.absent(),
                Value<bool> viewedAnswer = const Value.absent(),
                Value<bool> independent = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String?> stuckNodeIdsJson = const Value.absent(),
                Value<String?> errorType = const Value.absent(),
                Value<String?> stateBeforeJson = const Value.absent(),
                Value<String?> stateAfterJson = const Value.absent(),
                Value<String?> schedulerId = const Value.absent(),
                Value<String?> paramsVersion = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReviewLogsCompanion(
                id: id,
                questionId: questionId,
                rating: rating,
                reviewedAt: reviewedAt,
                durationMs: durationMs,
                usedHint: usedHint,
                viewedAnswer: viewedAnswer,
                independent: independent,
                kind: kind,
                stuckNodeIdsJson: stuckNodeIdsJson,
                errorType: errorType,
                stateBeforeJson: stateBeforeJson,
                stateAfterJson: stateAfterJson,
                schedulerId: schedulerId,
                paramsVersion: paramsVersion,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String questionId,
                Value<int?> rating = const Value.absent(),
                Value<int> reviewedAt = const Value.absent(),
                Value<int?> durationMs = const Value.absent(),
                Value<bool> usedHint = const Value.absent(),
                Value<bool> viewedAnswer = const Value.absent(),
                Value<bool> independent = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String?> stuckNodeIdsJson = const Value.absent(),
                Value<String?> errorType = const Value.absent(),
                Value<String?> stateBeforeJson = const Value.absent(),
                Value<String?> stateAfterJson = const Value.absent(),
                Value<String?> schedulerId = const Value.absent(),
                Value<String?> paramsVersion = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReviewLogsCompanion.insert(
                id: id,
                questionId: questionId,
                rating: rating,
                reviewedAt: reviewedAt,
                durationMs: durationMs,
                usedHint: usedHint,
                viewedAnswer: viewedAnswer,
                independent: independent,
                kind: kind,
                stuckNodeIdsJson: stuckNodeIdsJson,
                errorType: errorType,
                stateBeforeJson: stateBeforeJson,
                stateAfterJson: stateAfterJson,
                schedulerId: schedulerId,
                paramsVersion: paramsVersion,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ReviewLogsTable, ReviewLogRow>(table),
                  $$ReviewLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({questionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (questionId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.questionId,
                        referencedTable: $$ReviewLogsTableReferences
                            ._questionIdTable(db),
                        referencedColumn: $$ReviewLogsTableReferences
                            ._questionIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ReviewLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReviewLogsTable,
      ReviewLogRow,
      $$ReviewLogsTableFilterComposer,
      $$ReviewLogsTableOrderingComposer,
      $$ReviewLogsTableAnnotationComposer,
      $$ReviewLogsTableCreateCompanionBuilder,
      $$ReviewLogsTableUpdateCompanionBuilder,
      (ReviewLogRow, $$ReviewLogsTableReferences),
      ReviewLogRow,
      PrefetchHooks Function({bool questionId})
    >;
typedef $$DraftsTableCreateCompanionBuilder = DraftsCompanion Function({
  required String id,
  Value<String> source,
  Value<String?> imageSha256,
  Value<String?> tempImagePath,
  Value<String?> aiRawJson,
  Value<String?> aiProvider,
  Value<String?> aiModel,
  Value<String?> aiPromptVersion,
  Value<String> status,
  Value<String?> errorCode,
  Value<int> createdAt,
  Value<int> expiresAt,
  Value<int> rowid,
});
typedef $$DraftsTableUpdateCompanionBuilder = DraftsCompanion Function({
  Value<String> id,
  Value<String> source,
  Value<String?> imageSha256,
  Value<String?> tempImagePath,
  Value<String?> aiRawJson,
  Value<String?> aiProvider,
  Value<String?> aiModel,
  Value<String?> aiPromptVersion,
  Value<String> status,
  Value<String?> errorCode,
  Value<int> createdAt,
  Value<int> expiresAt,
  Value<int> rowid,
});

final class $$DraftsTableReferences
    extends BaseReferences<_$AppDatabase, $DraftsTable, DraftRow> {
  $$DraftsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DraftItemsTable, List<DraftItemRow>>
  _draftItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.draftItems,
    aliasName: 'drafts__id__draft_items__draft_id',
  );

  $$DraftItemsTableProcessedTableManager get draftItemsRefs {
    final manager = $$DraftItemsTableTableManager(
      $_db,
      $_db.draftItems,
    ).filter((f) => f.draftId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_draftItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DraftsTableFilterComposer
    extends Composer<_$AppDatabase, $DraftsTable> {
  $$DraftsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageSha256 => $composableBuilder(
    column: $table.imageSha256,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tempImagePath => $composableBuilder(
    column: $table.tempImagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aiRawJson => $composableBuilder(
    column: $table.aiRawJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aiProvider => $composableBuilder(
    column: $table.aiProvider,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aiModel => $composableBuilder(
    column: $table.aiModel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aiPromptVersion => $composableBuilder(
    column: $table.aiPromptVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorCode => $composableBuilder(
    column: $table.errorCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> draftItemsRefs(
    Expression<bool> Function($$DraftItemsTableFilterComposer f) f,
  ) {
    final $$DraftItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.draftItems,
      getReferencedColumn: (t) => t.draftId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DraftItemsTableFilterComposer(
            $db: $db,
            $table: $db.draftItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DraftsTableOrderingComposer
    extends Composer<_$AppDatabase, $DraftsTable> {
  $$DraftsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageSha256 => $composableBuilder(
    column: $table.imageSha256,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tempImagePath => $composableBuilder(
    column: $table.tempImagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aiRawJson => $composableBuilder(
    column: $table.aiRawJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aiProvider => $composableBuilder(
    column: $table.aiProvider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aiModel => $composableBuilder(
    column: $table.aiModel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aiPromptVersion => $composableBuilder(
    column: $table.aiPromptVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorCode => $composableBuilder(
    column: $table.errorCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DraftsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DraftsTable> {
  $$DraftsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get imageSha256 => $composableBuilder(
    column: $table.imageSha256,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tempImagePath => $composableBuilder(
    column: $table.tempImagePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get aiRawJson =>
      $composableBuilder(column: $table.aiRawJson, builder: (column) => column);

  GeneratedColumn<String> get aiProvider => $composableBuilder(
    column: $table.aiProvider,
    builder: (column) => column,
  );

  GeneratedColumn<String> get aiModel =>
      $composableBuilder(column: $table.aiModel, builder: (column) => column);

  GeneratedColumn<String> get aiPromptVersion => $composableBuilder(
    column: $table.aiPromptVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get errorCode =>
      $composableBuilder(column: $table.errorCode, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  Expression<T> draftItemsRefs<T extends Object>(
    Expression<T> Function($$DraftItemsTableAnnotationComposer a) f,
  ) {
    final $$DraftItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.draftItems,
      getReferencedColumn: (t) => t.draftId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DraftItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.draftItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DraftsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DraftsTable,
          DraftRow,
          $$DraftsTableFilterComposer,
          $$DraftsTableOrderingComposer,
          $$DraftsTableAnnotationComposer,
          $$DraftsTableCreateCompanionBuilder,
          $$DraftsTableUpdateCompanionBuilder,
          (DraftRow, $$DraftsTableReferences),
          DraftRow,
          PrefetchHooks Function({bool draftItemsRefs})
        > {
  $$DraftsTableTableManager(_$AppDatabase db, $DraftsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DraftsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DraftsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DraftsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> imageSha256 = const Value.absent(),
                Value<String?> tempImagePath = const Value.absent(),
                Value<String?> aiRawJson = const Value.absent(),
                Value<String?> aiProvider = const Value.absent(),
                Value<String?> aiModel = const Value.absent(),
                Value<String?> aiPromptVersion = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> errorCode = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> expiresAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DraftsCompanion(
                id: id,
                source: source,
                imageSha256: imageSha256,
                tempImagePath: tempImagePath,
                aiRawJson: aiRawJson,
                aiProvider: aiProvider,
                aiModel: aiModel,
                aiPromptVersion: aiPromptVersion,
                status: status,
                errorCode: errorCode,
                createdAt: createdAt,
                expiresAt: expiresAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String> source = const Value.absent(),
                Value<String?> imageSha256 = const Value.absent(),
                Value<String?> tempImagePath = const Value.absent(),
                Value<String?> aiRawJson = const Value.absent(),
                Value<String?> aiProvider = const Value.absent(),
                Value<String?> aiModel = const Value.absent(),
                Value<String?> aiPromptVersion = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> errorCode = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> expiresAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DraftsCompanion.insert(
                id: id,
                source: source,
                imageSha256: imageSha256,
                tempImagePath: tempImagePath,
                aiRawJson: aiRawJson,
                aiProvider: aiProvider,
                aiModel: aiModel,
                aiPromptVersion: aiPromptVersion,
                status: status,
                errorCode: errorCode,
                createdAt: createdAt,
                expiresAt: expiresAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DraftsTable, DraftRow>(table),
                  $$DraftsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({draftItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (draftItemsRefs) db.draftItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (draftItemsRefs)
                    await $_getPrefetchedDataByColumns<
                      DraftRow,
                      $DraftsTable,
                      DraftItemRow,
                      $DraftItemsTable
                    >(
                      currentTable: table,
                      referencedTable: $$DraftsTableReferences
                          ._draftItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$DraftsTableReferences(db, table, p0).draftItemsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'draft_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$DraftsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DraftsTable,
      DraftRow,
      $$DraftsTableFilterComposer,
      $$DraftsTableOrderingComposer,
      $$DraftsTableAnnotationComposer,
      $$DraftsTableCreateCompanionBuilder,
      $$DraftsTableUpdateCompanionBuilder,
      (DraftRow, $$DraftsTableReferences),
      DraftRow,
      PrefetchHooks Function({bool draftItemsRefs})
    >;
typedef $$DraftItemsTableCreateCompanionBuilder = DraftItemsCompanion Function({
  required String id,
  required String draftId,
  Value<int> sortOrder,
  Value<String?> promptLatex,
  Value<String?> answerLatex,
  Value<String?> solutionLatex,
  Value<String?> knowledgePointsJson,
  Value<double?> confidence,
  Value<bool> isSelected,
  Value<String?> createdQuestionId,
  Value<int> createdAt,
  Value<int> rowid,
});
typedef $$DraftItemsTableUpdateCompanionBuilder = DraftItemsCompanion Function({
  Value<String> id,
  Value<String> draftId,
  Value<int> sortOrder,
  Value<String?> promptLatex,
  Value<String?> answerLatex,
  Value<String?> solutionLatex,
  Value<String?> knowledgePointsJson,
  Value<double?> confidence,
  Value<bool> isSelected,
  Value<String?> createdQuestionId,
  Value<int> createdAt,
  Value<int> rowid,
});

final class $$DraftItemsTableReferences
    extends BaseReferences<_$AppDatabase, $DraftItemsTable, DraftItemRow> {
  $$DraftItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DraftsTable _draftIdTable(_$AppDatabase db) =>
      db.drafts.createAlias('draft_items__draft_id__drafts__id');

  $$DraftsTableProcessedTableManager get draftId {
    final $_column = $_itemColumn<String>('draft_id')!;

    final manager = $$DraftsTableTableManager(
      $_db,
      $_db.drafts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_draftIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$DraftItemImagesTable, List<DraftItemImageRow>>
  _draftItemImagesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.draftItemImages,
    aliasName: 'draft_items__id__draft_item_images__draft_item_id',
  );

  $$DraftItemImagesTableProcessedTableManager get draftItemImagesRefs {
    final manager = $$DraftItemImagesTableTableManager(
      $_db,
      $_db.draftItemImages,
    ).filter((f) => f.draftItemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _draftItemImagesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DraftItemsTableFilterComposer
    extends Composer<_$AppDatabase, $DraftItemsTable> {
  $$DraftItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get promptLatex => $composableBuilder(
    column: $table.promptLatex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get answerLatex => $composableBuilder(
    column: $table.answerLatex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get solutionLatex => $composableBuilder(
    column: $table.solutionLatex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get knowledgePointsJson => $composableBuilder(
    column: $table.knowledgePointsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSelected => $composableBuilder(
    column: $table.isSelected,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdQuestionId => $composableBuilder(
    column: $table.createdQuestionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$DraftsTableFilterComposer get draftId {
    final $$DraftsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.draftId,
      referencedTable: $db.drafts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DraftsTableFilterComposer(
            $db: $db,
            $table: $db.drafts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> draftItemImagesRefs(
    Expression<bool> Function($$DraftItemImagesTableFilterComposer f) f,
  ) {
    final $$DraftItemImagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.draftItemImages,
      getReferencedColumn: (t) => t.draftItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DraftItemImagesTableFilterComposer(
            $db: $db,
            $table: $db.draftItemImages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DraftItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $DraftItemsTable> {
  $$DraftItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get promptLatex => $composableBuilder(
    column: $table.promptLatex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get answerLatex => $composableBuilder(
    column: $table.answerLatex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get solutionLatex => $composableBuilder(
    column: $table.solutionLatex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get knowledgePointsJson => $composableBuilder(
    column: $table.knowledgePointsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSelected => $composableBuilder(
    column: $table.isSelected,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdQuestionId => $composableBuilder(
    column: $table.createdQuestionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$DraftsTableOrderingComposer get draftId {
    final $$DraftsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.draftId,
      referencedTable: $db.drafts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DraftsTableOrderingComposer(
            $db: $db,
            $table: $db.drafts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DraftItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DraftItemsTable> {
  $$DraftItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get promptLatex => $composableBuilder(
    column: $table.promptLatex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get answerLatex => $composableBuilder(
    column: $table.answerLatex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get solutionLatex => $composableBuilder(
    column: $table.solutionLatex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get knowledgePointsJson => $composableBuilder(
    column: $table.knowledgePointsJson,
    builder: (column) => column,
  );

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSelected => $composableBuilder(
    column: $table.isSelected,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdQuestionId => $composableBuilder(
    column: $table.createdQuestionId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$DraftsTableAnnotationComposer get draftId {
    final $$DraftsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.draftId,
      referencedTable: $db.drafts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DraftsTableAnnotationComposer(
            $db: $db,
            $table: $db.drafts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> draftItemImagesRefs<T extends Object>(
    Expression<T> Function($$DraftItemImagesTableAnnotationComposer a) f,
  ) {
    final $$DraftItemImagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.draftItemImages,
      getReferencedColumn: (t) => t.draftItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DraftItemImagesTableAnnotationComposer(
            $db: $db,
            $table: $db.draftItemImages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DraftItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DraftItemsTable,
          DraftItemRow,
          $$DraftItemsTableFilterComposer,
          $$DraftItemsTableOrderingComposer,
          $$DraftItemsTableAnnotationComposer,
          $$DraftItemsTableCreateCompanionBuilder,
          $$DraftItemsTableUpdateCompanionBuilder,
          (DraftItemRow, $$DraftItemsTableReferences),
          DraftItemRow,
          PrefetchHooks Function({bool draftId, bool draftItemImagesRefs})
        > {
  $$DraftItemsTableTableManager(_$AppDatabase db, $DraftItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DraftItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DraftItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DraftItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> draftId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String?> promptLatex = const Value.absent(),
                Value<String?> answerLatex = const Value.absent(),
                Value<String?> solutionLatex = const Value.absent(),
                Value<String?> knowledgePointsJson = const Value.absent(),
                Value<double?> confidence = const Value.absent(),
                Value<bool> isSelected = const Value.absent(),
                Value<String?> createdQuestionId = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DraftItemsCompanion(
                id: id,
                draftId: draftId,
                sortOrder: sortOrder,
                promptLatex: promptLatex,
                answerLatex: answerLatex,
                solutionLatex: solutionLatex,
                knowledgePointsJson: knowledgePointsJson,
                confidence: confidence,
                isSelected: isSelected,
                createdQuestionId: createdQuestionId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String draftId,
                Value<int> sortOrder = const Value.absent(),
                Value<String?> promptLatex = const Value.absent(),
                Value<String?> answerLatex = const Value.absent(),
                Value<String?> solutionLatex = const Value.absent(),
                Value<String?> knowledgePointsJson = const Value.absent(),
                Value<double?> confidence = const Value.absent(),
                Value<bool> isSelected = const Value.absent(),
                Value<String?> createdQuestionId = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DraftItemsCompanion.insert(
                id: id,
                draftId: draftId,
                sortOrder: sortOrder,
                promptLatex: promptLatex,
                answerLatex: answerLatex,
                solutionLatex: solutionLatex,
                knowledgePointsJson: knowledgePointsJson,
                confidence: confidence,
                isSelected: isSelected,
                createdQuestionId: createdQuestionId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DraftItemsTable, DraftItemRow>(table),
                  $$DraftItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({draftId = false, draftItemImagesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (draftItemImagesRefs) db.draftItemImages,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (draftId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.draftId,
                            referencedTable: $$DraftItemsTableReferences
                                ._draftIdTable(db),
                            referencedColumn: $$DraftItemsTableReferences
                                ._draftIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (draftItemImagesRefs)
                        await $_getPrefetchedDataByColumns<
                          DraftItemRow,
                          $DraftItemsTable,
                          DraftItemImageRow,
                          $DraftItemImagesTable
                        >(
                          currentTable: table,
                          referencedTable: $$DraftItemsTableReferences
                              ._draftItemImagesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DraftItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).draftItemImagesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'draft_item_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$DraftItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DraftItemsTable,
      DraftItemRow,
      $$DraftItemsTableFilterComposer,
      $$DraftItemsTableOrderingComposer,
      $$DraftItemsTableAnnotationComposer,
      $$DraftItemsTableCreateCompanionBuilder,
      $$DraftItemsTableUpdateCompanionBuilder,
      (DraftItemRow, $$DraftItemsTableReferences),
      DraftItemRow,
      PrefetchHooks Function({bool draftId, bool draftItemImagesRefs})
    >;
typedef $$DraftItemImagesTableCreateCompanionBuilder =
    DraftItemImagesCompanion Function({
      required String draftItemId,
      required String sha256,
      Value<int> sortOrder,
      Value<int> createdAt,
      Value<int> rowid,
    });
typedef $$DraftItemImagesTableUpdateCompanionBuilder =
    DraftItemImagesCompanion Function({
      Value<String> draftItemId,
      Value<String> sha256,
      Value<int> sortOrder,
      Value<int> createdAt,
      Value<int> rowid,
    });

final class $$DraftItemImagesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $DraftItemImagesTable,
          DraftItemImageRow
        > {
  $$DraftItemImagesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DraftItemsTable _draftItemIdTable(_$AppDatabase db) => db.draftItems
      .createAlias('draft_item_images__draft_item_id__draft_items__id');

  $$DraftItemsTableProcessedTableManager get draftItemId {
    final $_column = $_itemColumn<String>('draft_item_id')!;

    final manager = $$DraftItemsTableTableManager(
      $_db,
      $_db.draftItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_draftItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ImageAssetsTable _sha256Table(_$AppDatabase db) => db.imageAssets
      .createAlias('draft_item_images__sha256__image_assets__sha256');

  $$ImageAssetsTableProcessedTableManager get sha256 {
    final $_column = $_itemColumn<String>('sha256')!;

    final manager = $$ImageAssetsTableTableManager(
      $_db,
      $_db.imageAssets,
    ).filter((f) => f.sha256.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sha256Table($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DraftItemImagesTableFilterComposer
    extends Composer<_$AppDatabase, $DraftItemImagesTable> {
  $$DraftItemImagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$DraftItemsTableFilterComposer get draftItemId {
    final $$DraftItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.draftItemId,
      referencedTable: $db.draftItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DraftItemsTableFilterComposer(
            $db: $db,
            $table: $db.draftItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ImageAssetsTableFilterComposer get sha256 {
    final $$ImageAssetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sha256,
      referencedTable: $db.imageAssets,
      getReferencedColumn: (t) => t.sha256,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ImageAssetsTableFilterComposer(
            $db: $db,
            $table: $db.imageAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DraftItemImagesTableOrderingComposer
    extends Composer<_$AppDatabase, $DraftItemImagesTable> {
  $$DraftItemImagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$DraftItemsTableOrderingComposer get draftItemId {
    final $$DraftItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.draftItemId,
      referencedTable: $db.draftItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DraftItemsTableOrderingComposer(
            $db: $db,
            $table: $db.draftItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ImageAssetsTableOrderingComposer get sha256 {
    final $$ImageAssetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sha256,
      referencedTable: $db.imageAssets,
      getReferencedColumn: (t) => t.sha256,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ImageAssetsTableOrderingComposer(
            $db: $db,
            $table: $db.imageAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DraftItemImagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DraftItemImagesTable> {
  $$DraftItemImagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$DraftItemsTableAnnotationComposer get draftItemId {
    final $$DraftItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.draftItemId,
      referencedTable: $db.draftItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DraftItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.draftItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ImageAssetsTableAnnotationComposer get sha256 {
    final $$ImageAssetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sha256,
      referencedTable: $db.imageAssets,
      getReferencedColumn: (t) => t.sha256,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ImageAssetsTableAnnotationComposer(
            $db: $db,
            $table: $db.imageAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DraftItemImagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DraftItemImagesTable,
          DraftItemImageRow,
          $$DraftItemImagesTableFilterComposer,
          $$DraftItemImagesTableOrderingComposer,
          $$DraftItemImagesTableAnnotationComposer,
          $$DraftItemImagesTableCreateCompanionBuilder,
          $$DraftItemImagesTableUpdateCompanionBuilder,
          (DraftItemImageRow, $$DraftItemImagesTableReferences),
          DraftItemImageRow,
          PrefetchHooks Function({bool draftItemId, bool sha256})
        > {
  $$DraftItemImagesTableTableManager(
    _$AppDatabase db,
    $DraftItemImagesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DraftItemImagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DraftItemImagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DraftItemImagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> draftItemId = const Value.absent(),
                Value<String> sha256 = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DraftItemImagesCompanion(
                draftItemId: draftItemId,
                sha256: sha256,
                sortOrder: sortOrder,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String draftItemId,
                required String sha256,
                Value<int> sortOrder = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DraftItemImagesCompanion.insert(
                draftItemId: draftItemId,
                sha256: sha256,
                sortOrder: sortOrder,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DraftItemImagesTable, DraftItemImageRow>(table),
                  $$DraftItemImagesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({draftItemId = false, sha256 = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (draftItemId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.draftItemId,
                        referencedTable: $$DraftItemImagesTableReferences
                            ._draftItemIdTable(db),
                        referencedColumn: $$DraftItemImagesTableReferences
                            ._draftItemIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (sha256) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.sha256,
                        referencedTable: $$DraftItemImagesTableReferences
                            ._sha256Table(db),
                        referencedColumn: $$DraftItemImagesTableReferences
                            ._sha256Table(db)
                            .sha256,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DraftItemImagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DraftItemImagesTable,
      DraftItemImageRow,
      $$DraftItemImagesTableFilterComposer,
      $$DraftItemImagesTableOrderingComposer,
      $$DraftItemImagesTableAnnotationComposer,
      $$DraftItemImagesTableCreateCompanionBuilder,
      $$DraftItemImagesTableUpdateCompanionBuilder,
      (DraftItemImageRow, $$DraftItemImagesTableReferences),
      DraftItemImageRow,
      PrefetchHooks Function({bool draftItemId, bool sha256})
    >;
typedef $$MasterySnapshotsTableCreateCompanionBuilder =
    MasterySnapshotsCompanion Function({
      required String nodeId,
      required double score,
      required double uncertainty,
      Value<int> evidenceCount,
      Value<int> computedAt,
      Value<String?> watermarkLogId,
      Value<String> modelVersion,
      Value<int> rowid,
    });
typedef $$MasterySnapshotsTableUpdateCompanionBuilder =
    MasterySnapshotsCompanion Function({
      Value<String> nodeId,
      Value<double> score,
      Value<double> uncertainty,
      Value<int> evidenceCount,
      Value<int> computedAt,
      Value<String?> watermarkLogId,
      Value<String> modelVersion,
      Value<int> rowid,
    });

final class $$MasterySnapshotsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MasterySnapshotsTable,
          MasterySnapshotRow
        > {
  $$MasterySnapshotsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $KnowledgeNodesTable _nodeIdTable(_$AppDatabase db) => db
      .knowledgeNodes
      .createAlias('mastery_snapshots__node_id__knowledge_nodes__id');

  $$KnowledgeNodesTableProcessedTableManager get nodeId {
    final $_column = $_itemColumn<String>('node_id')!;

    final manager = $$KnowledgeNodesTableTableManager(
      $_db,
      $_db.knowledgeNodes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_nodeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MasterySnapshotsTableFilterComposer
    extends Composer<_$AppDatabase, $MasterySnapshotsTable> {
  $$MasterySnapshotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<double> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get uncertainty => $composableBuilder(
    column: $table.uncertainty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get evidenceCount => $composableBuilder(
    column: $table.evidenceCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get computedAt => $composableBuilder(
    column: $table.computedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get watermarkLogId => $composableBuilder(
    column: $table.watermarkLogId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelVersion => $composableBuilder(
    column: $table.modelVersion,
    builder: (column) => ColumnFilters(column),
  );

  $$KnowledgeNodesTableFilterComposer get nodeId {
    final $$KnowledgeNodesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nodeId,
      referencedTable: $db.knowledgeNodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KnowledgeNodesTableFilterComposer(
            $db: $db,
            $table: $db.knowledgeNodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MasterySnapshotsTableOrderingComposer
    extends Composer<_$AppDatabase, $MasterySnapshotsTable> {
  $$MasterySnapshotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<double> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get uncertainty => $composableBuilder(
    column: $table.uncertainty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get evidenceCount => $composableBuilder(
    column: $table.evidenceCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get computedAt => $composableBuilder(
    column: $table.computedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get watermarkLogId => $composableBuilder(
    column: $table.watermarkLogId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelVersion => $composableBuilder(
    column: $table.modelVersion,
    builder: (column) => ColumnOrderings(column),
  );

  $$KnowledgeNodesTableOrderingComposer get nodeId {
    final $$KnowledgeNodesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nodeId,
      referencedTable: $db.knowledgeNodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KnowledgeNodesTableOrderingComposer(
            $db: $db,
            $table: $db.knowledgeNodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MasterySnapshotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MasterySnapshotsTable> {
  $$MasterySnapshotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<double> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<double> get uncertainty => $composableBuilder(
    column: $table.uncertainty,
    builder: (column) => column,
  );

  GeneratedColumn<int> get evidenceCount => $composableBuilder(
    column: $table.evidenceCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get computedAt => $composableBuilder(
    column: $table.computedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get watermarkLogId => $composableBuilder(
    column: $table.watermarkLogId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get modelVersion => $composableBuilder(
    column: $table.modelVersion,
    builder: (column) => column,
  );

  $$KnowledgeNodesTableAnnotationComposer get nodeId {
    final $$KnowledgeNodesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nodeId,
      referencedTable: $db.knowledgeNodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KnowledgeNodesTableAnnotationComposer(
            $db: $db,
            $table: $db.knowledgeNodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MasterySnapshotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MasterySnapshotsTable,
          MasterySnapshotRow,
          $$MasterySnapshotsTableFilterComposer,
          $$MasterySnapshotsTableOrderingComposer,
          $$MasterySnapshotsTableAnnotationComposer,
          $$MasterySnapshotsTableCreateCompanionBuilder,
          $$MasterySnapshotsTableUpdateCompanionBuilder,
          (MasterySnapshotRow, $$MasterySnapshotsTableReferences),
          MasterySnapshotRow,
          PrefetchHooks Function({bool nodeId})
        > {
  $$MasterySnapshotsTableTableManager(
    _$AppDatabase db,
    $MasterySnapshotsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MasterySnapshotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MasterySnapshotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MasterySnapshotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> nodeId = const Value.absent(),
                Value<double> score = const Value.absent(),
                Value<double> uncertainty = const Value.absent(),
                Value<int> evidenceCount = const Value.absent(),
                Value<int> computedAt = const Value.absent(),
                Value<String?> watermarkLogId = const Value.absent(),
                Value<String> modelVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MasterySnapshotsCompanion(
                nodeId: nodeId,
                score: score,
                uncertainty: uncertainty,
                evidenceCount: evidenceCount,
                computedAt: computedAt,
                watermarkLogId: watermarkLogId,
                modelVersion: modelVersion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String nodeId,
                required double score,
                required double uncertainty,
                Value<int> evidenceCount = const Value.absent(),
                Value<int> computedAt = const Value.absent(),
                Value<String?> watermarkLogId = const Value.absent(),
                Value<String> modelVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MasterySnapshotsCompanion.insert(
                nodeId: nodeId,
                score: score,
                uncertainty: uncertainty,
                evidenceCount: evidenceCount,
                computedAt: computedAt,
                watermarkLogId: watermarkLogId,
                modelVersion: modelVersion,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MasterySnapshotsTable, MasterySnapshotRow>(
                    table,
                  ),
                  $$MasterySnapshotsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({nodeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (nodeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.nodeId,
                        referencedTable: $$MasterySnapshotsTableReferences
                            ._nodeIdTable(db),
                        referencedColumn: $$MasterySnapshotsTableReferences
                            ._nodeIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MasterySnapshotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MasterySnapshotsTable,
      MasterySnapshotRow,
      $$MasterySnapshotsTableFilterComposer,
      $$MasterySnapshotsTableOrderingComposer,
      $$MasterySnapshotsTableAnnotationComposer,
      $$MasterySnapshotsTableCreateCompanionBuilder,
      $$MasterySnapshotsTableUpdateCompanionBuilder,
      (MasterySnapshotRow, $$MasterySnapshotsTableReferences),
      MasterySnapshotRow,
      PrefetchHooks Function({bool nodeId})
    >;
typedef $$QuestionMasteryTableCreateCompanionBuilder =
    QuestionMasteryCompanion Function({
      required String questionId,
      required double score,
      required double uncertainty,
      Value<int> computedAt,
      Value<String?> watermarkLogId,
      Value<int> rowid,
    });
typedef $$QuestionMasteryTableUpdateCompanionBuilder =
    QuestionMasteryCompanion Function({
      Value<String> questionId,
      Value<double> score,
      Value<double> uncertainty,
      Value<int> computedAt,
      Value<String?> watermarkLogId,
      Value<int> rowid,
    });

final class $$QuestionMasteryTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $QuestionMasteryTable,
          QuestionMasteryRow
        > {
  $$QuestionMasteryTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $QuestionsTable _questionIdTable(_$AppDatabase db) =>
      db.questions.createAlias('question_mastery__question_id__questions__id');

  $$QuestionsTableProcessedTableManager get questionId {
    final $_column = $_itemColumn<String>('question_id')!;

    final manager = $$QuestionsTableTableManager(
      $_db,
      $_db.questions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_questionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$QuestionMasteryTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionMasteryTable> {
  $$QuestionMasteryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<double> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get uncertainty => $composableBuilder(
    column: $table.uncertainty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get computedAt => $composableBuilder(
    column: $table.computedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get watermarkLogId => $composableBuilder(
    column: $table.watermarkLogId,
    builder: (column) => ColumnFilters(column),
  );

  $$QuestionsTableFilterComposer get questionId {
    final $$QuestionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableFilterComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionMasteryTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionMasteryTable> {
  $$QuestionMasteryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<double> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get uncertainty => $composableBuilder(
    column: $table.uncertainty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get computedAt => $composableBuilder(
    column: $table.computedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get watermarkLogId => $composableBuilder(
    column: $table.watermarkLogId,
    builder: (column) => ColumnOrderings(column),
  );

  $$QuestionsTableOrderingComposer get questionId {
    final $$QuestionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableOrderingComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionMasteryTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionMasteryTable> {
  $$QuestionMasteryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<double> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<double> get uncertainty => $composableBuilder(
    column: $table.uncertainty,
    builder: (column) => column,
  );

  GeneratedColumn<int> get computedAt => $composableBuilder(
    column: $table.computedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get watermarkLogId => $composableBuilder(
    column: $table.watermarkLogId,
    builder: (column) => column,
  );

  $$QuestionsTableAnnotationComposer get questionId {
    final $$QuestionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableAnnotationComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionMasteryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuestionMasteryTable,
          QuestionMasteryRow,
          $$QuestionMasteryTableFilterComposer,
          $$QuestionMasteryTableOrderingComposer,
          $$QuestionMasteryTableAnnotationComposer,
          $$QuestionMasteryTableCreateCompanionBuilder,
          $$QuestionMasteryTableUpdateCompanionBuilder,
          (QuestionMasteryRow, $$QuestionMasteryTableReferences),
          QuestionMasteryRow,
          PrefetchHooks Function({bool questionId})
        > {
  $$QuestionMasteryTableTableManager(
    _$AppDatabase db,
    $QuestionMasteryTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionMasteryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestionMasteryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuestionMasteryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> questionId = const Value.absent(),
                Value<double> score = const Value.absent(),
                Value<double> uncertainty = const Value.absent(),
                Value<int> computedAt = const Value.absent(),
                Value<String?> watermarkLogId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuestionMasteryCompanion(
                questionId: questionId,
                score: score,
                uncertainty: uncertainty,
                computedAt: computedAt,
                watermarkLogId: watermarkLogId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String questionId,
                required double score,
                required double uncertainty,
                Value<int> computedAt = const Value.absent(),
                Value<String?> watermarkLogId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuestionMasteryCompanion.insert(
                questionId: questionId,
                score: score,
                uncertainty: uncertainty,
                computedAt: computedAt,
                watermarkLogId: watermarkLogId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$QuestionMasteryTable, QuestionMasteryRow>(table),
                  $$QuestionMasteryTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({questionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (questionId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.questionId,
                        referencedTable: $$QuestionMasteryTableReferences
                            ._questionIdTable(db),
                        referencedColumn: $$QuestionMasteryTableReferences
                            ._questionIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$QuestionMasteryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuestionMasteryTable,
      QuestionMasteryRow,
      $$QuestionMasteryTableFilterComposer,
      $$QuestionMasteryTableOrderingComposer,
      $$QuestionMasteryTableAnnotationComposer,
      $$QuestionMasteryTableCreateCompanionBuilder,
      $$QuestionMasteryTableUpdateCompanionBuilder,
      (QuestionMasteryRow, $$QuestionMasteryTableReferences),
      QuestionMasteryRow,
      PrefetchHooks Function({bool questionId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AppMetaTableTableManager get appMeta =>
      $$AppMetaTableTableManager(_db, _db.appMeta);
  $$SettingsTableTableTableManager get settingsTable =>
      $$SettingsTableTableTableManager(_db, _db.settingsTable);
  $$KnowledgeNodesTableTableManager get knowledgeNodes =>
      $$KnowledgeNodesTableTableManager(_db, _db.knowledgeNodes);
  $$TagsTableTableManager get tags => $$TagsTableTableManager(_db, _db.tags);
  $$QuestionsTableTableManager get questions =>
      $$QuestionsTableTableManager(_db, _db.questions);
  $$QuestionKnowledgeTableTableManager get questionKnowledge =>
      $$QuestionKnowledgeTableTableManager(_db, _db.questionKnowledge);
  $$QuestionTagsTableTableManager get questionTags =>
      $$QuestionTagsTableTableManager(_db, _db.questionTags);
  $$ImageAssetsTableTableManager get imageAssets =>
      $$ImageAssetsTableTableManager(_db, _db.imageAssets);
  $$QuestionImagesTableTableManager get questionImages =>
      $$QuestionImagesTableTableManager(_db, _db.questionImages);
  $$ReviewCardsTableTableManager get reviewCards =>
      $$ReviewCardsTableTableManager(_db, _db.reviewCards);
  $$ReviewLogsTableTableManager get reviewLogs =>
      $$ReviewLogsTableTableManager(_db, _db.reviewLogs);
  $$DraftsTableTableManager get drafts =>
      $$DraftsTableTableManager(_db, _db.drafts);
  $$DraftItemsTableTableManager get draftItems =>
      $$DraftItemsTableTableManager(_db, _db.draftItems);
  $$DraftItemImagesTableTableManager get draftItemImages =>
      $$DraftItemImagesTableTableManager(_db, _db.draftItemImages);
  $$MasterySnapshotsTableTableManager get masterySnapshots =>
      $$MasterySnapshotsTableTableManager(_db, _db.masterySnapshots);
  $$QuestionMasteryTableTableManager get questionMastery =>
      $$QuestionMasteryTableTableManager(_db, _db.questionMastery);
}
