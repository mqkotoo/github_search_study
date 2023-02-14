import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:github_search_study/domain/repository_data_model.dart';
import 'package:github_search_study/repository/data_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../repository/repository_mock_data.dart';
import 'repository_mock_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  test("getメソッドのテスト", () async {

    const data = RepositoryMockData.jsonData;

    final client = MockClient();
    when(client.get(any)).thenAnswer((_) async => http.Response(data, 200));

    //  DI setting
    GetIt.I.registerLazySingleton<http.Client>(() => client);

    final dataRepository = DataRepository();
    final result = await dataRepository.getData("flutter");

    expect(result, RepositoryDataModel.fromJson(jsonDecode(data) as Map<String,dynamic>));
  });

}
