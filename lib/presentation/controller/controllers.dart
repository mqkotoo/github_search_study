// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:github_search_study/domain/repository_data_model.dart';
import '../../main.dart';

//入力された文字を管理する
final inputRepoNameProvider = StateProvider<String>((ref) => "");

final textEditingControllerProvider =
    Provider<TextEditingController>((ref) => TextEditingController());

final isClearButtonVisibleProvider = StateProvider<bool>((ref) => false);

final apiFamilyProvider = FutureProvider.autoDispose
    .family<RepositoryDataModel, String>((ref, repoName) async {
  final dataRepository = ref.watch(dataRepositoryProvider);

  return await dataRepository.getData(repoName);
});
