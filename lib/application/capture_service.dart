import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

import '../core/errors/app_error.dart';
import '../domain/entities/draft.dart';
import '../domain/repositories/draft_repository.dart';
import '../domain/repositories/image_store.dart';

/// 录题应用服务：图片落盘 + AI 识别 + 草稿状态流转。
class CaptureService {
  CaptureService(this._drafts, this._images);

  final DraftRepository _drafts;
  final ImageStore _images;
  static const _uuid = Uuid();

  Future<Draft> createDraft(File file, {String source = 'camera'}) async {
    final stored = await _images.storeFile(file);
    return _drafts.createFromImage(
      imageSha256: stored.sha256,
      imageRelPath: stored.relPath,
      source: source,
    );
  }

  Future<Draft> analyze(
    Draft draft,
    AiVisionProvider provider, {
    List<int>? imageBytes,
    String? userHint,
    List<String> knowledgePaths = const [],
  }) async {
    final relPath = draft.imageRelPath;
    if (relPath == null && imageBytes == null) {
      throw const AppError(AppErrorKind.validation, '草稿缺少图片');
    }
    final file = relPath == null ? null : _images.resolve(relPath);
    if (imageBytes == null && (file == null || !file.existsSync())) {
      throw const AppError(AppErrorKind.storage, '草稿图片文件缺失');
    }
    await _drafts.markAnalyzing(
      draft.id,
      provider: provider.providerName,
      model: provider.model,
      promptVersion: provider.promptVersion,
    );
    try {
      final bytes = imageBytes ?? await file!.readAsBytes();
      final result = await provider.analyzeImage(
        bytes: bytes is Uint8List ? bytes : Uint8List.fromList(bytes),
        mime: imageBytes != null ? 'image/png' : _mimeOf(relPath!),
        userHint: userHint,
        knowledgePaths: knowledgePaths,
      );
      final items = <DraftItem>[
        for (var index = 0; index < result.questions.length; index++)
          DraftItem(
            id: _uuid.v4(),
            draftId: draft.id,
            sortOrder: index,
            promptLatex: result.questions[index].promptLatex,
            answerLatex: result.questions[index].answerLatex,
            solutionLatex: result.questions[index].solutionLatex,
            knowledgePoints: result.questions[index].knowledgePoints,
            confidence: result.questions[index].confidence,
          ),
      ];
      await _drafts.markReady(draft.id, result, items);
      final updated = await _drafts.findById(draft.id);
      return updated ?? draft;
    } on AppError catch (error) {
      await _drafts.markFailed(draft.id, error.kind.name);
      rethrow;
    }
  }

  Future<List<String>> confirm(String draftId, {Set<String>? selected}) {
    return _drafts.confirm(draftId, selectedItemIds: selected);
  }

  Future<void> discard(String draftId) => _drafts.discard(draftId);

  String _mimeOf(String relPath) {
    return switch (p.extension(relPath).toLowerCase()) {
      '.png' => 'image/png',
      '.webp' => 'image/webp',
      '.heic' => 'image/heic',
      _ => 'image/jpeg',
    };
  }
}
