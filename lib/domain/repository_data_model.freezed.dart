// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'repository_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RepositoryDataModel _$RepositoryDataModelFromJson(Map<String, dynamic> json) {
  return _RepositoryDataModel.fromJson(json);
}

/// @nodoc
mixin _$RepositoryDataModel {
  int get totalCount => throw _privateConstructorUsedError;
  List<RepositoryDataItems> get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RepositoryDataModelCopyWith<RepositoryDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepositoryDataModelCopyWith<$Res> {
  factory $RepositoryDataModelCopyWith(
          RepositoryDataModel value, $Res Function(RepositoryDataModel) then) =
      _$RepositoryDataModelCopyWithImpl<$Res, RepositoryDataModel>;
  @useResult
  $Res call({int totalCount, List<RepositoryDataItems> items});
}

/// @nodoc
class _$RepositoryDataModelCopyWithImpl<$Res, $Val extends RepositoryDataModel>
    implements $RepositoryDataModelCopyWith<$Res> {
  _$RepositoryDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCount = null,
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<RepositoryDataItems>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RepositoryDataModelCopyWith<$Res>
    implements $RepositoryDataModelCopyWith<$Res> {
  factory _$$_RepositoryDataModelCopyWith(_$_RepositoryDataModel value,
          $Res Function(_$_RepositoryDataModel) then) =
      __$$_RepositoryDataModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int totalCount, List<RepositoryDataItems> items});
}

/// @nodoc
class __$$_RepositoryDataModelCopyWithImpl<$Res>
    extends _$RepositoryDataModelCopyWithImpl<$Res, _$_RepositoryDataModel>
    implements _$$_RepositoryDataModelCopyWith<$Res> {
  __$$_RepositoryDataModelCopyWithImpl(_$_RepositoryDataModel _value,
      $Res Function(_$_RepositoryDataModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCount = null,
    Object? items = null,
  }) {
    return _then(_$_RepositoryDataModel(
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<RepositoryDataItems>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RepositoryDataModel
    with DiagnosticableTreeMixin
    implements _RepositoryDataModel {
  const _$_RepositoryDataModel(
      {required this.totalCount,
      required final List<RepositoryDataItems> items})
      : _items = items;

  factory _$_RepositoryDataModel.fromJson(Map<String, dynamic> json) =>
      _$$_RepositoryDataModelFromJson(json);

  @override
  final int totalCount;
  final List<RepositoryDataItems> _items;
  @override
  List<RepositoryDataItems> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RepositoryDataModel(totalCount: $totalCount, items: $items)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RepositoryDataModel'))
      ..add(DiagnosticsProperty('totalCount', totalCount))
      ..add(DiagnosticsProperty('items', items));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RepositoryDataModel &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, totalCount, const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RepositoryDataModelCopyWith<_$_RepositoryDataModel> get copyWith =>
      __$$_RepositoryDataModelCopyWithImpl<_$_RepositoryDataModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RepositoryDataModelToJson(
      this,
    );
  }
}

abstract class _RepositoryDataModel implements RepositoryDataModel {
  const factory _RepositoryDataModel(
      {required final int totalCount,
      required final List<RepositoryDataItems> items}) = _$_RepositoryDataModel;

  factory _RepositoryDataModel.fromJson(Map<String, dynamic> json) =
      _$_RepositoryDataModel.fromJson;

  @override
  int get totalCount;
  @override
  List<RepositoryDataItems> get items;
  @override
  @JsonKey(ignore: true)
  _$$_RepositoryDataModelCopyWith<_$_RepositoryDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

RepositoryDataItems _$RepositoryDataItemsFromJson(Map<String, dynamic> json) {
  return _RepositoryDataItems.fromJson(json);
}

/// @nodoc
mixin _$RepositoryDataItems {
  String get fullName => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String? get language => throw _privateConstructorUsedError;
  int get stargazersCount => throw _privateConstructorUsedError;
  int get watchersCount => throw _privateConstructorUsedError;
  int get forksCount => throw _privateConstructorUsedError;
  int get openIssuesCount => throw _privateConstructorUsedError;
  RepositoryDataOwner get owner => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RepositoryDataItemsCopyWith<RepositoryDataItems> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepositoryDataItemsCopyWith<$Res> {
  factory $RepositoryDataItemsCopyWith(
          RepositoryDataItems value, $Res Function(RepositoryDataItems) then) =
      _$RepositoryDataItemsCopyWithImpl<$Res, RepositoryDataItems>;
  @useResult
  $Res call(
      {String fullName,
      String? description,
      String? avatarUrl,
      String? language,
      int stargazersCount,
      int watchersCount,
      int forksCount,
      int openIssuesCount,
      RepositoryDataOwner owner});

  $RepositoryDataOwnerCopyWith<$Res> get owner;
}

/// @nodoc
class _$RepositoryDataItemsCopyWithImpl<$Res, $Val extends RepositoryDataItems>
    implements $RepositoryDataItemsCopyWith<$Res> {
  _$RepositoryDataItemsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? description = freezed,
    Object? avatarUrl = freezed,
    Object? language = freezed,
    Object? stargazersCount = null,
    Object? watchersCount = null,
    Object? forksCount = null,
    Object? openIssuesCount = null,
    Object? owner = null,
  }) {
    return _then(_value.copyWith(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      stargazersCount: null == stargazersCount
          ? _value.stargazersCount
          : stargazersCount // ignore: cast_nullable_to_non_nullable
              as int,
      watchersCount: null == watchersCount
          ? _value.watchersCount
          : watchersCount // ignore: cast_nullable_to_non_nullable
              as int,
      forksCount: null == forksCount
          ? _value.forksCount
          : forksCount // ignore: cast_nullable_to_non_nullable
              as int,
      openIssuesCount: null == openIssuesCount
          ? _value.openIssuesCount
          : openIssuesCount // ignore: cast_nullable_to_non_nullable
              as int,
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as RepositoryDataOwner,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RepositoryDataOwnerCopyWith<$Res> get owner {
    return $RepositoryDataOwnerCopyWith<$Res>(_value.owner, (value) {
      return _then(_value.copyWith(owner: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_RepositoryDataItemsCopyWith<$Res>
    implements $RepositoryDataItemsCopyWith<$Res> {
  factory _$$_RepositoryDataItemsCopyWith(_$_RepositoryDataItems value,
          $Res Function(_$_RepositoryDataItems) then) =
      __$$_RepositoryDataItemsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String fullName,
      String? description,
      String? avatarUrl,
      String? language,
      int stargazersCount,
      int watchersCount,
      int forksCount,
      int openIssuesCount,
      RepositoryDataOwner owner});

  @override
  $RepositoryDataOwnerCopyWith<$Res> get owner;
}

/// @nodoc
class __$$_RepositoryDataItemsCopyWithImpl<$Res>
    extends _$RepositoryDataItemsCopyWithImpl<$Res, _$_RepositoryDataItems>
    implements _$$_RepositoryDataItemsCopyWith<$Res> {
  __$$_RepositoryDataItemsCopyWithImpl(_$_RepositoryDataItems _value,
      $Res Function(_$_RepositoryDataItems) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? description = freezed,
    Object? avatarUrl = freezed,
    Object? language = freezed,
    Object? stargazersCount = null,
    Object? watchersCount = null,
    Object? forksCount = null,
    Object? openIssuesCount = null,
    Object? owner = null,
  }) {
    return _then(_$_RepositoryDataItems(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      stargazersCount: null == stargazersCount
          ? _value.stargazersCount
          : stargazersCount // ignore: cast_nullable_to_non_nullable
              as int,
      watchersCount: null == watchersCount
          ? _value.watchersCount
          : watchersCount // ignore: cast_nullable_to_non_nullable
              as int,
      forksCount: null == forksCount
          ? _value.forksCount
          : forksCount // ignore: cast_nullable_to_non_nullable
              as int,
      openIssuesCount: null == openIssuesCount
          ? _value.openIssuesCount
          : openIssuesCount // ignore: cast_nullable_to_non_nullable
              as int,
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as RepositoryDataOwner,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RepositoryDataItems
    with DiagnosticableTreeMixin
    implements _RepositoryDataItems {
  const _$_RepositoryDataItems(
      {required this.fullName,
      required this.description,
      required this.avatarUrl,
      required this.language,
      required this.stargazersCount,
      required this.watchersCount,
      required this.forksCount,
      required this.openIssuesCount,
      required this.owner});

  factory _$_RepositoryDataItems.fromJson(Map<String, dynamic> json) =>
      _$$_RepositoryDataItemsFromJson(json);

  @override
  final String fullName;
  @override
  final String? description;
  @override
  final String? avatarUrl;
  @override
  final String? language;
  @override
  final int stargazersCount;
  @override
  final int watchersCount;
  @override
  final int forksCount;
  @override
  final int openIssuesCount;
  @override
  final RepositoryDataOwner owner;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RepositoryDataItems(fullName: $fullName, description: $description, avatarUrl: $avatarUrl, language: $language, stargazersCount: $stargazersCount, watchersCount: $watchersCount, forksCount: $forksCount, openIssuesCount: $openIssuesCount, owner: $owner)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RepositoryDataItems'))
      ..add(DiagnosticsProperty('fullName', fullName))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('avatarUrl', avatarUrl))
      ..add(DiagnosticsProperty('language', language))
      ..add(DiagnosticsProperty('stargazersCount', stargazersCount))
      ..add(DiagnosticsProperty('watchersCount', watchersCount))
      ..add(DiagnosticsProperty('forksCount', forksCount))
      ..add(DiagnosticsProperty('openIssuesCount', openIssuesCount))
      ..add(DiagnosticsProperty('owner', owner));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RepositoryDataItems &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.stargazersCount, stargazersCount) ||
                other.stargazersCount == stargazersCount) &&
            (identical(other.watchersCount, watchersCount) ||
                other.watchersCount == watchersCount) &&
            (identical(other.forksCount, forksCount) ||
                other.forksCount == forksCount) &&
            (identical(other.openIssuesCount, openIssuesCount) ||
                other.openIssuesCount == openIssuesCount) &&
            (identical(other.owner, owner) || other.owner == owner));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      fullName,
      description,
      avatarUrl,
      language,
      stargazersCount,
      watchersCount,
      forksCount,
      openIssuesCount,
      owner);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RepositoryDataItemsCopyWith<_$_RepositoryDataItems> get copyWith =>
      __$$_RepositoryDataItemsCopyWithImpl<_$_RepositoryDataItems>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RepositoryDataItemsToJson(
      this,
    );
  }
}

abstract class _RepositoryDataItems implements RepositoryDataItems {
  const factory _RepositoryDataItems(
      {required final String fullName,
      required final String? description,
      required final String? avatarUrl,
      required final String? language,
      required final int stargazersCount,
      required final int watchersCount,
      required final int forksCount,
      required final int openIssuesCount,
      required final RepositoryDataOwner owner}) = _$_RepositoryDataItems;

  factory _RepositoryDataItems.fromJson(Map<String, dynamic> json) =
      _$_RepositoryDataItems.fromJson;

  @override
  String get fullName;
  @override
  String? get description;
  @override
  String? get avatarUrl;
  @override
  String? get language;
  @override
  int get stargazersCount;
  @override
  int get watchersCount;
  @override
  int get forksCount;
  @override
  int get openIssuesCount;
  @override
  RepositoryDataOwner get owner;
  @override
  @JsonKey(ignore: true)
  _$$_RepositoryDataItemsCopyWith<_$_RepositoryDataItems> get copyWith =>
      throw _privateConstructorUsedError;
}

RepositoryDataOwner _$RepositoryDataOwnerFromJson(Map<String, dynamic> json) {
  return _RepositoryDataOwner.fromJson(json);
}

/// @nodoc
mixin _$RepositoryDataOwner {
  String get avatarUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RepositoryDataOwnerCopyWith<RepositoryDataOwner> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepositoryDataOwnerCopyWith<$Res> {
  factory $RepositoryDataOwnerCopyWith(
          RepositoryDataOwner value, $Res Function(RepositoryDataOwner) then) =
      _$RepositoryDataOwnerCopyWithImpl<$Res, RepositoryDataOwner>;
  @useResult
  $Res call({String avatarUrl});
}

/// @nodoc
class _$RepositoryDataOwnerCopyWithImpl<$Res, $Val extends RepositoryDataOwner>
    implements $RepositoryDataOwnerCopyWith<$Res> {
  _$RepositoryDataOwnerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? avatarUrl = null,
  }) {
    return _then(_value.copyWith(
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RepositoryDataOwnerCopyWith<$Res>
    implements $RepositoryDataOwnerCopyWith<$Res> {
  factory _$$_RepositoryDataOwnerCopyWith(_$_RepositoryDataOwner value,
          $Res Function(_$_RepositoryDataOwner) then) =
      __$$_RepositoryDataOwnerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String avatarUrl});
}

/// @nodoc
class __$$_RepositoryDataOwnerCopyWithImpl<$Res>
    extends _$RepositoryDataOwnerCopyWithImpl<$Res, _$_RepositoryDataOwner>
    implements _$$_RepositoryDataOwnerCopyWith<$Res> {
  __$$_RepositoryDataOwnerCopyWithImpl(_$_RepositoryDataOwner _value,
      $Res Function(_$_RepositoryDataOwner) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? avatarUrl = null,
  }) {
    return _then(_$_RepositoryDataOwner(
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RepositoryDataOwner
    with DiagnosticableTreeMixin
    implements _RepositoryDataOwner {
  const _$_RepositoryDataOwner({required this.avatarUrl});

  factory _$_RepositoryDataOwner.fromJson(Map<String, dynamic> json) =>
      _$$_RepositoryDataOwnerFromJson(json);

  @override
  final String avatarUrl;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RepositoryDataOwner(avatarUrl: $avatarUrl)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RepositoryDataOwner'))
      ..add(DiagnosticsProperty('avatarUrl', avatarUrl));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RepositoryDataOwner &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, avatarUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RepositoryDataOwnerCopyWith<_$_RepositoryDataOwner> get copyWith =>
      __$$_RepositoryDataOwnerCopyWithImpl<_$_RepositoryDataOwner>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RepositoryDataOwnerToJson(
      this,
    );
  }
}

abstract class _RepositoryDataOwner implements RepositoryDataOwner {
  const factory _RepositoryDataOwner({required final String avatarUrl}) =
      _$_RepositoryDataOwner;

  factory _RepositoryDataOwner.fromJson(Map<String, dynamic> json) =
      _$_RepositoryDataOwner.fromJson;

  @override
  String get avatarUrl;
  @override
  @JsonKey(ignore: true)
  _$$_RepositoryDataOwnerCopyWith<_$_RepositoryDataOwner> get copyWith =>
      throw _privateConstructorUsedError;
}
