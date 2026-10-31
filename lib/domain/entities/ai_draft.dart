/// AI 识别出的单题结果。
class AiQuestionDraft {
  const AiQuestionDraft({
    required this.promptLatex,
    this.answerLatex,
    this.solutionLatex,
    this.knowledgePoints = const [],
    this.suggestedKnowledgePoints = const [],
    this.confidence,
  });

  final String promptLatex;
  final String? answerLatex;
  final String? solutionLatex;
  final List<String> knowledgePoints;
  final List<String> suggestedKnowledgePoints;
  final double? confidence;
}

/// AI 识别整张图片的结果。
class AiDraftResult {
  const AiDraftResult({
    required this.questions,
    required this.rawJson,
    this.provider,
    this.model,
    this.promptVersion = 'v1',
  });

  final List<AiQuestionDraft> questions;
  final String rawJson;
  final String? provider;
  final String? model;
  final String promptVersion;
}
