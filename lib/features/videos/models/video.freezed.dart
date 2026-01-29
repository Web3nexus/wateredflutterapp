// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Video _$VideoFromJson(Map<String, dynamic> json) {
  return _Video.fromJson(json);
}

/// @nodoc
mixin _$Video {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get youtubeUrl => throw _privateConstructorUsedError;
  String? get storageUrl => throw _privateConstructorUsedError;
  String get videoType =>
      throw _privateConstructorUsedError; // 'youtube' or 'file'
  String? get thumbnailUrl => throw _privateConstructorUsedError;
  String? get duration => throw _privateConstructorUsedError;
  DateTime get publishedAt => throw _privateConstructorUsedError;
  int get traditionId => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get isFeatured => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_liked')
  bool get isLiked => throw _privateConstructorUsedError;
  @JsonKey(name: 'likes_count')
  int? get likesCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'comments_count')
  int? get commentsCount => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Video to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Video
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VideoCopyWith<Video> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoCopyWith<$Res> {
  factory $VideoCopyWith(Video value, $Res Function(Video) then) =
      _$VideoCopyWithImpl<$Res, Video>;
  @useResult
  $Res call({
    int id,
    String title,
    String? description,
    String youtubeUrl,
    String? storageUrl,
    String videoType,
    String? thumbnailUrl,
    String? duration,
    DateTime publishedAt,
    int traditionId,
    bool isActive,
    bool isFeatured,
    @JsonKey(name: 'is_liked') bool isLiked,
    @JsonKey(name: 'likes_count') int? likesCount,
    @JsonKey(name: 'comments_count') int? commentsCount,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$VideoCopyWithImpl<$Res, $Val extends Video>
    implements $VideoCopyWith<$Res> {
  _$VideoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Video
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? youtubeUrl = null,
    Object? storageUrl = freezed,
    Object? videoType = null,
    Object? thumbnailUrl = freezed,
    Object? duration = freezed,
    Object? publishedAt = null,
    Object? traditionId = null,
    Object? isActive = null,
    Object? isFeatured = null,
    Object? isLiked = null,
    Object? likesCount = freezed,
    Object? commentsCount = freezed,
    Object? tags = freezed,
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
            youtubeUrl: null == youtubeUrl
                ? _value.youtubeUrl
                : youtubeUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            storageUrl: freezed == storageUrl
                ? _value.storageUrl
                : storageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            videoType: null == videoType
                ? _value.videoType
                : videoType // ignore: cast_nullable_to_non_nullable
                      as String,
            thumbnailUrl: freezed == thumbnailUrl
                ? _value.thumbnailUrl
                : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            duration: freezed == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as String?,
            publishedAt: null == publishedAt
                ? _value.publishedAt
                : publishedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
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
            likesCount: freezed == likesCount
                ? _value.likesCount
                : likesCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            commentsCount: freezed == commentsCount
                ? _value.commentsCount
                : commentsCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            tags: freezed == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
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
abstract class _$$VideoImplCopyWith<$Res> implements $VideoCopyWith<$Res> {
  factory _$$VideoImplCopyWith(
    _$VideoImpl value,
    $Res Function(_$VideoImpl) then,
  ) = __$$VideoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String title,
    String? description,
    String youtubeUrl,
    String? storageUrl,
    String videoType,
    String? thumbnailUrl,
    String? duration,
    DateTime publishedAt,
    int traditionId,
    bool isActive,
    bool isFeatured,
    @JsonKey(name: 'is_liked') bool isLiked,
    @JsonKey(name: 'likes_count') int? likesCount,
    @JsonKey(name: 'comments_count') int? commentsCount,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$VideoImplCopyWithImpl<$Res>
    extends _$VideoCopyWithImpl<$Res, _$VideoImpl>
    implements _$$VideoImplCopyWith<$Res> {
  __$$VideoImplCopyWithImpl(
    _$VideoImpl _value,
    $Res Function(_$VideoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Video
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? youtubeUrl = null,
    Object? storageUrl = freezed,
    Object? videoType = null,
    Object? thumbnailUrl = freezed,
    Object? duration = freezed,
    Object? publishedAt = null,
    Object? traditionId = null,
    Object? isActive = null,
    Object? isFeatured = null,
    Object? isLiked = null,
    Object? likesCount = freezed,
    Object? commentsCount = freezed,
    Object? tags = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$VideoImpl(
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
        youtubeUrl: null == youtubeUrl
            ? _value.youtubeUrl
            : youtubeUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        storageUrl: freezed == storageUrl
            ? _value.storageUrl
            : storageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        videoType: null == videoType
            ? _value.videoType
            : videoType // ignore: cast_nullable_to_non_nullable
                  as String,
        thumbnailUrl: freezed == thumbnailUrl
            ? _value.thumbnailUrl
            : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        duration: freezed == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as String?,
        publishedAt: null == publishedAt
            ? _value.publishedAt
            : publishedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
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
        likesCount: freezed == likesCount
            ? _value.likesCount
            : likesCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        commentsCount: freezed == commentsCount
            ? _value.commentsCount
            : commentsCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        tags: freezed == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
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
class _$VideoImpl implements _Video {
  const _$VideoImpl({
    required this.id,
    required this.title,
    this.description,
    required this.youtubeUrl,
    this.storageUrl,
    this.videoType = 'youtube',
    this.thumbnailUrl,
    this.duration,
    required this.publishedAt,
    required this.traditionId,
    required this.isActive,
    this.isFeatured = false,
    @JsonKey(name: 'is_liked') this.isLiked = false,
    @JsonKey(name: 'likes_count') this.likesCount,
    @JsonKey(name: 'comments_count') this.commentsCount,
    final List<String>? tags,
    this.createdAt,
    this.updatedAt,
  }) : _tags = tags;

  factory _$VideoImpl.fromJson(Map<String, dynamic> json) =>
      _$$VideoImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final String youtubeUrl;
  @override
  final String? storageUrl;
  @override
  @JsonKey()
  final String videoType;
  // 'youtube' or 'file'
  @override
  final String? thumbnailUrl;
  @override
  final String? duration;
  @override
  final DateTime publishedAt;
  @override
  final int traditionId;
  @override
  final bool isActive;
  @override
  @JsonKey()
  final bool isFeatured;
  @override
  @JsonKey(name: 'is_liked')
  final bool isLiked;
  @override
  @JsonKey(name: 'likes_count')
  final int? likesCount;
  @override
  @JsonKey(name: 'comments_count')
  final int? commentsCount;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Video(id: $id, title: $title, description: $description, youtubeUrl: $youtubeUrl, storageUrl: $storageUrl, videoType: $videoType, thumbnailUrl: $thumbnailUrl, duration: $duration, publishedAt: $publishedAt, traditionId: $traditionId, isActive: $isActive, isFeatured: $isFeatured, isLiked: $isLiked, likesCount: $likesCount, commentsCount: $commentsCount, tags: $tags, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.youtubeUrl, youtubeUrl) ||
                other.youtubeUrl == youtubeUrl) &&
            (identical(other.storageUrl, storageUrl) ||
                other.storageUrl == storageUrl) &&
            (identical(other.videoType, videoType) ||
                other.videoType == videoType) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt) &&
            (identical(other.traditionId, traditionId) ||
                other.traditionId == traditionId) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked) &&
            (identical(other.likesCount, likesCount) ||
                other.likesCount == likesCount) &&
            (identical(other.commentsCount, commentsCount) ||
                other.commentsCount == commentsCount) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
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
    youtubeUrl,
    storageUrl,
    videoType,
    thumbnailUrl,
    duration,
    publishedAt,
    traditionId,
    isActive,
    isFeatured,
    isLiked,
    likesCount,
    commentsCount,
    const DeepCollectionEquality().hash(_tags),
    createdAt,
    updatedAt,
  );

  /// Create a copy of Video
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoImplCopyWith<_$VideoImpl> get copyWith =>
      __$$VideoImplCopyWithImpl<_$VideoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VideoImplToJson(this);
  }
}

abstract class _Video implements Video {
  const factory _Video({
    required final int id,
    required final String title,
    final String? description,
    required final String youtubeUrl,
    final String? storageUrl,
    final String videoType,
    final String? thumbnailUrl,
    final String? duration,
    required final DateTime publishedAt,
    required final int traditionId,
    required final bool isActive,
    final bool isFeatured,
    @JsonKey(name: 'is_liked') final bool isLiked,
    @JsonKey(name: 'likes_count') final int? likesCount,
    @JsonKey(name: 'comments_count') final int? commentsCount,
    final List<String>? tags,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$VideoImpl;

  factory _Video.fromJson(Map<String, dynamic> json) = _$VideoImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  String get youtubeUrl;
  @override
  String? get storageUrl;
  @override
  String get videoType; // 'youtube' or 'file'
  @override
  String? get thumbnailUrl;
  @override
  String? get duration;
  @override
  DateTime get publishedAt;
  @override
  int get traditionId;
  @override
  bool get isActive;
  @override
  bool get isFeatured;
  @override
  @JsonKey(name: 'is_liked')
  bool get isLiked;
  @override
  @JsonKey(name: 'likes_count')
  int? get likesCount;
  @override
  @JsonKey(name: 'comments_count')
  int? get commentsCount;
  @override
  List<String>? get tags;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Video
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoImplCopyWith<_$VideoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
