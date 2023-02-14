import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../domain/repository_data_model.dart';

class DataRepository{
  
  Future<RepositoryDataModel> getData(String repositoryName) async{

    //get it 使ってhttpクライアント設定
    final http.Client client = GetIt.I<http.Client>();

    final apiUri = Uri.parse('https://api.github.com/search/repositories?q=$repositoryName');

    http.Response response = await client.get(apiUri);

    if(response.statusCode != 200) {
      throw Exception("No repository data: $repositoryName");
    }

    final jsonData = json.decode(response.body);

    return RepositoryDataModel.fromJson(jsonData);
  }
  
}