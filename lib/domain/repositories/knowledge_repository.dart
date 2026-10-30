import '../entities/knowledge_node.dart';
import '../entities/tag.dart';

/// 知识点与标签的数据访问接口（领域层端口）。
abstract interface class KnowledgeRepository {
  Future<List<KnowledgeNode>> loadTree();

  Future<KnowledgeNode> createNode({String? parentId, required String name});

  Future<void> renameNode(String id, String name);

  Future<void> moveNode(String id, String? newParentId);

  Future<void> setActive(String id, bool active);

  Future<List<Tag>> listTags();

  Future<Tag> createTag(String name);

  Future<void> deleteTag(String id);

  /// V1 仅保留接口：不预置大纲数据，后续版本实现导入。
  Future<void> importOutline(String json);
}
