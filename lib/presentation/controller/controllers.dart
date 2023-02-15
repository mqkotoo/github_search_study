import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_search_study/domain/repository_data_model.dart';

import '../../main.dart';

final inputRepoNameProvider = StateProvider<String>((ref) => "");

final apiFamilyProvider = FutureProvider.autoDispose
    .family<RepositoryDataModel, String>((ref, repoName) async {

  final dataRepository = ref.watch(dataRepositoryProvider);

  return await dataRepository.getData(repoName);
});
