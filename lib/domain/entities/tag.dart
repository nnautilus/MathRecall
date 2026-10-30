/// 自定义标签（独立于知识点体系）。
class Tag {
  const Tag({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  final String id;
  final String name;
  final int createdAt;
}
