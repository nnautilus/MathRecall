import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/knowledge_node.dart';
import '../domain/entities/tag.dart';
import '../domain/repositories/knowledge_repository.dart';
import '../infrastructure/repositories/knowledge_repository_impl.dart';
import 'providers.dart';

final knowledgeRepositoryProvider = Provider<KnowledgeRepository>(
  (ref) => KnowledgeRepositoryImpl(ref.watch(databaseProvider)),
);

final knowledgeTreeProvider = FutureProvider<List<KnowledgeNode>>(
  (ref) => ref.watch(knowledgeRepositoryProvider).loadTree(),
);

final tagsProvider = FutureProvider<List<Tag>>(
  (ref) => ref.watch(knowledgeRepositoryProvider).listTags(),
);
