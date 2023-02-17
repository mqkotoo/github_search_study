import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../domain/repository_data_model.dart';

class DataRepository {
  DataRepository({required this.client});

  final http.Client client;

  Future<RepositoryDataModel?> getData(String repositoryName) async {
    try {
      final apiUri = Uri.parse(
          'https://api.github.com/search/repositories?q=$repositoryName&per_page=40');
      http.Response response = await client.get(apiUri);

      switch (response.statusCode) {
        case 200:
          final jsonData = json.decode(response.body);

          return RepositoryDataModel.fromJson(jsonData);
        case 422:
          throw "Please Enter Text!";
        default:
          throw "error occurred!!";
      }
    } on SocketException catch (_) {
      throw "Network Error!!";
    }
  }
}
