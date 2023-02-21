import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:github_search_study/theme/shared_preferences.dart';
import 'package:github_search_study/theme/theme_mode_provider.dart';

void main() {
  group("themeに関するテスト", () {
    late ProviderContainer container;
    // SharedPreferences保存用キー
    const isDarkThemeKey = 'selectedThemeKey';

    setUp(() => () {
          return Future(() async {
            SharedPreferences.setMockInitialValues({});
            container = ProviderContainer(overrides: [
              sharedPreferencesProvider.overrideWithValue(
                await SharedPreferences.getInstance(),
              ),
            ]);
          });
        });

    tearDown(() => () {
          container.dispose();
        });

    test("初期状態でテーマモードが端末のシステム依存であること", () async {
      SharedPreferences.setMockInitialValues({});
      container = ProviderContainer(overrides: [
        sharedPreferencesProvider.overrideWithValue(
          await SharedPreferences.getInstance(),
        ),
      ]);
      final themeMode = container.read(themeModeProvider);
      expect(themeMode, ThemeMode.system);
    });

    test("テーマが記憶されていたら、そのテーマモードになっていること", () async {
      const isDark = false;
      //テーマモードをライトモードに設定
      SharedPreferences.setMockInitialValues({isDarkThemeKey: isDark});

      container = ProviderContainer(overrides: [
        sharedPreferencesProvider.overrideWithValue(
          await SharedPreferences.getInstance(),
        ),
      ]);

      final themeMode = container.read(themeModeProvider);
      expect(themeMode, ThemeMode.light);
    });

    test("darkテーマに切り替え、テーマモードの保存ができていること", () async {
      final themeNotifier = container.read(themeModeProvider.notifier);
      //toggle theme method →isDarkにtrueを入れてダークモードに変更
      await themeNotifier.toggleThemeAndSave(true);
      //themeNotifier.debugState　→　container.read(themeModeProvider); と同義
      //テーマが切り替わっていることのテスト
      expect(themeNotifier.debugState, ThemeMode.dark);

      //テーマを管理しているBOOLが保存されているかのテスト
      final prefs = container.read(sharedPreferencesProvider);
      final theme = prefs.getBool(isDarkThemeKey);
      expect(theme, true);
    });
  });
}
