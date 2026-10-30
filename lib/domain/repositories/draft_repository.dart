import 'dart:typed_data';

import '../entities/ai_draft.dart';
import '../entities/draft.dart';
import '../entities/knowledge_match.dart';

/// 草稿数据访问端口。
abstract interface class DraftRepository {
  Future<Draft> createFromImage({
    required String imageSha256,
    required String imageRelPath,
    required String source,
  });

  Future<Draft?> findById(String id);

  Future<List<DraftItem>> itemsOf(String draftId);

  Future<void> markAnalyzing(
    String draftId, {
    required String provider,
    required String model,
    required String promptVersion,
  });

  Future<void> markReady(
    String draftId,
    AiDraftResult result,
    List<DraftItem> items,
  );

  Future<void> markFailed(String draftId, String errorCode);

  /// 保存校对后的草稿项（保留 id；新项自动生成 id）。
  Future<List<DraftItem>> saveItems(String draftId, List<DraftItem> items);

  /// 给草稿项附加一张图片（内容寻址 sha256）。
  Future<void> addItemImage(String itemId, String sha256);

  Future<void> removeItemImage(String itemId, String sha256);

  /// 把 AI 输出的知识点路径/名称匹配到现有三级知识点。
  Future<KnowledgeMatchResult> matchKnowledgePoints(List<String> candidates);

  /// 批量确认入库，返回新建题目 id（按草稿项顺序）。
  Future<List<String>> confirm(
    String draftId, {
    Set<String>? selectedItemIds,
  });

  Future<void> discard(String draftId);

  /// 清理过期草稿，返回删除数量。
  Future<int> cleanupExpired(int nowMs);
}

/// AI 视觉识别端口。
abstract interface class AiVisionProvider {
  String get providerName;

  String get model;

  String get promptVersion;

  Future<AiDraftResult> analyzeImage({
    required Uint8List bytes,
    required String mime,
    String? userHint,
    List<String> knowledgePaths = const [],
  });
}
