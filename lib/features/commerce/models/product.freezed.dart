// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError; // default in cents
  @JsonKey(name: 'price_ngn')
  double? get priceNgn => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_usd')
  double? get priceUsd => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'audio_sample_url')
  String? get audioSampleUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_digital')
  bool get isDigital => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this Product to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call({
    int id,
    String name,
    String? description,
    int price,
    @JsonKey(name: 'price_ngn') double? priceNgn,
    @JsonKey(name: 'price_usd') double? priceUsd,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'audio_sample_url') String? audioSampleUrl,
    @JsonKey(name: 'is_digital') bool isDigital,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? price = null,
    Object? priceNgn = freezed,
    Object? priceUsd = freezed,
    Object? imageUrl = freezed,
    Object? audioSampleUrl = freezed,
    Object? isDigital = null,
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
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as int,
            priceNgn: freezed == priceNgn
                ? _value.priceNgn
                : priceNgn // ignore: cast_nullable_to_non_nullable
                      as double?,
            priceUsd: freezed == priceUsd
                ? _value.priceUsd
                : priceUsd // ignore: cast_nullable_to_non_nullable
                      as double?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            audioSampleUrl: freezed == audioSampleUrl
                ? _value.audioSampleUrl
                : audioSampleUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            isDigital: null == isDigital
                ? _value.isDigital
                : isDigital // ignore: cast_nullable_to_non_nullable
                      as bool,
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
abstract class _$$ProductImplCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$ProductImplCopyWith(
    _$ProductImpl value,
    $Res Function(_$ProductImpl) then,
  ) = __$$ProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String? description,
    int price,
    @JsonKey(name: 'price_ngn') double? priceNgn,
    @JsonKey(name: 'price_usd') double? priceUsd,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'audio_sample_url') String? audioSampleUrl,
    @JsonKey(name: 'is_digital') bool isDigital,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class __$$ProductImplCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$ProductImpl>
    implements _$$ProductImplCopyWith<$Res> {
  __$$ProductImplCopyWithImpl(
    _$ProductImpl _value,
    $Res Function(_$ProductImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? price = null,
    Object? priceNgn = freezed,
    Object? priceUsd = freezed,
    Object? imageUrl = freezed,
    Object? audioSampleUrl = freezed,
    Object? isDigital = null,
    Object? isActive = null,
  }) {
    return _then(
      _$ProductImpl(
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
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as int,
        priceNgn: freezed == priceNgn
            ? _value.priceNgn
            : priceNgn // ignore: cast_nullable_to_non_nullable
                  as double?,
        priceUsd: freezed == priceUsd
            ? _value.priceUsd
            : priceUsd // ignore: cast_nullable_to_non_nullable
                  as double?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        audioSampleUrl: freezed == audioSampleUrl
            ? _value.audioSampleUrl
            : audioSampleUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        isDigital: null == isDigital
            ? _value.isDigital
            : isDigital // ignore: cast_nullable_to_non_nullable
                  as bool,
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
class _$ProductImpl implements _Product {
  const _$ProductImpl({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    @JsonKey(name: 'price_ngn') this.priceNgn,
    @JsonKey(name: 'price_usd') this.priceUsd,
    @JsonKey(name: 'image_url') this.imageUrl,
    @JsonKey(name: 'audio_sample_url') this.audioSampleUrl,
    @JsonKey(name: 'is_digital') this.isDigital = false,
    @JsonKey(name: 'is_active') this.isActive = true,
  });

  factory _$ProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final int price;
  // default in cents
  @override
  @JsonKey(name: 'price_ngn')
  final double? priceNgn;
  @override
  @JsonKey(name: 'price_usd')
  final double? priceUsd;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @override
  @JsonKey(name: 'audio_sample_url')
  final String? audioSampleUrl;
  @override
  @JsonKey(name: 'is_digital')
  final bool isDigital;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, price: $price, priceNgn: $priceNgn, priceUsd: $priceUsd, imageUrl: $imageUrl, audioSampleUrl: $audioSampleUrl, isDigital: $isDigital, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.priceNgn, priceNgn) ||
                other.priceNgn == priceNgn) &&
            (identical(other.priceUsd, priceUsd) ||
                other.priceUsd == priceUsd) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.audioSampleUrl, audioSampleUrl) ||
                other.audioSampleUrl == audioSampleUrl) &&
            (identical(other.isDigital, isDigital) ||
                other.isDigital == isDigital) &&
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
    price,
    priceNgn,
    priceUsd,
    imageUrl,
    audioSampleUrl,
    isDigital,
    isActive,
  );

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      __$$ProductImplCopyWithImpl<_$ProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductImplToJson(this);
  }
}

abstract class _Product implements Product {
  const factory _Product({
    required final int id,
    required final String name,
    final String? description,
    required final int price,
    @JsonKey(name: 'price_ngn') final double? priceNgn,
    @JsonKey(name: 'price_usd') final double? priceUsd,
    @JsonKey(name: 'image_url') final String? imageUrl,
    @JsonKey(name: 'audio_sample_url') final String? audioSampleUrl,
    @JsonKey(name: 'is_digital') final bool isDigital,
    @JsonKey(name: 'is_active') final bool isActive,
  }) = _$ProductImpl;

  factory _Product.fromJson(Map<String, dynamic> json) = _$ProductImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  int get price; // default in cents
  @override
  @JsonKey(name: 'price_ngn')
  double? get priceNgn;
  @override
  @JsonKey(name: 'price_usd')
  double? get priceUsd;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  @JsonKey(name: 'audio_sample_url')
  String? get audioSampleUrl;
  @override
  @JsonKey(name: 'is_digital')
  bool get isDigital;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
