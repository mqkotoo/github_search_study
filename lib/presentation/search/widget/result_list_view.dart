import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../domain/repository_data_model.dart';
import '../../../generated/l10n.dart';
import '../../controller/controllers.dart';
import '../../detail/detail_page.dart';
import 'list_item.dart';
import 'loading_shimmer.dart';

class ResultListview extends ConsumerWidget {
  const ResultListview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //検索結果データ
    final repoData =
        ref.watch(searchResultProvider(ref.watch(inputRepoNameProvider)));
    //エラーメッセージ
    final errorMessage = ref.watch(errorMessageProvider);

    return Expanded(
      child: Column(
        children: <Widget>[
          // 結果がなかった時(errorMessageProviderを介していないので下のエラーと同時に表示される可能性がある)
          if (repoData.value != null &&
              (repoData.value!.totalCount == 0 ||
                  repoData.value!.totalCount == -1) &&
              errorMessage.isEmpty &&
              !repoData.isLoading)
            _noResultMessage(context, repoData),

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
                                builder: (context) =>
                                    DetailPage(repoData: data.items[index])),
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
                if (repoData.value != null &&
                    repoData.value!.totalCount != 0 &&
                    repoData.value!.totalCount != -1)
                  _resultCount(context, repoData),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _noResultMessage(
      BuildContext context, AsyncValue<RepositoryDataModel?> repoData) {
    if (repoData.value!.totalCount == 0) {
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: SafeArea(child: Text('${S.of(context).result}: 0')),
            ),
          ),
          const SizedBox(height: 30),
          errorComponent(
            context: context,
            errorIcon: Icons.search_off,
            errorTitle: S.of(context).noResult,
            errorDetail: S.of(context).noResultDetail,
          ),
        ],
      );
      //ユーザーの入力がない場合は結果-1を返しているのでその場合の処理
    } else if (repoData.value!.totalCount == -1) {
      return Column(
        children: <Widget>[
          const SizedBox(height: 30),
          Text(S.of(context).enterText),
        ],
      );
    } else {
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
    if (error == S.of(context).networkError) {
      return Column(
        children: <Widget>[
          const SizedBox(height: 30),
          errorComponent(
            context: context,
            errorIcon: Icons.wifi_off,
            errorTitle: S.of(context).networkError,
            errorDetail: S.of(context).networkErrorDetail,
          ),
        ],
      );
    } else {
      //ネットワーク以外のエラーはまとめて表示
      return Column(
        children: <Widget>[
          const SizedBox(height: 30),
          errorComponent(
            context: context,
            errorIcon: Icons.error_outline,
            errorTitle: S.of(context).errorOccurred,
            errorDetail: S.of(context).errorOccurredDetail,
          ),
        ],
      );
    }
  }

  //表示するエラーのかたまり
  Widget errorComponent(
      {required BuildContext context,
      required IconData errorIcon,
      required String errorTitle,
      required String errorDetail}) {
    return Column(
      children: <Widget>[
        Icon(errorIcon, size: 80),
        const SizedBox(height: 15),
        Text(
          errorTitle,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(errorDetail),
      ],
    );
  }
}
