import 'package:flutter/material.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:github_search_study/presentation/detail_page.dart';
import 'package:github_search_study/repository/providers/connectivity.dart';
import '../components/color/app_color.dart';
import '../components/widget/loading_shimmer.dart';
import '../theme/theme_selector_provider.dart';
import 'controller/controllers.dart';

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
    //theme設定
    final themeMode = ref.watch(themeModeProvider);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "GitHub Repo Search",
            key: Key("searchAppBar"),
          ),
          //APPBARの右側
          actions: [
            Switch(
              //キャッシュされているモードがダークかで判定
              value: themeMode == ThemeMode.dark,
              activeColor: const Color(0xff3f51b5),
              onChanged: (value) {
                final themeSelector = ref.read(themeModeProvider.notifier);
                themeSelector.toggleThemeAndSave(value);
              },
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              //search field
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
                  final connectivityResult =
                      await connectivity.checkConnectivity();
                  //通信がなかったら何もその後の処理はせず、エラーを出す
                  if (connectivityResult == ConnectivityResult.none) {
                    ref
                        .read(errorMessageProvider.notifier)
                        .update((state) => "Network Error!!");
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
              //resultをカンマ区切りで表示
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(
                    "result: ${NumberFormat('#,##0').format(repoData.value?.totalCount)}",
                  ),
                ),
              ),

            if (repoData.value != null && repoData.value!.totalCount == 0)
              //この場合は「見つかりませんでした」みたいな
              Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text("result: 0"),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text("not found search result!")
                ],
              ),

            if (errorMessage.isNotEmpty)
              Column(
                children: [
                  const SizedBox(height: 40),
                  Text(errorMessage.toString()),
                ],
              ),

            Expanded(
              flex: 8,
              child: repoData.when(
                data: (data) => Scrollbar(
                  child: ListView.separated(
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
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? AppColor.lightDescriptionColor
                  : AppColor.darkDescriptionColor,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}
