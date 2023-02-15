import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_search_study/domain/repository_data_model.dart';
import 'package:github_search_study/repository/data_repository.dart';

import '../../main.dart';

final inputRepoNameProvider = StateProvider<String>((ref) => "");

final apiFamilyProvider = FutureProvider.autoDispose
    .family<RepositoryDataModel, String>((ref, repoName) async {
  //リポジトリのデータがない状態の時は、空のものとしてデータを返す
  // if (!logic.willProceed(repositoryData)) {
  //   return RepositoryData.empty;
  // }
  final dataRepository = ref.watch(dataRepositoryProvider);

  return await dataRepository.getData(repoName);
});
