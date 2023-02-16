import 'dart:convert';

import 'package:http/http.dart' as http;

import '../domain/repository_data_model.dart';

class DataRepository {
  DataRepository({required this.client});

  final http.Client client;

  Future<RepositoryDataModel> getData(String repositoryName) async {
    final apiUri = Uri.parse(
        'https://api.github.com/search/repositories?q=$repositoryName');

    try{
      http.Response response = await client.get(apiUri);
      final jsonData = json.decode(response.body);
      return RepositoryDataModel.fromJson(jsonData);
    }catch(e){
      throw "error occurred 🥺";
    }
  }

}
