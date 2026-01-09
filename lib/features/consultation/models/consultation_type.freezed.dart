// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'consultation_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ConsultationType _$ConsultationTypeFromJson(Map<String, dynamic> json) {
  return _ConsultationType.fromJson(json);
}

/// @nodoc
mixin _$ConsultationType {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration_minutes')
  int get durationMinutes => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError; // cents
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this ConsultationType to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConsultationType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConsultationTypeCopyWith<ConsultationType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConsultationTypeCopyWith<$Res> {
  factory $ConsultationTypeCopyWith(
    ConsultationType value,
    $Res Function(ConsultationType) then,
  ) = _$ConsultationTypeCopyWithImpl<$Res, ConsultationType>;
  @useResult
  $Res call({
    int id,
    String name,
    String? description,
    @JsonKey(name: 'duration_minutes') int durationMinutes,
    int price,
    @JsonKey(name: 'image_url') String? imageUrl,
  });
}

/// @nodoc
class _$ConsultationTypeCopyWithImpl<$Res, $Val extends ConsultationType>
    implements $ConsultationTypeCopyWith<$Res> {
  _$ConsultationTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConsultationType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? durationMinutes = null,
    Object? price = null,
    Object? imageUrl = freezed,
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
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            durationMinutes: null == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as int,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConsultationTypeImplCopyWith<$Res>
    implements $ConsultationTypeCopyWith<$Res> {
  factory _$$ConsultationTypeImplCopyWith(
    _$ConsultationTypeImpl value,
    $Res Function(_$ConsultationTypeImpl) then,
  ) = __$$ConsultationTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String? description,
    @JsonKey(name: 'duration_minutes') int durationMinutes,
    int price,
    @JsonKey(name: 'image_url') String? imageUrl,
  });
}

/// @nodoc
class __$$ConsultationTypeImplCopyWithImpl<$Res>
    extends _$ConsultationTypeCopyWithImpl<$Res, _$ConsultationTypeImpl>
    implements _$$ConsultationTypeImplCopyWith<$Res> {
  __$$ConsultationTypeImplCopyWithImpl(
    _$ConsultationTypeImpl _value,
    $Res Function(_$ConsultationTypeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConsultationType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? durationMinutes = null,
    Object? price = null,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _$ConsultationTypeImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        durationMinutes: null == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as int,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConsultationTypeImpl implements _ConsultationType {
  const _$ConsultationTypeImpl({
    required this.id,
    required this.name,
    this.description,
    @JsonKey(name: 'duration_minutes') required this.durationMinutes,
    required this.price,
    @JsonKey(name: 'image_url') this.imageUrl,
  });

  factory _$ConsultationTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConsultationTypeImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? description;
  @override
  @JsonKey(name: 'duration_minutes')
  final int durationMinutes;
  @override
  final int price;
  // cents
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  @override
  String toString() {
    return 'ConsultationType(id: $id, name: $name, description: $description, durationMinutes: $durationMinutes, price: $price, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConsultationTypeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    durationMinutes,
    price,
    imageUrl,
  );

  /// Create a copy of ConsultationType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConsultationTypeImplCopyWith<_$ConsultationTypeImpl> get copyWith =>
      __$$ConsultationTypeImplCopyWithImpl<_$ConsultationTypeImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ConsultationTypeImplToJson(this);
  }
}

abstract class _ConsultationType implements ConsultationType {
  const factory _ConsultationType({
    required final int id,
    required final String name,
    final String? description,
    @JsonKey(name: 'duration_minutes') required final int durationMinutes,
    required final int price,
    @JsonKey(name: 'image_url') final String? imageUrl,
  }) = _$ConsultationTypeImpl;

  factory _ConsultationType.fromJson(Map<String, dynamic> json) =
      _$ConsultationTypeImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  @JsonKey(name: 'duration_minutes')
  int get durationMinutes;
  @override
  int get price; // cents
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;

  /// Create a copy of ConsultationType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConsultationTypeImplCopyWith<_$ConsultationTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
