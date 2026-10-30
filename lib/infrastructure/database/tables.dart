import 'package:drift/drift.dart';

/// 应用元数据（schema 版本镜像、安装标识、最近备份/恢复时间）。
@DataClassName('AppMetaRow')
class AppMeta extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  IntColumn get updatedAt => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {key};
}

/// 用户设置（类型化键值；API Key 不存这里）。
@DataClassName('SettingsRow')
class SettingsTable extends Table {
  TextColumn get key => text()();
  TextColumn get valueJson => text().withDefault(const Constant('null'))();
  IntColumn get updatedAt => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {key};
}

/// 知识点树：科目（level=1）→ 章节（level=2）→ 知识点（level=3）。
@DataClassName('KnowledgeNodeRow')
class KnowledgeNodes extends Table {
  TextColumn get id => text()();
  TextColumn get parentId =>
      text().nullable().references(KnowledgeNodes, #id)();
  IntColumn get level => integer()();
  TextColumn get name => text()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isSystem => boolean().withDefault(const Constant(false))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get createdAt => integer().withDefault(const Constant(0))();
  IntColumn get updatedAt => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// 自定义标签（独立于知识点体系）。
@DataClassName('TagRow')
class Tags extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get createdAt => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// 正式题目。
@DataClassName('QuestionRow')
class Questions extends Table {
  TextColumn get id => text()();
  TextColumn get promptLatex => text()();
  TextColumn get answerLatex => text().nullable()();
  TextColumn get solutionLatex => text().nullable()();
  TextColumn get hintLatex => text().nullable()();
  IntColumn get difficulty => integer().nullable()();
  TextColumn get sourceText => text().nullable()();
  TextColumn get errorReason => text().nullable()();
  BoolColumn get isStarred => boolean().withDefault(const Constant(false))();
  IntColumn get createdAt => integer().withDefault(const Constant(0))();
  IntColumn get updatedAt => integer().withDefault(const Constant(0))();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 题目 ↔ 知识点（多对多 + 关联权重）。
@DataClassName('QuestionKnowledgeRow')
class QuestionKnowledge extends Table {
  TextColumn get questionId =>
      text().references(Questions, #id, onDelete: KeyAction.cascade)();
  TextColumn get nodeId =>
      text().references(KnowledgeNodes, #id, onDelete: KeyAction.restrict)();
  RealColumn get relevance => real().withDefault(const Constant(1.0))();
  BoolColumn get isPrimary => boolean().withDefault(const Constant(false))();
  IntColumn get createdAt => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {questionId, nodeId};
}

/// 题目 ↔ 标签（多对多）。
@DataClassName('QuestionTagRow')
class QuestionTags extends Table {
  TextColumn get questionId =>
      text().references(Questions, #id, onDelete: KeyAction.cascade)();
  TextColumn get tagId =>
      text().references(Tags, #id, onDelete: KeyAction.cascade)();
  IntColumn get createdAt => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {questionId, tagId};
}

/// 图片资产（SHA-256 内容寻址，文件在 images/ 下）。
@DataClassName('ImageAssetRow')
class ImageAssets extends Table {
  TextColumn get sha256 => text()();
  TextColumn get relPath => text()();
  IntColumn get bytes => integer().withDefault(const Constant(0))();
  IntColumn get width => integer().nullable()();
  IntColumn get height => integer().nullable()();
  TextColumn get mime => text().withDefault(const Constant('image/jpeg'))();
  IntColumn get createdAt => integer().withDefault(const Constant(0))();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {sha256};
}

/// 题目 ↔ 图片（role: original/display/thumb）。
@DataClassName('QuestionImageRow')
class QuestionImages extends Table {
  TextColumn get questionId =>
      text().references(Questions, #id, onDelete: KeyAction.cascade)();
  TextColumn get sha256 =>
      text().references(ImageAssets, #sha256, onDelete: KeyAction.restrict)();
  TextColumn get role => text().withDefault(const Constant('original'))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  IntColumn get createdAt => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {questionId, sha256, role};
}

/// FSRS 复习卡（每题一张）。
@DataClassName('ReviewCardRow')
class ReviewCards extends Table {
  TextColumn get questionId =>
      text().references(Questions, #id, onDelete: KeyAction.cascade)();
  IntColumn get state => integer().withDefault(const Constant(1))();
  IntColumn get step => integer().nullable()();
  IntColumn get dueAt => integer().withDefault(const Constant(0))();
  RealColumn get stability => real().nullable()();
  RealColumn get difficulty => real().nullable()();
  IntColumn get elapsedDays => integer().withDefault(const Constant(0))();
  IntColumn get scheduledDays => integer().withDefault(const Constant(0))();
  IntColumn get reps => integer().withDefault(const Constant(0))();
  IntColumn get lapses => integer().withDefault(const Constant(0))();
  IntColumn get lastReviewAt => integer().nullable()();
  TextColumn get schedulerId => text().withDefault(const Constant('fsrs-6'))();
  TextColumn get paramsVersion => text().withDefault(const Constant('default-1'))();
  IntColumn get createdAt => integer().withDefault(const Constant(0))();
  IntColumn get updatedAt => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {questionId};
}

/// 复习日志（append-only；rating 为空表示跳过）。
@DataClassName('ReviewLogRow')
class ReviewLogs extends Table {
  TextColumn get id => text()();
  TextColumn get questionId =>
      text().references(Questions, #id, onDelete: KeyAction.cascade)();
  IntColumn get rating => integer().nullable()();
  IntColumn get reviewedAt => integer().withDefault(const Constant(0))();
  IntColumn get durationMs => integer().nullable()();
  BoolColumn get usedHint => boolean().withDefault(const Constant(false))();
  BoolColumn get viewedAnswer => boolean().withDefault(const Constant(false))();
  BoolColumn get independent => boolean().withDefault(const Constant(false))();
  TextColumn get kind => text().withDefault(const Constant('review'))();
  TextColumn get stuckNodeIdsJson => text().nullable()();
  TextColumn get errorType => text().nullable()();
  TextColumn get stateBeforeJson => text().nullable()();
  TextColumn get stateAfterJson => text().nullable()();
  TextColumn get schedulerId => text().nullable()();
  TextColumn get paramsVersion => text().nullable()();
  IntColumn get createdAt => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// 草稿（图级；一图可含多题）。
@DataClassName('DraftRow')
class Drafts extends Table {
  TextColumn get id => text()();
  TextColumn get source => text().withDefault(const Constant('camera'))();
  TextColumn get imageSha256 => text().nullable()();
  TextColumn get tempImagePath => text().nullable()();
  TextColumn get aiRawJson => text().nullable()();
  TextColumn get aiProvider => text().nullable()();
  TextColumn get aiModel => text().nullable()();
  TextColumn get aiPromptVersion => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('captured'))();
  TextColumn get errorCode => text().nullable()();
  IntColumn get createdAt => integer().withDefault(const Constant(0))();
  IntColumn get expiresAt => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// 草稿项（题级）。
@DataClassName('DraftItemRow')
class DraftItems extends Table {
  TextColumn get id => text()();
  TextColumn get draftId =>
      text().references(Drafts, #id, onDelete: KeyAction.cascade)();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  TextColumn get promptLatex => text().nullable()();
  TextColumn get answerLatex => text().nullable()();
  TextColumn get solutionLatex => text().nullable()();
  TextColumn get knowledgePointsJson => text().nullable()();
  RealColumn get confidence => real().nullable()();
  BoolColumn get isSelected => boolean().withDefault(const Constant(true))();
  TextColumn get createdQuestionId => text().nullable()();
  IntColumn get createdAt => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// 草稿项附件图（识别后可补充）。
@DataClassName('DraftItemImageRow')
class DraftItemImages extends Table {
  TextColumn get draftItemId =>
      text().references(DraftItems, #id, onDelete: KeyAction.cascade)();
  TextColumn get sha256 =>
      text().references(ImageAssets, #sha256, onDelete: KeyAction.restrict)();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  IntColumn get createdAt => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {draftItemId, sha256};
}

/// 知识点掌握度快照（可选缓存）。
@DataClassName('MasterySnapshotRow')
class MasterySnapshots extends Table {
  TextColumn get nodeId =>
      text().references(KnowledgeNodes, #id, onDelete: KeyAction.cascade)();
  RealColumn get score => real()();
  RealColumn get uncertainty => real()();
  IntColumn get evidenceCount => integer().withDefault(const Constant(0))();
  IntColumn get computedAt => integer().withDefault(const Constant(0))();
  TextColumn get watermarkLogId => text().nullable()();
  TextColumn get modelVersion => text().withDefault(const Constant('m1'))();

  @override
  Set<Column> get primaryKey => {nodeId};
}

/// 题级掌握度快照（可选缓存）。
@DataClassName('QuestionMasteryRow')
class QuestionMastery extends Table {
  TextColumn get questionId =>
      text().references(Questions, #id, onDelete: KeyAction.cascade)();
  RealColumn get score => real()();
  RealColumn get uncertainty => real()();
  IntColumn get computedAt => integer().withDefault(const Constant(0))();
  TextColumn get watermarkLogId => text().nullable()();

  @override
  Set<Column> get primaryKey => {questionId};
}
