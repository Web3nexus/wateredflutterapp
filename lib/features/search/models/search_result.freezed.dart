// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) {
  return _SearchResult.fromJson(json);
}

/// @nodoc
mixin _$SearchResult {
  List<Video> get videos => throw _privateConstructorUsedError;
  List<dynamic> get audio =>
      throw _privateConstructorUsedError; // Placeholder until Audio model imported/created
  List<Product> get products => throw _privateConstructorUsedError;
  List<Temple> get temples => throw _privateConstructorUsedError;
  List<dynamic> get traditions => throw _privateConstructorUsedError;

  /// Serializes this SearchResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchResultCopyWith<SearchResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchResultCopyWith<$Res> {
  factory $SearchResultCopyWith(
    SearchResult value,
    $Res Function(SearchResult) then,
  ) = _$SearchResultCopyWithImpl<$Res, SearchResult>;
  @useResult
  $Res call({
    List<Video> videos,
    List<dynamic> audio,
    List<Product> products,
    List<Temple> temples,
    List<dynamic> traditions,
  });
}

/// @nodoc
class _$SearchResultCopyWithImpl<$Res, $Val extends SearchResult>
    implements $SearchResultCopyWith<$Res> {
  _$SearchResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videos = null,
    Object? audio = null,
    Object? products = null,
    Object? temples = null,
    Object? traditions = null,
  }) {
    return _then(
      _value.copyWith(
            videos: null == videos
                ? _value.videos
                : videos // ignore: cast_nullable_to_non_nullable
                      as List<Video>,
            audio: null == audio
                ? _value.audio
                : audio // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>,
            products: null == products
                ? _value.products
                : products // ignore: cast_nullable_to_non_nullable
                      as List<Product>,
            temples: null == temples
                ? _value.temples
                : temples // ignore: cast_nullable_to_non_nullable
                      as List<Temple>,
            traditions: null == traditions
                ? _value.traditions
                : traditions // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SearchResultImplCopyWith<$Res>
    implements $SearchResultCopyWith<$Res> {
  factory _$$SearchResultImplCopyWith(
    _$SearchResultImpl value,
    $Res Function(_$SearchResultImpl) then,
  ) = __$$SearchResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Video> videos,
    List<dynamic> audio,
    List<Product> products,
    List<Temple> temples,
    List<dynamic> traditions,
  });
}

/// @nodoc
class __$$SearchResultImplCopyWithImpl<$Res>
    extends _$SearchResultCopyWithImpl<$Res, _$SearchResultImpl>
    implements _$$SearchResultImplCopyWith<$Res> {
  __$$SearchResultImplCopyWithImpl(
    _$SearchResultImpl _value,
    $Res Function(_$SearchResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videos = null,
    Object? audio = null,
    Object? products = null,
    Object? temples = null,
    Object? traditions = null,
  }) {
    return _then(
      _$SearchResultImpl(
        videos: null == videos
            ? _value._videos
            : videos // ignore: cast_nullable_to_non_nullable
                  as List<Video>,
        audio: null == audio
            ? _value._audio
            : audio // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>,
        products: null == products
            ? _value._products
            : products // ignore: cast_nullable_to_non_nullable
                  as List<Product>,
        temples: null == temples
            ? _value._temples
            : temples // ignore: cast_nullable_to_non_nullable
                  as List<Temple>,
        traditions: null == traditions
            ? _value._traditions
            : traditions // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchResultImpl implements _SearchResult {
  const _$SearchResultImpl({
    final List<Video> videos = const [],
    final List<dynamic> audio = const [],
    final List<Product> products = const [],
    final List<Temple> temples = const [],
    final List<dynamic> traditions = const [],
  }) : _videos = videos,
       _audio = audio,
       _products = products,
       _temples = temples,
       _traditions = traditions;

  factory _$SearchResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchResultImplFromJson(json);

  final List<Video> _videos;
  @override
  @JsonKey()
  List<Video> get videos {
    if (_videos is EqualUnmodifiableListView) return _videos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_videos);
  }

  final List<dynamic> _audio;
  @override
  @JsonKey()
  List<dynamic> get audio {
    if (_audio is EqualUnmodifiableListView) return _audio;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_audio);
  }

  // Placeholder until Audio model imported/created
  final List<Product> _products;
  // Placeholder until Audio model imported/created
  @override
  @JsonKey()
  List<Product> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  final List<Temple> _temples;
  @override
  @JsonKey()
  List<Temple> get temples {
    if (_temples is EqualUnmodifiableListView) return _temples;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_temples);
  }

  final List<dynamic> _traditions;
  @override
  @JsonKey()
  List<dynamic> get traditions {
    if (_traditions is EqualUnmodifiableListView) return _traditions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_traditions);
  }

  @override
  String toString() {
    return 'SearchResult(videos: $videos, audio: $audio, products: $products, temples: $temples, traditions: $traditions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchResultImpl &&
            const DeepCollectionEquality().equals(other._videos, _videos) &&
            const DeepCollectionEquality().equals(other._audio, _audio) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            const DeepCollectionEquality().equals(other._temples, _temples) &&
            const DeepCollectionEquality().equals(
              other._traditions,
              _traditions,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_videos),
    const DeepCollectionEquality().hash(_audio),
    const DeepCollectionEquality().hash(_products),
    const DeepCollectionEquality().hash(_temples),
    const DeepCollectionEquality().hash(_traditions),
  );

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchResultImplCopyWith<_$SearchResultImpl> get copyWith =>
      __$$SearchResultImplCopyWithImpl<_$SearchResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchResultImplToJson(this);
  }
}

abstract class _SearchResult implements SearchResult {
  const factory _SearchResult({
    final List<Video> videos,
    final List<dynamic> audio,
    final List<Product> products,
    final List<Temple> temples,
    final List<dynamic> traditions,
  }) = _$SearchResultImpl;

  factory _SearchResult.fromJson(Map<String, dynamic> json) =
      _$SearchResultImpl.fromJson;

  @override
  List<Video> get videos;
  @override
  List<dynamic> get audio; // Placeholder until Audio model imported/created
  @override
  List<Product> get products;
  @override
  List<Temple> get temples;
  @override
  List<dynamic> get traditions;

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchResultImplCopyWith<_$SearchResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
