import 'package:flutter/material.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:github_search_study/presentation/detail_page.dart';
import 'package:github_search_study/repository/connectivity.dart';
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

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        backgroundColor: const Color(0xffFCFDF6),
        appBar: AppBar(
          backgroundColor: const Color(0xffFCFDF6),
          elevation: 0,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: const Text(
            "GitHub Repo Search",
            key: Key("searchAppBar"),
          ),
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
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
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
                  fillColor: const Color(0xffe1eedf),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
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
            (() {
              if (repoData.value != null && repoData.value!.totalCount != 0) {
                //resultをカンマ区切りで表示
                String totalCount =
                    NumberFormat('#,##0').format(repoData.value!.totalCount);
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text("result: $totalCount"),
                  ),
                );
              }
              if (repoData.value != null && repoData.value!.totalCount == 0) {
                //この場合は「見つかりませんでした」みたいな
                return Column(
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
                );
              } else {
                return const SizedBox.shrink();
              }
            })(),

            errorMessage.isNotEmpty
                ? Column(
                    children: [
                      const SizedBox(height: 40),
                      Text(errorMessage.toString()),
                    ],
                  )
                : Expanded(
                    flex: 8,
                    child: ListView.separated(
                      itemCount: (repoData.valueOrNull?.items ?? []).length,
                      itemBuilder: (context, index) => _listItem(
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
                      separatorBuilder: (context, index) => const Divider(
                        color: Color(0xffBBBBBB),
                      ),
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
