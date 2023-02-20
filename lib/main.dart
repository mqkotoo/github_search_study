import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:github_search_study/presentation/search_page.dart';
import 'package:github_search_study/repository/data_repository.dart';
import 'package:github_search_study/repository/providers/http_client.dart';
import 'package:github_search_study/theme/shared_preferences.dart';
import 'package:github_search_study/theme/theme.dart';
import 'package:github_search_study/theme/theme_selector_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


final dataRepositoryProvider = Provider.autoDispose<DataRepository>((ref) {
  return DataRepository(client: ref.watch(httpClientProvider));
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      overrides: [
        // sharedPreferencesインスタンス化
        sharedPreferencesProvider.overrideWithValue(
          await SharedPreferences.getInstance(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ref.watch(themeModeProvider),
      home: const SearchPage(),
    );
  }
}
