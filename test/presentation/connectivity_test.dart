import 'package:flutter/material.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:github_search_study/main.dart';
import 'package:github_search_study/repository/providers/connectivity.dart';
import 'package:github_search_study/repository/providers/http_client.dart';
import '../repository/repository_mock_data.dart';
import '../repository/repository_mock_test.mocks.dart';
import 'connectivity_test.mocks.dart';

//通信テストできるように
@GenerateNiceMocks([MockSpec<Connectivity>()])
void main() {
  testWidgets('通信状態でなくて入力してエラーが返るか', (WidgetTester tester) async {
    const data = RepositoryMockData.jsonData;
    final mockClient = MockClient();
    when(mockClient.get(any)).thenAnswer((_) async => http.Response(data, 200));

// 通信状態をオフラインに設定します。
    final connectivityMock = MockConnectivity();
    when(connectivityMock.onConnectivityChanged)
        .thenAnswer((_) => Stream.value(ConnectivityResult.none));

    mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        ProviderScope(overrides: [
          httpClientProvider.overrideWithValue(mockClient),
          connectivityProvider.overrideWithValue(connectivityMock),
        ], child: const MyApp()),
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
