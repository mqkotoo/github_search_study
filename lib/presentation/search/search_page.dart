import 'package:flutter/material.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_search_study/presentation/search/widget/search_app_bar.dart';
import 'package:intl/intl.dart';

import 'package:github_search_study/presentation/detail/detail_page.dart';
import 'package:github_search_study/repository/providers/connectivity.dart';
import 'widget/loading_shimmer.dart';
import '../../generated/l10n.dart';
import '../controller/controllers.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //検索結果データ
    final repoData =
        ref.watch(apiFamilyProvider(ref.watch(inputRepoNameProvider)));
    //テキストのコントローラ
    final textController = ref.read(textEditingControllerProvider);
    //クリアボタンの表示、非表示切り替え
    bool isClearVisible = ref.watch(isClearButtonVisibleProvider);
    //エラーメッセージ
    final errorMessage = ref.watch(errorMessageProvider);
    //通信状況
    final connectivity = ref.watch(connectivityProvider);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const SearchAppBar(),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              //search field 横画面だとIPHONEのノッチにかかるから対策
              child: TextFormField(
                key: const Key("inputForm"),
                controller: textController,
                onChanged: (text) {
                  ref
                      .read(isClearButtonVisibleProvider.notifier)
                      .update((state) => text.isNotEmpty);
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: isClearVisible
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
                //search押したらデータ取得 データ渡す
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
            const Divider(color: Colors.black12),

            // total count,メッセージ
            if (repoData.value != null && repoData.value!.totalCount != 0)
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(
                    "${S.of(context).result}: ${NumberFormat('#,##0').format(repoData.value?.totalCount)}",
                  ),
                ),
              ),

            //結果がなかった時(errorMessageProviderを介していないので下のエラーと同時に表示される可能性がある)
            if (repoData.value != null &&
                repoData.value!.totalCount == 0 &&
                errorMessage == "")
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text("${S.of(context).result}: 0"),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(S.of(context).noResult)
                ],
              ),

            //APIたたいてエラーがあれば表示
            if (errorMessage.isNotEmpty)
              returnErrorMessage(errorMessage, context),

            Expanded(
              // flex: 9,
              child: repoData.when(
                data: (data) => Scrollbar(
                  child: ListView.separated(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    itemCount: (repoData.valueOrNull?.items ?? []).length,
                    itemBuilder: (context, index) => _listItem(
                      context: context,
                      fullName: repoData.value!.items[index].fullName,
                      description: repoData.value!.items[index].description,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPage(
                                  repoData: repoData.value!.items[index])),
                        );
                      },
                    ),
                    separatorBuilder: (context, index) => const Divider(),
                  ),
                ),
                //上でハンドリングしているため、ここではつかわない
                error: (_, stack) => const SizedBox.shrink(),
                loading: () => const LoadingShimmer(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget returnErrorMessage(String error, BuildContext context) {
    if (error == "Please Enter Text!!") {
      return Column(
        children: [
          const SizedBox(height: 40),
          Text(S.of(context).enterText),
        ],
      );
    } else if (error == "Error Occurred!!") {
      return Column(
        children: [
          const SizedBox(height: 40),
          Text(S.of(context).errorOccurred),
        ],
      );
    } else {
      return Column(
        children: [
          const SizedBox(height: 40),
          Text(S.of(context).networkError),
        ],
      );
    }
  }

  Widget _listItem(
      {required String fullName,
      String? description,
      required BuildContext context,
      required void Function() onTap}) {
    return ListTile(
      onTap: onTap,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(fullName,
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 5,
          )
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            description ?? "No Description",
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}
