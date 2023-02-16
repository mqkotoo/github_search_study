import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../domain/repository_data_model.dart';

final errorMessageProvider = Provider.autoDispose<String>((ref) => "");

class DataRepository {
  DataRepository({required this.client});

  final http.Client client;

  Future<RepositoryDataModel?> getData(String repositoryName) async {
    final apiUri = Uri.parse(
        'https://api.github.com/search/repositories?q=$repositoryName&per_page=20');
    http.Response response = await client.get(apiUri);
    //422 EMPTY
    switch (response.statusCode) {
      case 200:
        final jsonData = json.decode(response.body);
        return RepositoryDataModel.fromJson(jsonData);
      case 422:
        throw "Please Enter Text!";
      default:
        throw "error occurred!!";
    }
  }
}
