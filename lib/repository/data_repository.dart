import 'dart:convert';
import 'package:http/http.dart' as http;

import '../domain/repository_data_model.dart';

class DataRepository{
  
  Future<RepositoryDataModel> getData(String repositoryName) async{
    final apiUri = Uri.parse('https://api.github.com/search/repositories?q=$repositoryName');

    http.Response response = await http.get(apiUri);

    if(response.statusCode != 200) {
      throw Exception("No repository data: $repositoryName");
    }

    final jsonData = json.decode(response.body);
    print(json.encode(RepositoryDataModel.fromJson(jsonData)));

    return RepositoryDataModel.fromJson(jsonData);
  }
  
}