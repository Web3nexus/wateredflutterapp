// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Audio _$AudioFromJson(Map<String, dynamic> json) {
  return _Audio.fromJson(json);
}

/// @nodoc
mixin _$Audio {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'audioUrl')
  String get audioUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'thumbnailUrl')
  String? get thumbnailUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration')
  String? get duration => throw _privateConstructorUsedError;
  String? get author => throw _privateConstructorUsedError;
  @JsonKey(name: 'publishedAt')
  DateTime? get publishedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'traditionId')
  int get traditionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'isActive')
  bool get isActive => throw _privateConstructorUsedError;
  bool get isFeatured => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_liked')
  bool get isLiked => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updatedAt')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Audio to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Audio
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AudioCopyWith<Audio> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioCopyWith<$Res> {
  factory $AudioCopyWith(Audio value, $Res Function(Audio) then) =
      _$AudioCopyWithImpl<$Res, Audio>;
  @useResult
  $Res call({
    int id,
    String title,
    String? description,
    @JsonKey(name: 'audioUrl') String audioUrl,
    @JsonKey(name: 'thumbnailUrl') String? thumbnailUrl,
    @JsonKey(name: 'duration') String? duration,
    String? author,
    @JsonKey(name: 'publishedAt') DateTime? publishedAt,
    @JsonKey(name: 'traditionId') int traditionId,
    @JsonKey(name: 'isActive') bool isActive,
    bool isFeatured,
    @JsonKey(name: 'is_liked') bool isLiked,
    @JsonKey(name: 'createdAt') DateTime? createdAt,
    @JsonKey(name: 'updatedAt') DateTime? updatedAt,
  });
}

/// @nodoc
class _$AudioCopyWithImpl<$Res, $Val extends Audio>
    implements $AudioCopyWith<$Res> {
  _$AudioCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Audio
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? audioUrl = null,
    Object? thumbnailUrl = freezed,
    Object? duration = freezed,
    Object? author = freezed,
    Object? publishedAt = freezed,
    Object? traditionId = null,
    Object? isActive = null,
    Object? isFeatured = null,
    Object? isLiked = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            audioUrl: null == audioUrl
                ? _value.audioUrl
                : audioUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            thumbnailUrl: freezed == thumbnailUrl
                ? _value.thumbnailUrl
                : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            duration: freezed == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as String?,
            author: freezed == author
                ? _value.author
                : author // ignore: cast_nullable_to_non_nullable
                      as String?,
            publishedAt: freezed == publishedAt
                ? _value.publishedAt
                : publishedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            traditionId: null == traditionId
                ? _value.traditionId
                : traditionId // ignore: cast_nullable_to_non_nullable
                      as int,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            isFeatured: null == isFeatured
                ? _value.isFeatured
                : isFeatured // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLiked: null == isLiked
                ? _value.isLiked
                : isLiked // ignore: cast_nullable_to_non_nullable
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
abstract class _$$AudioImplCopyWith<$Res> implements $AudioCopyWith<$Res> {
  factory _$$AudioImplCopyWith(
    _$AudioImpl value,
    $Res Function(_$AudioImpl) then,
  ) = __$$AudioImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String title,
    String? description,
    @JsonKey(name: 'audioUrl') String audioUrl,
    @JsonKey(name: 'thumbnailUrl') String? thumbnailUrl,
    @JsonKey(name: 'duration') String? duration,
    String? author,
    @JsonKey(name: 'publishedAt') DateTime? publishedAt,
    @JsonKey(name: 'traditionId') int traditionId,
    @JsonKey(name: 'isActive') bool isActive,
    bool isFeatured,
    @JsonKey(name: 'is_liked') bool isLiked,
    @JsonKey(name: 'createdAt') DateTime? createdAt,
    @JsonKey(name: 'updatedAt') DateTime? updatedAt,
  });
}

/// @nodoc
class __$$AudioImplCopyWithImpl<$Res>
    extends _$AudioCopyWithImpl<$Res, _$AudioImpl>
    implements _$$AudioImplCopyWith<$Res> {
  __$$AudioImplCopyWithImpl(
    _$AudioImpl _value,
    $Res Function(_$AudioImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Audio
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? audioUrl = null,
    Object? thumbnailUrl = freezed,
    Object? duration = freezed,
    Object? author = freezed,
    Object? publishedAt = freezed,
    Object? traditionId = null,
    Object? isActive = null,
    Object? isFeatured = null,
    Object? isLiked = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$AudioImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        audioUrl: null == audioUrl
            ? _value.audioUrl
            : audioUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        thumbnailUrl: freezed == thumbnailUrl
            ? _value.thumbnailUrl
            : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        duration: freezed == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as String?,
        author: freezed == author
            ? _value.author
            : author // ignore: cast_nullable_to_non_nullable
                  as String?,
        publishedAt: freezed == publishedAt
            ? _value.publishedAt
            : publishedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        traditionId: null == traditionId
            ? _value.traditionId
            : traditionId // ignore: cast_nullable_to_non_nullable
                  as int,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        isFeatured: null == isFeatured
            ? _value.isFeatured
            : isFeatured // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLiked: null == isLiked
            ? _value.isLiked
            : isLiked // ignore: cast_nullable_to_non_nullable
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
class _$AudioImpl implements _Audio {
  const _$AudioImpl({
    required this.id,
    required this.title,
    this.description,
    @JsonKey(name: 'audioUrl') required this.audioUrl,
    @JsonKey(name: 'thumbnailUrl') this.thumbnailUrl,
    @JsonKey(name: 'duration') this.duration,
    this.author,
    @JsonKey(name: 'publishedAt') this.publishedAt,
    @JsonKey(name: 'traditionId') required this.traditionId,
    @JsonKey(name: 'isActive') required this.isActive,
    this.isFeatured = false,
    @JsonKey(name: 'is_liked') this.isLiked = false,
    @JsonKey(name: 'createdAt') this.createdAt,
    @JsonKey(name: 'updatedAt') this.updatedAt,
  });

  factory _$AudioImpl.fromJson(Map<String, dynamic> json) =>
      _$$AudioImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String? description;
  @override
  @JsonKey(name: 'audioUrl')
  final String audioUrl;
  @override
  @JsonKey(name: 'thumbnailUrl')
  final String? thumbnailUrl;
  @override
  @JsonKey(name: 'duration')
  final String? duration;
  @override
  final String? author;
  @override
  @JsonKey(name: 'publishedAt')
  final DateTime? publishedAt;
  @override
  @JsonKey(name: 'traditionId')
  final int traditionId;
  @override
  @JsonKey(name: 'isActive')
  final bool isActive;
  @override
  @JsonKey()
  final bool isFeatured;
  @override
  @JsonKey(name: 'is_liked')
  final bool isLiked;
  @override
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Audio(id: $id, title: $title, description: $description, audioUrl: $audioUrl, thumbnailUrl: $thumbnailUrl, duration: $duration, author: $author, publishedAt: $publishedAt, traditionId: $traditionId, isActive: $isActive, isFeatured: $isFeatured, isLiked: $isLiked, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.audioUrl, audioUrl) ||
                other.audioUrl == audioUrl) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt) &&
            (identical(other.traditionId, traditionId) ||
                other.traditionId == traditionId) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked) &&
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
    title,
    description,
    audioUrl,
    thumbnailUrl,
    duration,
    author,
    publishedAt,
    traditionId,
    isActive,
    isFeatured,
    isLiked,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Audio
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioImplCopyWith<_$AudioImpl> get copyWith =>
      __$$AudioImplCopyWithImpl<_$AudioImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AudioImplToJson(this);
  }
}

abstract class _Audio implements Audio {
  const factory _Audio({
    required final int id,
    required final String title,
    final String? description,
    @JsonKey(name: 'audioUrl') required final String audioUrl,
    @JsonKey(name: 'thumbnailUrl') final String? thumbnailUrl,
    @JsonKey(name: 'duration') final String? duration,
    final String? author,
    @JsonKey(name: 'publishedAt') final DateTime? publishedAt,
    @JsonKey(name: 'traditionId') required final int traditionId,
    @JsonKey(name: 'isActive') required final bool isActive,
    final bool isFeatured,
    @JsonKey(name: 'is_liked') final bool isLiked,
    @JsonKey(name: 'createdAt') final DateTime? createdAt,
    @JsonKey(name: 'updatedAt') final DateTime? updatedAt,
  }) = _$AudioImpl;

  factory _Audio.fromJson(Map<String, dynamic> json) = _$AudioImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  @JsonKey(name: 'audioUrl')
  String get audioUrl;
  @override
  @JsonKey(name: 'thumbnailUrl')
  String? get thumbnailUrl;
  @override
  @JsonKey(name: 'duration')
  String? get duration;
  @override
  String? get author;
  @override
  @JsonKey(name: 'publishedAt')
  DateTime? get publishedAt;
  @override
  @JsonKey(name: 'traditionId')
  int get traditionId;
  @override
  @JsonKey(name: 'isActive')
  bool get isActive;
  @override
  bool get isFeatured;
  @override
  @JsonKey(name: 'is_liked')
  bool get isLiked;
  @override
  @JsonKey(name: 'createdAt')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updatedAt')
  DateTime? get updatedAt;

  /// Create a copy of Audio
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AudioImplCopyWith<_$AudioImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
