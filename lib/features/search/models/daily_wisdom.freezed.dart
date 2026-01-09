// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_wisdom.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DailyWisdom _$DailyWisdomFromJson(Map<String, dynamic> json) {
  return _DailyWisdom.fromJson(json);
}

/// @nodoc
mixin _$DailyWisdom {
  int get id => throw _privateConstructorUsedError;
  String get quote => throw _privateConstructorUsedError;
  String? get author => throw _privateConstructorUsedError;
  @JsonKey(name: 'background_image_url')
  String? get backgroundImageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'publish_date')
  DateTime get publishDate => throw _privateConstructorUsedError;

  /// Serializes this DailyWisdom to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyWisdom
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyWisdomCopyWith<DailyWisdom> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyWisdomCopyWith<$Res> {
  factory $DailyWisdomCopyWith(
    DailyWisdom value,
    $Res Function(DailyWisdom) then,
  ) = _$DailyWisdomCopyWithImpl<$Res, DailyWisdom>;
  @useResult
  $Res call({
    int id,
    String quote,
    String? author,
    @JsonKey(name: 'background_image_url') String? backgroundImageUrl,
    @JsonKey(name: 'publish_date') DateTime publishDate,
  });
}

/// @nodoc
class _$DailyWisdomCopyWithImpl<$Res, $Val extends DailyWisdom>
    implements $DailyWisdomCopyWith<$Res> {
  _$DailyWisdomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyWisdom
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? quote = null,
    Object? author = freezed,
    Object? backgroundImageUrl = freezed,
    Object? publishDate = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            quote: null == quote
                ? _value.quote
                : quote // ignore: cast_nullable_to_non_nullable
                      as String,
            author: freezed == author
                ? _value.author
                : author // ignore: cast_nullable_to_non_nullable
                      as String?,
            backgroundImageUrl: freezed == backgroundImageUrl
                ? _value.backgroundImageUrl
                : backgroundImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            publishDate: null == publishDate
                ? _value.publishDate
                : publishDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DailyWisdomImplCopyWith<$Res>
    implements $DailyWisdomCopyWith<$Res> {
  factory _$$DailyWisdomImplCopyWith(
    _$DailyWisdomImpl value,
    $Res Function(_$DailyWisdomImpl) then,
  ) = __$$DailyWisdomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String quote,
    String? author,
    @JsonKey(name: 'background_image_url') String? backgroundImageUrl,
    @JsonKey(name: 'publish_date') DateTime publishDate,
  });
}

/// @nodoc
class __$$DailyWisdomImplCopyWithImpl<$Res>
    extends _$DailyWisdomCopyWithImpl<$Res, _$DailyWisdomImpl>
    implements _$$DailyWisdomImplCopyWith<$Res> {
  __$$DailyWisdomImplCopyWithImpl(
    _$DailyWisdomImpl _value,
    $Res Function(_$DailyWisdomImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DailyWisdom
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? quote = null,
    Object? author = freezed,
    Object? backgroundImageUrl = freezed,
    Object? publishDate = null,
  }) {
    return _then(
      _$DailyWisdomImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        quote: null == quote
            ? _value.quote
            : quote // ignore: cast_nullable_to_non_nullable
                  as String,
        author: freezed == author
            ? _value.author
            : author // ignore: cast_nullable_to_non_nullable
                  as String?,
        backgroundImageUrl: freezed == backgroundImageUrl
            ? _value.backgroundImageUrl
            : backgroundImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        publishDate: null == publishDate
            ? _value.publishDate
            : publishDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyWisdomImpl implements _DailyWisdom {
  const _$DailyWisdomImpl({
    required this.id,
    required this.quote,
    this.author,
    @JsonKey(name: 'background_image_url') this.backgroundImageUrl,
    @JsonKey(name: 'publish_date') required this.publishDate,
  });

  factory _$DailyWisdomImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyWisdomImplFromJson(json);

  @override
  final int id;
  @override
  final String quote;
  @override
  final String? author;
  @override
  @JsonKey(name: 'background_image_url')
  final String? backgroundImageUrl;
  @override
  @JsonKey(name: 'publish_date')
  final DateTime publishDate;

  @override
  String toString() {
    return 'DailyWisdom(id: $id, quote: $quote, author: $author, backgroundImageUrl: $backgroundImageUrl, publishDate: $publishDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyWisdomImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.quote, quote) || other.quote == quote) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.backgroundImageUrl, backgroundImageUrl) ||
                other.backgroundImageUrl == backgroundImageUrl) &&
            (identical(other.publishDate, publishDate) ||
                other.publishDate == publishDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    quote,
    author,
    backgroundImageUrl,
    publishDate,
  );

  /// Create a copy of DailyWisdom
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyWisdomImplCopyWith<_$DailyWisdomImpl> get copyWith =>
      __$$DailyWisdomImplCopyWithImpl<_$DailyWisdomImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyWisdomImplToJson(this);
  }
}

abstract class _DailyWisdom implements DailyWisdom {
  const factory _DailyWisdom({
    required final int id,
    required final String quote,
    final String? author,
    @JsonKey(name: 'background_image_url') final String? backgroundImageUrl,
    @JsonKey(name: 'publish_date') required final DateTime publishDate,
  }) = _$DailyWisdomImpl;

  factory _DailyWisdom.fromJson(Map<String, dynamic> json) =
      _$DailyWisdomImpl.fromJson;

  @override
  int get id;
  @override
  String get quote;
  @override
  String? get author;
  @override
  @JsonKey(name: 'background_image_url')
  String? get backgroundImageUrl;
  @override
  @JsonKey(name: 'publish_date')
  DateTime get publishDate;

  /// Create a copy of DailyWisdom
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyWisdomImplCopyWith<_$DailyWisdomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
