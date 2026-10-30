/// 草稿状态机：captured → analyzing → ready/failed → confirmed；任意阶段可 discarded。
enum DraftStatus {
  captured,
  analyzing,
  ready,
  failed,
  confirmed,
  discarded;

  static DraftStatus fromDb(String value) {
    return DraftStatus.values.firstWhere(
      (status) => status.name == value,
      orElse: () => DraftStatus.captured,
    );
  }

  String get dbValue => name;

  bool get isOpen => this == captured || this == analyzing || this == ready || this == failed;
}

/// 图级草稿（一张图片可包含多道题）。
class Draft {
  const Draft({
    required this.id,
    required this.source,
    required this.status,
    required this.createdAt,
    this.imageSha256,
    this.imageRelPath,
    this.aiRawJson,
    this.aiProvider,
    this.aiModel,
    this.aiPromptVersion,
    this.errorCode,
    this.expiresAt = 0,
  });

  final String id;
  final String source;
  final DraftStatus status;
  final int createdAt;
  final String? imageSha256;
  final String? imageRelPath;
  final String? aiRawJson;
  final String? aiProvider;
  final String? aiModel;
  final String? aiPromptVersion;
  final String? errorCode;
  final int expiresAt;

  bool get isOpen => status.isOpen;
}

/// 题级草稿项。
class DraftItem {
  const DraftItem({
    required this.id,
    required this.draftId,
    required this.sortOrder,
    this.promptLatex,
    this.answerLatex,
    this.solutionLatex,
    this.knowledgePoints = const [],
    this.confidence,
    this.isSelected = true,
    this.createdQuestionId,
    this.imageSha256s = const [],
  });

  final String id;
  final String draftId;
  final int sortOrder;
  final String? promptLatex;
  final String? answerLatex;
  final String? solutionLatex;
  final List<String> knowledgePoints;
  final double? confidence;
  final bool isSelected;
  final String? createdQuestionId;
  final List<String> imageSha256s;

  DraftItem copyWith({
    String? promptLatex,
    String? answerLatex,
    String? solutionLatex,
    List<String>? knowledgePoints,
    double? confidence,
    bool? isSelected,
    String? createdQuestionId,
    List<String>? imageSha256s,
  }) {
    return DraftItem(
      id: id,
      draftId: draftId,
      sortOrder: sortOrder,
      promptLatex: promptLatex ?? this.promptLatex,
      answerLatex: answerLatex ?? this.answerLatex,
      solutionLatex: solutionLatex ?? this.solutionLatex,
      knowledgePoints: knowledgePoints ?? this.knowledgePoints,
      confidence: confidence ?? this.confidence,
      isSelected: isSelected ?? this.isSelected,
      createdQuestionId: createdQuestionId ?? this.createdQuestionId,
      imageSha256s: imageSha256s ?? this.imageSha256s,
    );
  }
}
