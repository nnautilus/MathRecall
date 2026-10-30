import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../application/capture_service.dart';
import '../core/errors/app_error.dart';
import '../domain/repositories/draft_repository.dart';
import '../domain/repositories/image_store.dart';
import '../infrastructure/ai/ai_config.dart';
import '../infrastructure/ai/openai_compatible_provider.dart';
import '../infrastructure/media/image_storage.dart';
import '../infrastructure/repositories/draft_repository_impl.dart';
import 'providers.dart';

/// 图片存储（启动时清理临时/孤儿文件）。
final imageStorageProvider = FutureProvider<ImageStore>((ref) async {
  final db = ref.watch(databaseProvider);
  final support = await getApplicationSupportDirectory();
  final storage = ImageStorage(support, db);
  await storage.cleanup();
  return storage;
});

final draftRepositoryProvider = Provider<DraftRepository>(
  (ref) => DraftRepositoryImpl(ref.watch(databaseProvider)),
);

final captureServiceProvider = FutureProvider<CaptureService>((ref) async {
  final images = await ref.watch(imageStorageProvider.future);
  return CaptureService(ref.watch(draftRepositoryProvider), images);
});

final aiConfigStoreProvider = Provider<AiConfigStore>(
  (ref) => AiConfigStore(ref.watch(databaseProvider)),
);

final aiConfigProvider = FutureProvider<AiConfig>(
  (ref) => ref.watch(aiConfigStoreProvider).load(),
);

final aiVisionProviderProvider = FutureProvider<AiVisionProvider>((ref) async {
  final config = await ref.watch(aiConfigProvider.future);
  if (!config.isConfigured) {
    throw const AppError(AppErrorKind.config, 'AI 未配置');
  }
  return OpenAiCompatibleProvider(config);
});
