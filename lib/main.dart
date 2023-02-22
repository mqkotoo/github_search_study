import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:github_search_study/presentation/search/search_page.dart';
import 'package:github_search_study/repository/data_repository.dart';
import 'package:github_search_study/repository/providers/http_client.dart';
import 'package:github_search_study/theme/shared_preferences.dart';
import 'package:github_search_study/theme/theme.dart';
import 'package:github_search_study/theme/theme_mode_provider.dart';
import 'generated/l10n.dart';

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
      //theme setting
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ref.watch(themeModeProvider),
      //localization setting
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,

      home: const SearchPage(),
    );
  }
}
