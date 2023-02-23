import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      title: Text(
        S.of(context).searchPageTitle,
        key: const Key("searchAppBar"),
      ),
      //APPBARの右側
      actions: [
        Switch(
          //キャッシュされているモードがダークかで判定
          value: themeMode == ThemeMode.dark,
          activeColor: const Color(0xff64FFDA),
          onChanged: (value) {
            final themeSelector = ref.read(themeModeProvider.notifier);
            themeSelector.toggleThemeAndSave(value);
          },
        )
      ],
    );
  }
}
