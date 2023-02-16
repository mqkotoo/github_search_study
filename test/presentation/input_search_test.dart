import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search_study/repository/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:github_search_study/main.dart';
import 'package:github_search_study/repository/http_client.dart';
import '../repository/repository_mock_data.dart';
import '../repository/repository_mock_test.mocks.dart';
import 'connectivity_mock.dart';

void main() {
  testWidgets('入力、画面遷移ができるかのテスト', (WidgetTester tester) async {
    const data = RepositoryMockData.jsonData;
    final mockClient = MockClient();
    when(mockClient.get(any)).thenAnswer((_) async => http.Response(data, 200));

    mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        ProviderScope(
            overrides: [httpClientProvider.overrideWithValue(mockClient)],
            child: const MyApp()),
      );

      expect(find.byKey(const Key("searchAppBar")), findsOneWidget);

      final formField = find.byKey(const ValueKey("inputForm"));

      //textfieldに文字が入力できるか
      await tester.enterText(formField, "こんにちは");
      expect(find.text('こんにちは'), findsOneWidget);

      await tester.pumpAndSettle();

      //文字を消す
      final clearButton = find.byKey(const ValueKey("clearButton"));
      await tester.tap(clearButton);
      expect(find.text('こんにちは'), findsNothing);

      //flutterと入力して1番上のをタップする
      await tester.enterText(formField, "flutter");
      //検索ボタンを押す
      await tester.tap(formField);
      await tester.testTextInput.receiveAction(TextInputAction.search);

      await tester.pumpAndSettle();

      //リストが描画される
      final tapTarget = find.textContaining("flutter/flutter");
      expect(find.textContaining("result"), findsOneWidget);
      //リストをタップ
      await tester.tap(tapTarget);
      await tester.pumpAndSettle();
      expect(find.byKey(const Key("detailAppBar")), findsOneWidget);
      expect(find.text("Fork"), findsOneWidget);
    });
  });

  testWidgets('空文字を入力してエラーが返るか', (WidgetTester tester) async {
    const data = RepositoryMockData.jsonData;
    final mockClient = MockClient();
    //空文字を送信すると422が返ってくる
    when(mockClient.get(any)).thenAnswer((_) async => http.Response(data, 422));

    mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        ProviderScope(
            overrides: [httpClientProvider.overrideWithValue(mockClient)],
            child: const MyApp()),
      );

      final formField = find.byKey(const ValueKey("inputForm"));

      //""と入力して1番上のをタップする
      await tester.enterText(formField, "");
      //検索ボタンを押す
      await tester.tap(formField);
      await tester.testTextInput.receiveAction(TextInputAction.search);

      await tester.pumpAndSettle();

      //エラーが返ってくる
      final target = find.text("Please Enter Text!");
      expect(target, findsOneWidget);
    });
  });

  testWidgets('通信状態でなくて入力してエラーが返るか', (WidgetTester tester) async {

    const data = RepositoryMockData.jsonData;
    final mockClient = MockClient();
    when(mockClient.get(any)).thenAnswer((_) async => http.Response(data, 200));

    // 通信状態をオフラインに設定します。
    final connectivityMock = ConnectivityMock();
    connectivityMock.connectivityStreamController.add(ConnectivityResult.none);

    mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        ProviderScope(
            overrides: [
              httpClientProvider.overrideWithValue(mockClient),
              connectivityProvider.overrideWithProvider(
                FutureProvider.autoDispose((ref) => Future.value(ConnectivityResult.none)),
              ),
            ],
            child: const MyApp()),
      );

      final formField = find.byKey(const ValueKey("inputForm"));

      //"flutter"と入力して1番上のをタップする
      await tester.enterText(formField, "flutter");
      //検索ボタンを押す
      await tester.tap(formField);
      await tester.testTextInput.receiveAction(TextInputAction.search);

      await tester.pumpAndSettle();

      expect(find.textContaining("flutter/flutter"), findsOneWidget);

      //想定エラー文
      final target = find.text("Network Error!!");
      expect(target, findsNothing);

    });
  });


}
