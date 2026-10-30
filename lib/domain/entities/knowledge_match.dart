/// 知识点候选匹配结果（用于 AI 路径字符串解析）。
class KnowledgeMatchResult {
  const KnowledgeMatchResult({
    this.matched = const {},
    this.unmatched = const [],
    this.ambiguous = const [],
  });

  /// 原始候选字符串 → 知识点 id。
  final Map<String, String> matched;

  /// 无法匹配的候选。
  final List<String> unmatched;

  /// 同名多节点、无法唯一确定的候选。
  final List<String> ambiguous;

  bool get hasIssues => unmatched.isNotEmpty || ambiguous.isNotEmpty;
}
