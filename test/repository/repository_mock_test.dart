import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
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

    final data = json.decode(RepositoryMockData.jsonData);

    final client = MockClient();
    when(client.get(any)).thenAnswer((_) async => http.Response(data,200));

    final dataRepository = DataRepository();
    final result = await dataRepository.getData("flutter");

    expect(result,{
      {
        'total_count': 483790,
        'items': [
          {
            'full_name': 'flutter/flutter',
            'description': 'Flutter makes it easy and fast to build beautiful apps for mobile and beyond',
            'avatar_url': null,
            'language': 'Dart',
            'stargazers_count': 150088,
            'watchers_count': 150088,
            'forks_count': 24628,
            'open_issues_count': 11582,
            'owner': {
              'avatar_url': 'https://avatars.githubusercontent.com/u/14101776?v=4'
            }
          }
        ]
      }
    });

  });
}