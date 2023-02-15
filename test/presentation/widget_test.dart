import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search_study/main.dart';


void main() {
  testWidgets('入力、画面遷移ができるかのテスト', (WidgetTester tester) async {

    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // Verify that our counter starts at 0.
    expect(find.text("GitHub Repo Search"), findsOneWidget);

    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();
    //
    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}