import 'package:flutter/material.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:github_search_study/presentation/detail/detail_page.dart';
import 'package:github_search_study/presentation/search/widget/list_item.dart';
import 'package:github_search_study/presentation/search/widget/search_app_bar.dart';
import 'package:github_search_study/presentation/search/widget/search_field.dart';
import 'package:github_search_study/repository/providers/connectivity.dart';
import '../../domain/repository_data_model.dart';
import '../../generated/l10n.dart';
import '../controller/controllers.dart';
import 'widget/loading_shimmer.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //検索結果データ
    final repoData =
        ref.watch(searchResultProvider);
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              //search field
              child: SearchField(
                textController: textController,
                //textが何かあったらクリアボタンを表示する
                onChanged: (text) {
                  ref
                      .read(isClearButtonVisibleProvider.notifier)
                      .update((state) => text.isNotEmpty);
                },
                isClearVisible: isClearVisible,
                onPressClearButton: () {
                  textController.clear();
                  ref
                      .watch(isClearButtonVisibleProvider.notifier)
                      .update((state) => false);
                },
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
                  print(ref.read(inputRepoNameProvider));
                },
              ),
            ),
            const Divider(),

            // 結果がなかった時(errorMessageProviderを介していないので下のエラーと同時に表示される可能性がある)
            if (repoData.value != null
                && (repoData.value!.totalCount == 0
                    || repoData.value!.totalCount == -1)
                && errorMessage == ""
                && !repoData.isLoading)
              _noResultMessage(context,repoData),

            //APIたたいてエラーがあれば表示
            if (errorMessage.isNotEmpty)
              _displayErrorMessage(errorMessage, context),


            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: <Widget>[
                  repoData.maybeWhen(
                    data: (data) => Scrollbar(
                      child: ListView.separated(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount: (data?.items ?? []).length,
                        itemBuilder: (context, index) => ListItem(
                          fullName: data!.items[index].fullName,
                          description: data.items[index].description,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                      repoData: data.items[index])),
                            );
                          },
                        ),
                        separatorBuilder: (context, index) => const Divider(),
                      ),
                    ),
                    //ロード処理
                    orElse: () => const LoadingShimmer(),
                  ),
                  //検索結果がある場合は件数を右上に表示する（リストの表示範囲を狭めないために右上に重ねる）
                  // total count,メッセージ
                  if (repoData.value != null
                      && repoData.value!.totalCount != 0
                      && repoData.value!.totalCount != -1)
                    _resultCount(context, repoData),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _noResultMessage(
      BuildContext context,
      AsyncValue<RepositoryDataModel?> repoData) {
    if(repoData.value!.totalCount == 0) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: SafeArea(child: Text("${S.of(context).result}: 0")),
            ),
          ),
          const SizedBox(height: 30),
          Text(S.of(context).noResult)
        ],
      );
      //ユーザーの入力がない場合は結果-1を返しているのでその場合の処理
    }else if(repoData.value!.totalCount == -1){
      return Column(
        children: [
          const SizedBox(height: 30),
          Text(S.of(context).enterText),
        ],
      );
    }
    else{
      return const SizedBox.shrink();
    }

  }

  Widget _resultCount(
      BuildContext context, AsyncValue<RepositoryDataModel?> repoData) {
    //横画面の場合ノッチに隠れないようにする
    return Positioned(
      top: 0,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          top: false,
          left: false,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                "${S.of(context).result}: ${NumberFormat('#,##0').format(repoData.value?.totalCount)}",
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _displayErrorMessage(String error, BuildContext context) {
     if (error == "Error Occurred!!") {
      return Column(
        children: [
          const SizedBox(height: 30),
          Text(S.of(context).errorOccurred),
        ],
      );
      //network error
    }else if(error == S.of(context).networkError) {
       return Column(
         children: [
           const SizedBox(height: 30),
           Text(S.of(context).networkError),
         ],
       );
     }
     else{
       return const SizedBox.shrink();
     }
  }
}
