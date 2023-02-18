import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:github_search_study/presentation/search_page.dart';
import 'package:github_search_study/repository/data_repository.dart';
import 'package:github_search_study/repository/providers/http_client.dart';
import 'package:github_search_study/presentation/components/theme/theme.dart';

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
    return MaterialApp(
      theme: lightTheme,
      home: const SearchPage(),
    );
  }
}
