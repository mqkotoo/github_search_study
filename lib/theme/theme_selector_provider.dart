import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_search_study/repository/providers/shared_preferences.dart';

// SharedPreferences保存用キー
const _themeKey = 'selectedThemeKey';

final themeSelectorProvider = StateNotifierProvider<ThemeSelector, ThemeMode>(
  ThemeSelector.new,
);

class ThemeSelector extends StateNotifier<ThemeMode> {
  ThemeSelector(this._ref) : super(ThemeMode.system) {
    // 記憶しているテーマがあれば取得して反映する。
    final themeIndex = _prefs.getInt(_themeKey);
    if (themeIndex == null) {
      return;
    }
    final themeMode = ThemeMode.values.firstWhere(
          (e) => e.index == themeIndex,
      orElse: () => ThemeMode.system,
    );
    state = themeMode;
  }

  final Ref _ref;

  // 選択したテーマを保存するためのローカル保存領域
  late final _prefs = _ref.read(sharedPreferencesProvider);

  // テーマの変更と保存
  Future<void> changeAndSave(ThemeMode theme) async {
    await _prefs.setInt(_themeKey, theme.index);
    state = theme;
  }
}