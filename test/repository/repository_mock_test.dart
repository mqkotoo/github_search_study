import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:github_search_study/domain/repository_data_model.dart';
import 'package:github_search_study/main.dart';
import 'package:github_search_study/repository/http_client.dart';
import '../repository/repository_mock_data.dart';
import 'repository_mock_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  test("getメソッドのテスト", () async {

    const data = RepositoryMockData.jsonData;

    final mockClient = MockClient();
    when(mockClient.get(any)).thenAnswer((_) async => http.Response(data, 200));

    final container = ProviderContainer(
      overrides: [
        httpClientProvider.overrideWithValue(mockClient)
      ],
    );

    //上でオーバーライドされたHTTPクライアントのインスタンスをみれてる
    final result = await container.read(dataRepositoryProvider).getData("flutter");

    expect(result, RepositoryDataModel.fromJson(jsonDecode(data) as Map<String,dynamic>));
  });

}
