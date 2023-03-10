import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:github_search_study/main.dart';
import 'package:github_search_study/repository/providers/http_client.dart';
import 'package:github_search_study/theme/shared_preferences.dart';
import '../repository/repository_mock_data.dart';
import '../repository/repository_mock_test.mocks.dart';

void main() {
  testWidgets('入力、画面遷移ができるかのテスト', (WidgetTester tester) async {
    const data = RepositoryMockData.jsonData;
    final mockClient = MockClient();
    when(mockClient.get(any)).thenAnswer((_) async => http.Response(data, 200));

    mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        ProviderScope(overrides: [
          httpClientProvider.overrideWithValue(mockClient),
          // sharedPreferencesインスタンス化
          //ここではsharedPreferencesのテストはしないのでモックにしていない
          sharedPreferencesProvider.overrideWithValue(
            await SharedPreferences.getInstance(),
          ),
        ], child: const MyApp()),
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

      //flutterと入力して検索する
      await tester.enterText(formField, 'flutter');
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

  testWidgets('空文字を入力してエラーが返るか', (WidgetTester tester) async {
    const data = RepositoryMockData.jsonData;
    final mockClient = MockClient();
    //空文字を送信するとリクエストはせず、エラーメッセージを表示する
    when(mockClient.get(any)).thenAnswer((_) async => http.Response(data, 200));

    mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        ProviderScope(overrides: [
          httpClientProvider.overrideWithValue(mockClient),
          // sharedPreferencesインスタンス化
          //ここではsharedPreferencesのテストはしないのでモックにしていない
          sharedPreferencesProvider.overrideWithValue(
            await SharedPreferences.getInstance(),
          ),
        ], child: const MyApp()),
      );

      final formField = find.byKey(const ValueKey('inputForm'));

      //""と入力して検索する
      await tester.enterText(formField, '');
      await tester.tap(formField);
      await tester.testTextInput.receiveAction(TextInputAction.search);

      await tester.pumpAndSettle();

      //エラーが返ってくる
      final target = find.text('Please Enter Text!');
      expect(target, findsOneWidget);
    });
  });
}
