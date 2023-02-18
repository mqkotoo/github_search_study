import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:github_search_study/presentation/search_page.dart';
import 'package:github_search_study/repository/data_repository.dart';
import 'package:github_search_study/repository/providers/http_client.dart';
import 'package:github_search_study/repository/providers/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/theme/theme.dart';

final dataRepositoryProvider = Provider.autoDispose<DataRepository>((ref) {
  return DataRepository(client: ref.watch(httpClientProvider));
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      overrides: [
        // ここでインスタンス化し、Providerの値を上書きします
        sharedPreferencesProvider.overrideWithValue(
          await SharedPreferences.getInstance(),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
