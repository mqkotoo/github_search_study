import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search_study/domain/repository_data_model.dart';

import 'mock_data.dart';

void main() {
  test("fromJson", () async {
    final data = json.decode(MockData.jsonData);
    final RepositoryDataModel result = RepositoryDataModel.fromJson(data);

    expect(result.totalCount, 40);
    expect(result.items.length, 1);

    expect(result.items[0].language, "Assembly");
    expect(result.items[0].fullName, "dtrupenn/Tetris");
  });
}