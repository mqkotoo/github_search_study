import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:github_search_study/domain/repository_data_model.dart';
import '../../main.dart';


//入力された文字を管理する
final inputRepoNameProvider = StateProvider.autoDispose<String>((ref) => "");
//キャッチしたエラーメッセージを格納
final errorMessageProvider = StateProvider.autoDispose<String>((ref) => "");
//

final textEditingControllerProvider =
    Provider<TextEditingController>((ref) => TextEditingController());

final isClearButtonVisibleProvider = StateProvider<bool>((ref) => false);

final apiFamilyProvider = FutureProvider.autoDispose
    .family<RepositoryDataModel?, String>((ref, repoName) async {

      if(repoName.isEmpty){
        return null;
      }

  final dataRepository = ref.watch(dataRepositoryProvider);
  return await dataRepository.getData(repoName).catchError((e) {
    ref.read(errorMessageProvider.notifier).update((state) => e.toString());
  });
});

