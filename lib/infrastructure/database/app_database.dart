import 'package:drift/drift.dart';

import 'tables.dart';

part 'app_database.g.dart';

/// MathRecall 本地数据库（schema v4）。
///
/// 设计约定：
/// - 主键使用 UUID（TEXT），时间为 UTC 毫秒（INTEGER）。
/// - 草稿与正式题分离；复习日志 append-only。
/// - 外键默认开启；迁移必须可测试。
@DriftDatabase(
  tables: [
    AppMeta,
    SettingsTable,
    KnowledgeNodes,
    Tags,
    Questions,
    QuestionKnowledge,
    QuestionTags,
    ImageAssets,
    QuestionImages,
    ReviewCards,
    ReviewLogs,
    Drafts,
    DraftItems,
    DraftItemImages,
    MasterySnapshots,
    QuestionMastery,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(drafts, drafts.imageSha256);
            await m.addColumn(drafts, drafts.aiProvider);
            await m.addColumn(drafts, drafts.aiModel);
            await m.addColumn(drafts, drafts.aiPromptVersion);
          }
          if (from < 3) {
            await m.addColumn(reviewCards, reviewCards.step);
          }
          if (from < 4) {
            await m.createTable(draftItemImages);
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  /// 首页指标：错题总数（不含软删除）。
  Future<int> countQuestions() async {
    final count = questions.id.count();
    final query = selectOnly(questions)
      ..addColumns([count])
      ..where(questions.deletedAt.isNull());
    final row = await query.getSingle();
    return row.read(count) ?? 0;
  }

  /// 首页指标：今日待复习数量（排除已软删除题目）。
  Future<int> countDue(int nowUtcMs) async {
    final count = reviewCards.questionId.count();
    final query = selectOnly(reviewCards).join([
      innerJoin(questions, questions.id.equalsExp(reviewCards.questionId)),
    ])
      ..addColumns([count])
      ..where(reviewCards.dueAt.isSmallerOrEqualValue(nowUtcMs))
      ..where(questions.deletedAt.isNull());
    final row = await query.getSingle();
    return row.read(count) ?? 0;
  }
}
