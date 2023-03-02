import 'dart:math';

import 'package:flutter/material.dart';

import 'package:device_preview/device_preview.dart';
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
      child: DevicePreview(
        enabled: false,
        builder: (context) => const MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      //device_preview setting
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      //デバイスで”文字を大きくする”の設定に関する記述
      builder: (BuildContext context, Widget? child) {
        final MediaQueryData data = MediaQuery.of(context);
        //textScaleの上限を指定
        double textScaleLimit() {
          if(data.size.width <= 320) {
            return 1.3;
          }else if(data.size.width <= 375){
            return 1.4;
          }else{
            return 1.5;
          }
        }
        return MediaQuery(
          //min()どちらか小さい方を適用するようにして上限を設ける
          data: data.copyWith(
            textScaleFactor: min(textScaleLimit(), data.textScaleFactor),
          ),
          //device_preview setting
          child: DevicePreview.appBuilder(context,child),
        );
      },
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
