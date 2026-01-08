// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tradition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Tradition _$TraditionFromJson(Map<String, dynamic> json) {
  return _Tradition.fromJson(json);
}

/// @nodoc
mixin _$Tradition {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  int? get languageId => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Tradition to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Tradition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TraditionCopyWith<Tradition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TraditionCopyWith<$Res> {
  factory $TraditionCopyWith(Tradition value, $Res Function(Tradition) then) =
      _$TraditionCopyWithImpl<$Res, Tradition>;
  @useResult
  $Res call({
    int id,
    String name,
    String slug,
    String? description,
    String? imageUrl,
    bool isActive,
    int? languageId,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$TraditionCopyWithImpl<$Res, $Val extends Tradition>
    implements $TraditionCopyWith<$Res> {
  _$TraditionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Tradition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? isActive = null,
    Object? languageId = freezed,
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
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            languageId: freezed == languageId
                ? _value.languageId
                : languageId // ignore: cast_nullable_to_non_nullable
                      as int?,
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
abstract class _$$TraditionImplCopyWith<$Res>
    implements $TraditionCopyWith<$Res> {
  factory _$$TraditionImplCopyWith(
    _$TraditionImpl value,
    $Res Function(_$TraditionImpl) then,
  ) = __$$TraditionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String slug,
    String? description,
    String? imageUrl,
    bool isActive,
    int? languageId,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$TraditionImplCopyWithImpl<$Res>
    extends _$TraditionCopyWithImpl<$Res, _$TraditionImpl>
    implements _$$TraditionImplCopyWith<$Res> {
  __$$TraditionImplCopyWithImpl(
    _$TraditionImpl _value,
    $Res Function(_$TraditionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Tradition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? isActive = null,
    Object? languageId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$TraditionImpl(
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
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        languageId: freezed == languageId
            ? _value.languageId
            : languageId // ignore: cast_nullable_to_non_nullable
                  as int?,
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
class _$TraditionImpl implements _Tradition {
  const _$TraditionImpl({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    this.imageUrl,
    required this.isActive,
    this.languageId,
    this.createdAt,
    this.updatedAt,
  });

  factory _$TraditionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TraditionImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String slug;
  @override
  final String? description;
  @override
  final String? imageUrl;
  @override
  final bool isActive;
  @override
  final int? languageId;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Tradition(id: $id, name: $name, slug: $slug, description: $description, imageUrl: $imageUrl, isActive: $isActive, languageId: $languageId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TraditionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.languageId, languageId) ||
                other.languageId == languageId) &&
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
    imageUrl,
    isActive,
    languageId,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Tradition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TraditionImplCopyWith<_$TraditionImpl> get copyWith =>
      __$$TraditionImplCopyWithImpl<_$TraditionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TraditionImplToJson(this);
  }
}

abstract class _Tradition implements Tradition {
  const factory _Tradition({
    required final int id,
    required final String name,
    required final String slug,
    final String? description,
    final String? imageUrl,
    required final bool isActive,
    final int? languageId,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$TraditionImpl;

  factory _Tradition.fromJson(Map<String, dynamic> json) =
      _$TraditionImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get slug;
  @override
  String? get description;
  @override
  String? get imageUrl;
  @override
  bool get isActive;
  @override
  int? get languageId;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Tradition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TraditionImplCopyWith<_$TraditionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
