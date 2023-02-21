import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:github_search_study/generated/l10n.dart';
import 'package:github_search_study/presentation/search_page.dart';
import 'package:github_search_study/theme/shared_preferences.dart';

void main() {
  Widget myTestWidget(Locale locale) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      //多言語対応
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: locale,
      home: const SearchPage(),
    );
  }

  testWidgets('多言語対応のテスト 英語', (WidgetTester tester) async {
    mockNetworkImagesFor(() async {
      //日本語でアプリ起動
      await tester.pumpWidget(ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(
            await SharedPreferences.getInstance(),
          ),
        ],
        child: myTestWidget(const Locale('en')),
      ));
      //英語でアプリ起動
      await tester
          .pumpWidget(ProviderScope(child: myTestWidget(const Locale('en'))));

      await tester.pumpAndSettle();

      // 英語のテスト
      expect(find.text('GitHub Search'), findsOneWidget);
      expect(find.text('GitHubサーチ'), findsNothing);
    });
  });

  testWidgets("多言語対応のテスト 日本語", (WidgetTester tester) async {
    mockNetworkImagesFor(() async {
      //日本語でアプリ起動
      await tester.pumpWidget(ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(
            await SharedPreferences.getInstance(),
          ),
        ],
        child: myTestWidget(const Locale('ja')),
      ));
      await tester.pumpAndSettle();

      // 日本語のテスト
      expect(find.text('GitHubサーチ'), findsOneWidget);
      expect(find.text('GitHub Search'), findsOneWidget);
    });
  });
}
