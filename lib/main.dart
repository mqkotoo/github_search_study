import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:github_search_study/view/search_page.dart';
import 'package:http/http.dart' as http;

void main() {

  //DI setting
  GetIt.I.registerLazySingleton<http.Client>(() => http.Client());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SearchPage(),
    );
  }
}