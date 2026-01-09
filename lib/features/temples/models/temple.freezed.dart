// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'temple.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Temple _$TempleFromJson(Map<String, dynamic> json) {
  return _Temple.fromJson(json);
}

/// @nodoc
mixin _$Temple {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  double? get distance =>
      throw _privateConstructorUsedError; // For near me results
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this Temple to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Temple
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TempleCopyWith<Temple> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TempleCopyWith<$Res> {
  factory $TempleCopyWith(Temple value, $Res Function(Temple) then) =
      _$TempleCopyWithImpl<$Res, Temple>;
  @useResult
  $Res call({
    int id,
    String name,
    String? description,
    String? address,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'image_url') String? imageUrl,
    double? distance,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class _$TempleCopyWithImpl<$Res, $Val extends Temple>
    implements $TempleCopyWith<$Res> {
  _$TempleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Temple
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? address = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? imageUrl = freezed,
    Object? distance = freezed,
    Object? isActive = null,
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
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            distance: freezed == distance
                ? _value.distance
                : distance // ignore: cast_nullable_to_non_nullable
                      as double?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TempleImplCopyWith<$Res> implements $TempleCopyWith<$Res> {
  factory _$$TempleImplCopyWith(
    _$TempleImpl value,
    $Res Function(_$TempleImpl) then,
  ) = __$$TempleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String? description,
    String? address,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'image_url') String? imageUrl,
    double? distance,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class __$$TempleImplCopyWithImpl<$Res>
    extends _$TempleCopyWithImpl<$Res, _$TempleImpl>
    implements _$$TempleImplCopyWith<$Res> {
  __$$TempleImplCopyWithImpl(
    _$TempleImpl _value,
    $Res Function(_$TempleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Temple
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? address = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? imageUrl = freezed,
    Object? distance = freezed,
    Object? isActive = null,
  }) {
    return _then(
      _$TempleImpl(
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
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        distance: freezed == distance
            ? _value.distance
            : distance // ignore: cast_nullable_to_non_nullable
                  as double?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TempleImpl implements _Temple {
  const _$TempleImpl({
    required this.id,
    required this.name,
    this.description,
    this.address,
    this.latitude,
    this.longitude,
    @JsonKey(name: 'image_url') this.imageUrl,
    this.distance = 0.0,
    @JsonKey(name: 'is_active') this.isActive = true,
  });

  factory _$TempleImpl.fromJson(Map<String, dynamic> json) =>
      _$$TempleImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? address;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @override
  @JsonKey()
  final double? distance;
  // For near me results
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;

  @override
  String toString() {
    return 'Temple(id: $id, name: $name, description: $description, address: $address, latitude: $latitude, longitude: $longitude, imageUrl: $imageUrl, distance: $distance, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TempleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    address,
    latitude,
    longitude,
    imageUrl,
    distance,
    isActive,
  );

  /// Create a copy of Temple
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TempleImplCopyWith<_$TempleImpl> get copyWith =>
      __$$TempleImplCopyWithImpl<_$TempleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TempleImplToJson(this);
  }
}

abstract class _Temple implements Temple {
  const factory _Temple({
    required final int id,
    required final String name,
    final String? description,
    final String? address,
    final double? latitude,
    final double? longitude,
    @JsonKey(name: 'image_url') final String? imageUrl,
    final double? distance,
    @JsonKey(name: 'is_active') final bool isActive,
  }) = _$TempleImpl;

  factory _Temple.fromJson(Map<String, dynamic> json) = _$TempleImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String? get address;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  double? get distance; // For near me results
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;

  /// Create a copy of Temple
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TempleImplCopyWith<_$TempleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
