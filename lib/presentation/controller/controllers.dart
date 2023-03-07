import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:github_search_study/domain/repository_data_model.dart';
import '../../main.dart';

//入力された文字を管理する
final inputRepoNameProvider = StateProvider.autoDispose<String>((ref) => '');
//キャッチしたエラーメッセージを格納
final errorMessageProvider = StateProvider<String>((ref) => '');
//sortの文字列を格納
final sortStringProvider = StateProvider<String>((ref) => 'bestmatch');

final searchResultProvider =
    FutureProvider.autoDispose<RepositoryDataModel?>((ref) async {
  final inputText = ref.watch(inputRepoNameProvider);
  final sortString = ref.watch(sortStringProvider);

  //ユーザーの入力がない場合はtotal countを-1で返してview側で処理する
  if (inputText.isEmpty) {
    return RepositoryDataModel.empty;
  }

  final dataRepository = ref.watch(dataRepositoryProvider);
  return await dataRepository.getData(inputText, sortString).catchError((e) {
    ref.read(errorMessageProvider.notifier).update((state) => e.toString());
    return null;
  });
});
