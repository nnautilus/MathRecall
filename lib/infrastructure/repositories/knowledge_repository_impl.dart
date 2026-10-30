import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../core/errors/app_error.dart';
import '../../domain/entities/knowledge_node.dart';
import '../../domain/entities/tag.dart';
import '../../domain/repositories/knowledge_repository.dart';
import '../database/app_database.dart';

class KnowledgeRepositoryImpl implements KnowledgeRepository {
  KnowledgeRepositoryImpl(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  int get _now => DateTime.now().toUtc().millisecondsSinceEpoch;

  @override
  Future<List<KnowledgeNode>> loadTree() async {
    final rows = await (_db.select(_db.knowledgeNodes)
          ..orderBy([
            (t) => OrderingTerm(expression: t.level),
            (t) => OrderingTerm(expression: t.sortOrder),
            (t) => OrderingTerm(expression: t.name),
          ]))
        .get();
    return rows.map(_mapNode).toList();
  }

  @override
  Future<KnowledgeNode> createNode({String? parentId, required String name}) async {
    final clean = name.trim();
    if (clean.isEmpty) {
      throw const AppError(AppErrorKind.validation, '名称不能为空');
    }
    final nodes = await _loadRows();
    final siblings = nodes.where((n) => n.parentId == parentId);
    _ensureUniqueName(siblings, clean);

    int level = 1;
    if (parentId != null) {
      final parent = _find(nodes, parentId);
      level = parent.level + 1;
    }
    if (level > 3) {
      throw const AppError(AppErrorKind.validation, '知识点最多三级');
    }

    final id = _uuid.v4();
    final now = _now;
    final sortOrder = siblings.isEmpty
        ? 0
        : siblings.map((n) => n.sortOrder).reduce((a, b) => a > b ? a : b) + 1;
    await _db.into(_db.knowledgeNodes).insert(
          KnowledgeNodesCompanion.insert(
            id: id,
            parentId: Value(parentId),
            level: level,
            name: clean,
            sortOrder: Value(sortOrder),
            createdAt: Value(now),
            updatedAt: Value(now),
          ),
        );
    return KnowledgeNode(
      id: id,
      parentId: parentId,
      level: level,
      name: clean,
      sortOrder: sortOrder,
      isSystem: false,
      isActive: true,
      createdAt: now,
      updatedAt: now,
    );
  }

  @override
  Future<void> renameNode(String id, String name) async {
    final clean = name.trim();
    if (clean.isEmpty) {
      throw const AppError(AppErrorKind.validation, '名称不能为空');
    }
    final nodes = await _loadRows();
    final node = _find(nodes, id);
    _ensureUniqueName(
      nodes.where((n) => n.parentId == node.parentId && n.id != id),
      clean,
    );
    await (_db.update(_db.knowledgeNodes)..where((t) => t.id.equals(id))).write(
      KnowledgeNodesCompanion(name: Value(clean), updatedAt: Value(_now)),
    );
  }

  @override
  Future<void> moveNode(String id, String? newParentId) async {
    final nodes = await _loadRows();
    final node = _find(nodes, id);
    if (newParentId == id) {
      throw const AppError(AppErrorKind.validation, '不能移动到自身下');
    }
    final descendants = _descendantsOf(nodes, id);
    if (newParentId != null && descendants.contains(newParentId)) {
      throw const AppError(AppErrorKind.validation, '不能移动到自己的子节点下');
    }

    final newLevel = newParentId == null ? 1 : _find(nodes, newParentId).level + 1;
    final delta = newLevel - node.level;
    if (newLevel > 3) {
      throw const AppError(AppErrorKind.validation, '知识点最多三级');
    }
    // 检查移动后整棵子树的最大层级。
    final subtree = {id, ...descendants};
    final maxLevel = nodes
        .where((n) => subtree.contains(n.id))
        .map((n) => n.level + delta)
        .reduce((a, b) => a > b ? a : b);
    if (maxLevel > 3) {
      throw const AppError(AppErrorKind.validation, '移动后层级超过三级');
    }

    _ensureUniqueName(
      nodes.where((n) => n.parentId == newParentId && n.id != id),
      node.name,
    );

    final now = _now;
    await _db.transaction(() async {
      await (_db.update(_db.knowledgeNodes)..where((t) => t.id.equals(id))).write(
        KnowledgeNodesCompanion(
          parentId: Value(newParentId),
          level: Value(newLevel),
          updatedAt: Value(now),
        ),
      );
      // 更新子树层级（保持相对结构）。
      for (final child in nodes.where((n) => descendants.contains(n.id))) {
        await (_db.update(_db.knowledgeNodes)..where((t) => t.id.equals(child.id))).write(
          KnowledgeNodesCompanion(
            level: Value(child.level + delta),
            updatedAt: Value(now),
          ),
        );
      }
    });
  }

  @override
  Future<void> setActive(String id, bool active) async {
    final nodes = await _loadRows();
    _find(nodes, id);
    final subtree = {id, ..._descendantsOf(nodes, id)};
    await _db.transaction(() async {
      for (final target in subtree) {
        await (_db.update(_db.knowledgeNodes)..where((t) => t.id.equals(target))).write(
          KnowledgeNodesCompanion(
            isActive: Value(active),
            updatedAt: Value(_now),
          ),
        );
      }
    });
  }

  @override
  Future<List<Tag>> listTags() async {
    final rows = await (_db.select(_db.tags)..orderBy([(t) => OrderingTerm(expression: t.name)])).get();
    return rows.map((r) => Tag(id: r.id, name: r.name, createdAt: r.createdAt)).toList();
  }

  @override
  Future<Tag> createTag(String name) async {
    final clean = name.trim();
    if (clean.isEmpty) {
      throw const AppError(AppErrorKind.validation, '标签不能为空');
    }
    final existing = await listTags();
    if (existing.any((t) => t.name.toLowerCase() == clean.toLowerCase())) {
      throw const AppError(AppErrorKind.validation, '标签已存在');
    }
    final id = _uuid.v4();
    final now = _now;
    await _db.into(_db.tags).insert(
          TagsCompanion.insert(id: id, name: clean, createdAt: Value(now)),
        );
    return Tag(id: id, name: clean, createdAt: now);
  }

  @override
  Future<void> deleteTag(String id) async {
    await (_db.delete(_db.tags)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<void> importOutline(String json) async {
    throw const AppError(AppErrorKind.config, 'V1 暂未开放大纲导入');
  }

  Future<List<KnowledgeNodeRow>> _loadRows() => _db.select(_db.knowledgeNodes).get();

  KnowledgeNodeRow _find(List<KnowledgeNodeRow> nodes, String id) {
    for (final node in nodes) {
      if (node.id == id) {
        return node;
      }
    }
    throw const AppError(AppErrorKind.validation, '知识点不存在');
  }

  void _ensureUniqueName(Iterable<KnowledgeNodeRow> siblings, String name) {
    if (siblings.any((n) => n.name.toLowerCase() == name.toLowerCase())) {
      throw const AppError(AppErrorKind.validation, '同级已存在同名节点');
    }
  }

  Set<String> _descendantsOf(List<KnowledgeNodeRow> nodes, String id) {
    final result = <String>{};
    var frontier = <String>{id};
    while (frontier.isNotEmpty) {
      final next = <String>{};
      for (final node in nodes) {
        if (node.parentId != null && frontier.contains(node.parentId)) {
          next.add(node.id);
        }
      }
      next.removeAll(result);
      result.addAll(next);
      frontier = next;
    }
    return result;
  }

  KnowledgeNode _mapNode(KnowledgeNodeRow row) => KnowledgeNode(
        id: row.id,
        parentId: row.parentId,
        level: row.level,
        name: row.name,
        sortOrder: row.sortOrder,
        isSystem: row.isSystem,
        isActive: row.isActive,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );
}
