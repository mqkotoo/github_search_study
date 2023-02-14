import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'repository_data_model.freezed.dart';
part 'repository_data_model.g.dart';

@freezed
class RepositoryDataModel with _$RepositoryDataModel {
  const factory RepositoryDataModel({
    required int totalCount,
    required List<RepositoryDataItems> items,
  }) = _RepositoryDataModel;

  factory RepositoryDataModel.fromJson(Map<String, dynamic> json) =>
      _$RepositoryDataModelFromJson(json);
}

@freezed
class RepositoryDataItems with _$RepositoryDataItems {
  const factory RepositoryDataItems({
    required String fullName,
    required String? description,
    required String? avatarUrl,
    required String? language,
    required int stargazersCount,
    required int watchersCount,
    required int forksCount,
    required int openIssuesCount,
    required RepositoryDataOwner owner,
  }) = _RepositoryDataItems;

  factory RepositoryDataItems.fromJson(Map<String, dynamic> json) =>
      _$RepositoryDataItemsFromJson(json);
}

@freezed
class RepositoryDataOwner with _$RepositoryDataOwner {
  const factory RepositoryDataOwner({
    required String avatarUrl,
  }) = _RepositoryDataOwner;

  factory RepositoryDataOwner.fromJson(Map<String, dynamic> json) =>
      _$RepositoryDataOwnerFromJson(json);
}
