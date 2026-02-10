// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'text_collection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TextCollection _$TextCollectionFromJson(Map<String, dynamic> json) {
  return _TextCollection.fromJson(json);
}

/// @nodoc
mixin _$TextCollection {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'cover_image_url')
  String? get coverImageUrl => throw _privateConstructorUsedError;
  int? get traditionId => throw _privateConstructorUsedError;
  int? get categoryId => throw _privateConstructorUsedError;
  int? get order => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this TextCollection to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TextCollection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TextCollectionCopyWith<TextCollection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TextCollectionCopyWith<$Res> {
  factory $TextCollectionCopyWith(
    TextCollection value,
    $Res Function(TextCollection) then,
  ) = _$TextCollectionCopyWithImpl<$Res, TextCollection>;
  @useResult
  $Res call({
    int id,
    String name,
    String slug,
    String? description,
    @JsonKey(name: 'cover_image_url') String? coverImageUrl,
    int? traditionId,
    int? categoryId,
    int? order,
    bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$TextCollectionCopyWithImpl<$Res, $Val extends TextCollection>
    implements $TextCollectionCopyWith<$Res> {
  _$TextCollectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TextCollection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? description = freezed,
    Object? coverImageUrl = freezed,
    Object? traditionId = freezed,
    Object? categoryId = freezed,
    Object? order = freezed,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            slug: null == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            coverImageUrl: freezed == coverImageUrl
                ? _value.coverImageUrl
                : coverImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            traditionId: freezed == traditionId
                ? _value.traditionId
                : traditionId // ignore: cast_nullable_to_non_nullable
                      as int?,
            categoryId: freezed == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as int?,
            order: freezed == order
                ? _value.order
                : order // ignore: cast_nullable_to_non_nullable
                      as int?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TextCollectionImplCopyWith<$Res>
    implements $TextCollectionCopyWith<$Res> {
  factory _$$TextCollectionImplCopyWith(
    _$TextCollectionImpl value,
    $Res Function(_$TextCollectionImpl) then,
  ) = __$$TextCollectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String slug,
    String? description,
    @JsonKey(name: 'cover_image_url') String? coverImageUrl,
    int? traditionId,
    int? categoryId,
    int? order,
    bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$TextCollectionImplCopyWithImpl<$Res>
    extends _$TextCollectionCopyWithImpl<$Res, _$TextCollectionImpl>
    implements _$$TextCollectionImplCopyWith<$Res> {
  __$$TextCollectionImplCopyWithImpl(
    _$TextCollectionImpl _value,
    $Res Function(_$TextCollectionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TextCollection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? description = freezed,
    Object? coverImageUrl = freezed,
    Object? traditionId = freezed,
    Object? categoryId = freezed,
    Object? order = freezed,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$TextCollectionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        slug: null == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        coverImageUrl: freezed == coverImageUrl
            ? _value.coverImageUrl
            : coverImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        traditionId: freezed == traditionId
            ? _value.traditionId
            : traditionId // ignore: cast_nullable_to_non_nullable
                  as int?,
        categoryId: freezed == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as int?,
        order: freezed == order
            ? _value.order
            : order // ignore: cast_nullable_to_non_nullable
                  as int?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TextCollectionImpl implements _TextCollection {
  const _$TextCollectionImpl({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    @JsonKey(name: 'cover_image_url') this.coverImageUrl,
    this.traditionId,
    this.categoryId,
    this.order,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory _$TextCollectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TextCollectionImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String slug;
  @override
  final String? description;
  @override
  @JsonKey(name: 'cover_image_url')
  final String? coverImageUrl;
  @override
  final int? traditionId;
  @override
  final int? categoryId;
  @override
  final int? order;
  @override
  final bool isActive;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'TextCollection(id: $id, name: $name, slug: $slug, description: $description, coverImageUrl: $coverImageUrl, traditionId: $traditionId, categoryId: $categoryId, order: $order, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TextCollectionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.coverImageUrl, coverImageUrl) ||
                other.coverImageUrl == coverImageUrl) &&
            (identical(other.traditionId, traditionId) ||
                other.traditionId == traditionId) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    slug,
    description,
    coverImageUrl,
    traditionId,
    categoryId,
    order,
    isActive,
    createdAt,
    updatedAt,
  );

  /// Create a copy of TextCollection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TextCollectionImplCopyWith<_$TextCollectionImpl> get copyWith =>
      __$$TextCollectionImplCopyWithImpl<_$TextCollectionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TextCollectionImplToJson(this);
  }
}

abstract class _TextCollection implements TextCollection {
  const factory _TextCollection({
    required final int id,
    required final String name,
    required final String slug,
    final String? description,
    @JsonKey(name: 'cover_image_url') final String? coverImageUrl,
    final int? traditionId,
    final int? categoryId,
    final int? order,
    required final bool isActive,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$TextCollectionImpl;

  factory _TextCollection.fromJson(Map<String, dynamic> json) =
      _$TextCollectionImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get slug;
  @override
  String? get description;
  @override
  @JsonKey(name: 'cover_image_url')
  String? get coverImageUrl;
  @override
  int? get traditionId;
  @override
  int? get categoryId;
  @override
  int? get order;
  @override
  bool get isActive;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of TextCollection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TextCollectionImplCopyWith<_$TextCollectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
