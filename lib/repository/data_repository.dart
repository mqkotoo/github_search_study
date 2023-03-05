import 'dart:convert';

import 'package:http/http.dart' as http;

import '../domain/repository_data_model.dart';

class DataRepository {
  DataRepository({required this.client});

  final http.Client client;

  Future<RepositoryDataModel?> getData(String repositoryName) async {

      final apiUri = Uri.parse(
          'https://api.github.com/search/repositories?q=$repositoryName&per_page=50');
      http.Response response = await client.get(apiUri);

      if(response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return RepositoryDataModel.fromJson(jsonData);
      }else {
        throw "Error Occurred!!";
      }

  }
}
