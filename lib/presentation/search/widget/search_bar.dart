import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
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

  //ソート要素の初期値
  String _selectedView = 'ベストマッチ';

  @override
  Widget build(BuildContext context) {
    //通信状況
    final connectivity = ref.watch(connectivityProvider);

    return SafeArea(
      top: false,
      bottom: false,
      child: Row(
        children: [
          Expanded(
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
                prefixIcon:
                    const Icon(Icons.search, color: Colors.grey, size: 27),
                suffixIcon: ref.watch(isClearButtonVisibleProvider)
                    ? IconButton(
                        key: const Key("clearButton"),
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
                // エラーメッセージに値が入るかをエラー表示のフラグにしているから検索ごとに初期化
                // android studioのバグなのか、refreshが使われていない判定になる
                // ignore: unused_result
                ref.refresh(errorMessageProvider);

                final connectivityResult =
                    await connectivity.checkConnectivity();
                //通信がなかったら何もその後の処理はせず、エラーを出す
                if (connectivityResult == ConnectivityResult.none) {
                  ref
                      .read(errorMessageProvider.notifier)
                      .update((state) => S.of(context).networkError);
                  return;
                }
                ref
                    .read(inputRepoNameProvider.notifier)
                    .update((state) => text);
              },
            ),
          ),
          //ソートのボタン
          PopupMenuButton(
            icon: const Icon(Icons.sort),
            iconSize: 32,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            onSelected: (value) {
              setState(() => _selectedView = value);
              //ソートを更新
              ref.read(sortStringProvider.notifier).update((state) => value);
            },
            itemBuilder: (_) => <CheckedPopupMenuItem>[
              CheckedPopupMenuItem(
                checked: _selectedView == 'ベストマッチ',
                value: 'ベストマッチ',
                child: elementText('ベストマッチ'),
              ),
              CheckedPopupMenuItem(
                checked: _selectedView == 'updated',
                value: 'updated',
                child: elementText('あたらいい順'),
              ),
              CheckedPopupMenuItem(
                checked: _selectedView == 'stars',
                value: 'stars',
                child: elementText('スター数'),
              ),
              CheckedPopupMenuItem(
                checked: _selectedView == 'forks',
                value: 'forks',
                child: elementText('フォーク数'),
              ),
              CheckedPopupMenuItem(
                checked: _selectedView == 'help-wanted-issues',
                value: 'help-wanted-issues',
                child: elementText(
                  '助けてイシュー数',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Text elementText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    );
  }
}
