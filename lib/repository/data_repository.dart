// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import '../domain/repository_data_model.dart';

class DataRepository {
  DataRepository({required this.client});

  final http.Client client;

  Future<RepositoryDataModel> getData(String repositoryName) async {
    final apiUri = Uri.parse(
        'https://api.github.com/search/repositories?q=$repositoryName');

    http.Response response = await client.get(apiUri);

    if (response.statusCode != 200) {
      throw Exception("Status Code: ${response.statusCode}");
    }

    final jsonData = json.decode(response.body);

    return RepositoryDataModel.fromJson(jsonData);
  }
}
