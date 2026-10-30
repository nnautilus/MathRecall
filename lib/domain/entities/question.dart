/// 正式题目（列表/详情用）。
class Question {
  const Question({
    required this.id,
    required this.promptLatex,
    required this.answerLatex,
    required this.solutionLatex,
    required this.hintLatex,
    required this.difficulty,
    required this.sourceText,
    required this.errorReason,
    required this.isStarred,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    this.knowledgeNodeIds = const [],
    this.knowledgeNames = const [],
    this.tagNames = const [],
  });

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
  final List<String> knowledgeNodeIds;
  final List<String> knowledgeNames;
  final List<String> tagNames;

  bool get isDeleted => deletedAt != null;
}
