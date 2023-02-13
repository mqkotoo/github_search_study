// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RepositoryDataModel _$$_RepositoryDataModelFromJson(
        Map<String, dynamic> json) =>
    _$_RepositoryDataModel(
      totalCount: json['totalCount'] as int,
      items: (json['items'] as List<dynamic>)
          .map((e) => RepositoryDataItems.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_RepositoryDataModelToJson(
        _$_RepositoryDataModel instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'items': instance.items,
    };

_$_RepositoryDataItems _$$_RepositoryDataItemsFromJson(
        Map<String, dynamic> json) =>
    _$_RepositoryDataItems(
      fullName: json['fullName'] as String,
      description: json['description'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      language: json['language'] as String?,
      stargazersCount: json['stargazersCount'] as int,
      watchersCount: json['watchersCount'] as int,
      forksCount: json['forksCount'] as int,
      openIssuesCount: json['openIssuesCount'] as int,
      owner:
          RepositoryDataOwner.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_RepositoryDataItemsToJson(
        _$_RepositoryDataItems instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'description': instance.description,
      'avatarUrl': instance.avatarUrl,
      'language': instance.language,
      'stargazersCount': instance.stargazersCount,
      'watchersCount': instance.watchersCount,
      'forksCount': instance.forksCount,
      'openIssuesCount': instance.openIssuesCount,
      'owner': instance.owner,
    };

_$_RepositoryDataOwner _$$_RepositoryDataOwnerFromJson(
        Map<String, dynamic> json) =>
    _$_RepositoryDataOwner(
      avatarUrl: json['avatarUrl'] as String,
    );

Map<String, dynamic> _$$_RepositoryDataOwnerToJson(
        _$_RepositoryDataOwner instance) =>
    <String, dynamic>{
      'avatarUrl': instance.avatarUrl,
    };
