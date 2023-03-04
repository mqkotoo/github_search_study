import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../generated/l10n.dart';
import '../../../theme/theme_mode_provider.dart';

class SearchAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //theme設定
    final themeMode = ref.watch(themeModeProvider);
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            S.of(context).searchPageTitle,
            key: const Key("searchAppBar"),
          ),
          FlutterSwitch(
            value: themeMode == ThemeMode.dark,
            onToggle: (value) {
              final themeSelector = ref.read(themeModeProvider.notifier);
              themeSelector.toggleThemeAndSave(value);
            },
            padding:0,
            toggleSize: 30,
            activeToggleColor: const Color(0xFF0D3B74),
            inactiveToggleColor: const Color(0xFFFFAB40),
            activeSwitchBorder: Border.all(
              color: const Color(0x42000000),
              width: 1,
            ),
            inactiveSwitchBorder: Border.all(
              color: const Color(0x42000000),
              width: 1,
            ),
            activeColor: const Color(0xFF365377),
            inactiveColor: const Color(0xFFFFE892),
            activeIcon: const Icon(
              Icons.nightlight_round,
              color: Colors.orangeAccent,
            ),
            inactiveIcon: const Icon(
              Icons.wb_sunny,
              color: Colors.white,
            ),
          )
        ]
      ),
    );
  }
}
