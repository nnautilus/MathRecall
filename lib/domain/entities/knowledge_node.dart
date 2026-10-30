/// 知识点树节点：科目（level=1）→ 章节（level=2）→ 知识点（level=3）。
class KnowledgeNode {
  const KnowledgeNode({
    required this.id,
    required this.parentId,
    required this.level,
    required this.name,
    required this.sortOrder,
    required this.isSystem,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String? parentId;
  final int level;
  final String name;
  final int sortOrder;
  final bool isSystem;
  final bool isActive;
  final int createdAt;
  final int updatedAt;
}
