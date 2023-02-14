import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:github_search_study/repository/data_repository.dart';
import 'package:github_search_study/repository/http_client.dart';
import 'package:github_search_study/view/search_page.dart';

final dataRepositoryProvider = Provider.autoDispose<DataRepository>((ref) {
  return DataRepository(client: ref.watch(httpClientProvider));
});

void main() {
  runApp(const ProviderScope(child: MyApp()));
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
