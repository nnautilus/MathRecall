import '../entities/question.dart';

/// 正式题库的数据访问接口（领域层端口）。
abstract interface class QuestionRepository {
  Future<List<Question>> list({
    String keyword = '',
    bool onlyStarred = false,
    bool includeDeleted = false,
    String? knowledgeNodeId,
  });

  Future<Question?> findById(String id);

  /// 最近录入的题目（按创建时间倒序）。
  Future<List<Question>> recent({int limit = 3});

  Future<String> create({
    required String promptLatex,
    String? answerLatex,
    String? solutionLatex,
    String? hintLatex,
    int? difficulty,
    String? sourceText,
    List<String> knowledgeNodeIds = const [],
    List<String> tagIds = const [],
  });

  Future<void> update({
    required String id,
    required String promptLatex,
    String? answerLatex,
    String? solutionLatex,
    String? hintLatex,
    int? difficulty,
    String? sourceText,
  });

  Future<void> setKnowledge(String questionId, List<String> nodeIds);

  Future<void> setStarred(String id, bool starred);

  Future<void> setStarredMany(List<String> ids, bool starred);

  Future<void> softDelete(String id);

  Future<void> softDeleteMany(List<String> ids);

  Future<void> restore(String id);

  Future<void> restoreMany(List<String> ids);

  /// 彻底删除（不可恢复），返回实际删除数量。
  Future<int> purgeMany(List<String> ids);

  Future<int> count();
}
