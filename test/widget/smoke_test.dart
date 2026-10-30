import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mathrecall/app/app.dart';
import 'package:mathrecall/app/providers.dart';
import 'package:mathrecall/infrastructure/database/app_database.dart';

void main() {
  testWidgets('home shell renders five tabs', (tester) async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(db),
        ],
        child: const MathRecallApp(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('首页'), findsOneWidget);
    expect(find.text('错题本'), findsOneWidget);
    expect(find.text('复习'), findsOneWidget);
    expect(find.text('统计'), findsOneWidget);
    expect(find.text('设置'), findsOneWidget);
    expect(find.text('MathRecall'), findsOneWidget);
  });
}
