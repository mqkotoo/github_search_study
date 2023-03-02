import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../generated/l10n.dart';
import '../../../repository/providers/connectivity.dart';
import '../../controller/controllers.dart';

final isClearButtonVisibleProvider =
    StateProvider.autoDispose<bool>((ref) => false);

final textEditingControllerProvider =
    Provider<TextEditingController>((ref) => TextEditingController());

class SearchField extends ConsumerWidget {
  const SearchField({Key? key}) : super(key: key);

  // //テキストのコントローラ
  // final textController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //通信状況
    final connectivity = ref.watch(connectivityProvider);
    final textController = ref.watch(textEditingControllerProvider);

    //横画面の場合ノッチに隠れないようにする
    return SafeArea(
      top: false,
      bottom: false,
      child: TextFormField(
        key: const Key("inputForm"),
        controller: textController,
        onChanged: (text) {
          ref
              .read(isClearButtonVisibleProvider.notifier)
              .update((state) => text.isNotEmpty);
        },

        //decoration
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffixIcon: ref.watch(isClearButtonVisibleProvider)
              ? IconButton(
                  key: const Key("clearButton"),
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    textController.clear();
                    ref
                        .watch(isClearButtonVisibleProvider.notifier)
                        .update((state) => false);
                  },
                  color: Colors.grey)
              : const SizedBox.shrink(),
        ),

        //入力キーボードのdone→searchに変更
        textInputAction: TextInputAction.search,
        //search押したらデータ取得
        onFieldSubmitted: (text) async {
          // エラーメッセージに値が入るかをエラー表示のフラグにしているから検索ごとに初期化
          // android studioのバグなのか、refreshが使われていない判定になる
          // ignore: unused_result
          ref.refresh(errorMessageProvider);

          final connectivityResult = await connectivity.checkConnectivity();
          //通信がなかったら何もその後の処理はせず、エラーを出す
          if (connectivityResult == ConnectivityResult.none) {
            ref
                .read(errorMessageProvider.notifier)
                .update((state) => S.of(context).networkError);
            return;
          }
          ref.read(inputRepoNameProvider.notifier).update((state) => text);
        },
      ),
    );
  }
}
