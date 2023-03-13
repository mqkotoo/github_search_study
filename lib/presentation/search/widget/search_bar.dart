import 'package:flutter/material.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../generated/l10n.dart';
import '../../../repository/providers/connectivity.dart';
import '../../controller/controllers.dart';

final isClearButtonVisibleProvider =
    StateProvider.autoDispose<bool>((ref) => false);

class SearchBar extends ConsumerStatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  SearchBarState createState() => SearchBarState();
}

final textController = TextEditingController();

class SearchBarState extends ConsumerState<SearchBar> {
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //通信状況
    // final connectivity = ref.watch(connectivityProvider);

    return SafeArea(
      top: false,
      bottom: false,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              key: const Key('inputForm'),
              controller: textController,
              onChanged: (text) {
                ref
                    .read(isClearButtonVisibleProvider.notifier)
                    .update((state) => text.isNotEmpty);
              },

              //decoration
              decoration: InputDecoration(
                hintText: S.of(context).formHintText,
                prefixIcon:
                    const Icon(Icons.search, color: Colors.grey, size: 27),
                suffixIcon: ref.watch(isClearButtonVisibleProvider)
                    ? IconButton(
                        key: const Key('clearButton'),
                        icon: const Icon(Icons.clear, size: 27),
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

                // // エラーメッセージに値が入るかをエラー表示のフラグにしているから検索ごとに初期化
                // // android studioのバグなのか、refreshが使われていない判定になる
                // // ignore: unused_result
                // ref.refresh(errorMessageProvider);
                //
                // final connectivityResult =
                //     await connectivity.checkConnectivity();
                // //通信がなかったら何もその後の処理はせず、エラーを出す
                // if (connectivityResult == ConnectivityResult.none) {
                //   ref
                //       .read(errorMessageProvider.notifier)
                //       .update((state) => S.of(context).networkError);
                //   return;
                // }
                ref
                    .read(inputRepoNameProvider.notifier)
                    .update((state) => text);
              },
            ),
          ),
          MenuAnchor(
            alignmentOffset: const Offset(-120, 0),
            menuChildren: [
              radioMenuButton(
                  value: 'bestmatch', text: S.of(context).bestMatch),
              radioMenuButton(value: 'updated', text: S.of(context).updated),
              radioMenuButton(value: 'stars', text: S.of(context).stars),
              radioMenuButton(value: 'forks', text: S.of(context).forks),
              radioMenuButton(
                  value: 'help-wanted-issues',
                  text: S.of(context).helpWantedIssue),
            ],
            builder: (BuildContext context, MenuController controller,
                Widget? child) {
              return IconButton(
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                icon: const Icon(Icons.sort, size: 32),
              );
            },
          ),
        ],
      ),
    );
  }

  //RadioButton
  RadioMenuButton<String> radioMenuButton(
      {required String value, required String text}) {
    return RadioMenuButton(
      value: value,
      groupValue: ref.watch(sortStringProvider),
      onChanged: (value) =>
          ref.read(sortStringProvider.notifier).update((state) => value!),
      child: Text(text),
    );
  }
}
