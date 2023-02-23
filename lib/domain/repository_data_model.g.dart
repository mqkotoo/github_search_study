// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RepositoryDataModel _$$_RepositoryDataModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_RepositoryDataModel',
      json,
      ($checkedConvert) {
        final val = _$_RepositoryDataModel(
          totalCount: $checkedConvert('total_count', (v) => v as int),
          items: $checkedConvert(
              'items',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      RepositoryDataItems.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'totalCount': 'total_count'},
    );

Map<String, dynamic> _$$_RepositoryDataModelToJson(
        _$_RepositoryDataModel instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'items': instance.items,
    };

_$_RepositoryDataItems _$$_RepositoryDataItemsFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_RepositoryDataItems',
      json,
      ($checkedConvert) {
        final val = _$_RepositoryDataItems(
          fullName: $checkedConvert('full_name', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String?),
          avatarUrl: $checkedConvert('avatar_url', (v) => v as String?),
          language: $checkedConvert('language', (v) => v as String?),
          stargazersCount: $checkedConvert('stargazers_count', (v) => v as int),
          watchersCount: $checkedConvert('watchers_count', (v) => v as int),
          forksCount: $checkedConvert('forks_count', (v) => v as int),
          openIssuesCount:
              $checkedConvert('open_issues_count', (v) => v as int),
          owner: $checkedConvert('owner',
              (v) => RepositoryDataOwner.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'fullName': 'full_name',
        'avatarUrl': 'avatar_url',
        'stargazersCount': 'stargazers_count',
        'watchersCount': 'watchers_count',
        'forksCount': 'forks_count',
        'openIssuesCount': 'open_issues_count'
      },
    );

Map<String, dynamic> _$$_RepositoryDataItemsToJson(
        _$_RepositoryDataItems instance) =>
    <String, dynamic>{
      'full_name': instance.fullName,
      'description': instance.description,
      'avatar_url': instance.avatarUrl,
      'language': instance.language,
      'stargazers_count': instance.stargazersCount,
      'watchers_count': instance.watchersCount,
      'forks_count': instance.forksCount,
      'open_issues_count': instance.openIssuesCount,
      'owner': instance.owner,
    };

_$_RepositoryDataOwner _$$_RepositoryDataOwnerFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_RepositoryDataOwner',
      json,
      ($checkedConvert) {
        final val = _$_RepositoryDataOwner(
          avatarUrl: $checkedConvert('avatar_url', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'avatarUrl': 'avatar_url'},
    );

Map<String, dynamic> _$$_RepositoryDataOwnerToJson(
        _$_RepositoryDataOwner instance) =>
    <String, dynamic>{
      'avatar_url': instance.avatarUrl,
    };
