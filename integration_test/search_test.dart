import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search_study/generated/l10n.dart';
import 'package:github_search_study/presentation/search/search_page.dart';
import 'package:github_search_study/repository/providers/http_client.dart';
import 'package:github_search_study/theme/shared_preferences.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../test/repository/repository_mock_data.dart';
import '../test/repository/repository_mock_test.mocks.dart';
import 'package:http/http.dart' as http;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  //英語でのWIDGETテストなので英語設定のアプリを使ってテストする
  Widget myTestWidget() {
    return MaterialApp(
      //多言語対応
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      //言語を英語に設定する
      locale: const Locale('en'),
      home: const SearchPage(),
    );
  }

  testWidgets('検索と画面遷移の統合テスト', (tester) async {
    const data = RepositoryMockData.jsonData;
    final mockClient = MockClient();
    when(mockClient.get(any)).thenAnswer((_) async => http.Response(data, 200));

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        ProviderScope(overrides: [
          httpClientProvider.overrideWithValue(mockClient),
          // sharedPreferencesインスタンス化
          sharedPreferencesProvider.overrideWithValue(
            await SharedPreferences.getInstance(),
          ),
        ], child: myTestWidget()),
      );

      expect(find.byKey(const Key('searchAppBar')), findsOneWidget);

      final formField = find.byKey(const ValueKey('inputForm'));

      //textfieldに文字が入力できるか
      await tester.enterText(formField, 'こんにちは');
      expect(find.text('こんにちは'), findsOneWidget);

      await tester.pumpAndSettle();

      //文字を消す
      final clearButton = find.byKey(const ValueKey('clearButton'));
      await tester.tap(clearButton);
      expect(find.text('こんにちは'), findsNothing);

      //flutterと入力して1番上のをタップする
      await tester.enterText(formField, 'flutter');
      //検索ボタンを押す
      await tester.tap(formField);
      await tester.testTextInput.receiveAction(TextInputAction.search);

      await tester.pumpAndSettle();

      //リストが描画される
      final tapTarget = find.textContaining('flutter/flutter');
      expect(find.textContaining('result'), findsOneWidget);
      //リストをタップ
      await tester.tap(tapTarget);
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('detailAppBar')), findsOneWidget);
      expect(find.text('Fork'), findsOneWidget);
    });
  });
}
