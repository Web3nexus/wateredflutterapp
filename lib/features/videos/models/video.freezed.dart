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
  @JsonKey(name: 'youtube_url')
  String get youtubeUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'storage_url')
  String? get storageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'video_type')
  String get videoType => throw _privateConstructorUsedError; // 'youtube' or 'file'
  @JsonKey(name: 'thumbnail_url')
  String? get thumbnailUrl => throw _privateConstructorUsedError;
  String? get duration => throw _privateConstructorUsedError;
  @JsonKey(name: 'published_at')
  DateTime? get publishedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'tradition_id')
  int get traditionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_featured')
  bool get isFeatured => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_liked')
  bool get isLiked => throw _privateConstructorUsedError;
  @JsonKey(name: 'likes_count')
  int? get likesCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'comments_count')
  int? get commentsCount => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
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
    @JsonKey(name: 'youtube_url') String youtubeUrl,
    @JsonKey(name: 'storage_url') String? storageUrl,
    @JsonKey(name: 'video_type') String videoType,
    @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
    String? duration,
    @JsonKey(name: 'published_at') DateTime? publishedAt,
    @JsonKey(name: 'tradition_id') int traditionId,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'is_featured') bool isFeatured,
    @JsonKey(name: 'is_liked') bool isLiked,
    @JsonKey(name: 'likes_count') int? likesCount,
    @JsonKey(name: 'comments_count') int? commentsCount,
    List<String>? tags,
    String? category,
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
    Object? publishedAt = freezed,
    Object? traditionId = null,
    Object? isActive = null,
    Object? isFeatured = null,
    Object? isLiked = null,
    Object? likesCount = freezed,
    Object? commentsCount = freezed,
    Object? tags = freezed,
    Object? category = freezed,
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
            category: freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String?,
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
    @JsonKey(name: 'youtube_url') String youtubeUrl,
    @JsonKey(name: 'storage_url') String? storageUrl,
    @JsonKey(name: 'video_type') String videoType,
    @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
    String? duration,
    @JsonKey(name: 'published_at') DateTime? publishedAt,
    @JsonKey(name: 'tradition_id') int traditionId,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'is_featured') bool isFeatured,
    @JsonKey(name: 'is_liked') bool isLiked,
    @JsonKey(name: 'likes_count') int? likesCount,
    @JsonKey(name: 'comments_count') int? commentsCount,
    List<String>? tags,
    String? category,
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
    Object? publishedAt = freezed,
    Object? traditionId = null,
    Object? isActive = null,
    Object? isFeatured = null,
    Object? isLiked = null,
    Object? likesCount = freezed,
    Object? commentsCount = freezed,
    Object? tags = freezed,
    Object? category = freezed,
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
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String?,
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
    @JsonKey(name: 'youtube_url') required this.youtubeUrl,
    @JsonKey(name: 'storage_url') this.storageUrl,
    @JsonKey(name: 'video_type') this.videoType = 'youtube',
    @JsonKey(name: 'thumbnail_url') this.thumbnailUrl,
    this.duration,
    @JsonKey(name: 'published_at') this.publishedAt,
    @JsonKey(name: 'tradition_id') required this.traditionId,
    @JsonKey(name: 'is_active') required this.isActive,
    @JsonKey(name: 'is_featured') this.isFeatured = false,
    @JsonKey(name: 'is_liked') this.isLiked = false,
    @JsonKey(name: 'likes_count') this.likesCount,
    @JsonKey(name: 'comments_count') this.commentsCount,
    final List<String>? tags,
    this.category,
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
  @JsonKey(name: 'youtube_url')
  final String youtubeUrl;
  @override
  @JsonKey(name: 'storage_url')
  final String? storageUrl;
  @override
  @JsonKey(name: 'video_type')
  final String videoType;
  // 'youtube' or 'file'
  @override
  @JsonKey(name: 'thumbnail_url')
  final String? thumbnailUrl;
  @override
  final String? duration;
  @override
  @JsonKey(name: 'published_at')
  final DateTime? publishedAt;
  @override
  @JsonKey(name: 'tradition_id')
  final int traditionId;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'is_featured')
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
  final String? category;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Video(id: $id, title: $title, description: $description, youtubeUrl: $youtubeUrl, storageUrl: $storageUrl, videoType: $videoType, thumbnailUrl: $thumbnailUrl, duration: $duration, publishedAt: $publishedAt, traditionId: $traditionId, isActive: $isActive, isFeatured: $isFeatured, isLiked: $isLiked, likesCount: $likesCount, commentsCount: $commentsCount, tags: $tags, category: $category, createdAt: $createdAt, updatedAt: $updatedAt)';
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
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
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
    category,
    createdAt,
    updatedAt,
  ]);

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
    @JsonKey(name: 'youtube_url') required final String youtubeUrl,
    @JsonKey(name: 'storage_url') final String? storageUrl,
    @JsonKey(name: 'video_type') final String videoType,
    @JsonKey(name: 'thumbnail_url') final String? thumbnailUrl,
    final String? duration,
    @JsonKey(name: 'published_at') final DateTime? publishedAt,
    @JsonKey(name: 'tradition_id') required final int traditionId,
    @JsonKey(name: 'is_active') required final bool isActive,
    @JsonKey(name: 'is_featured') final bool isFeatured,
    @JsonKey(name: 'is_liked') final bool isLiked,
    @JsonKey(name: 'likes_count') final int? likesCount,
    @JsonKey(name: 'comments_count') final int? commentsCount,
    final List<String>? tags,
    final String? category,
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
  @JsonKey(name: 'youtube_url')
  String get youtubeUrl;
  @override
  @JsonKey(name: 'storage_url')
  String? get storageUrl;
  @override
  @JsonKey(name: 'video_type')
  String get videoType; // 'youtube' or 'file'
  @override
  @JsonKey(name: 'thumbnail_url')
  String? get thumbnailUrl;
  @override
  String? get duration;
  @override
  @JsonKey(name: 'published_at')
  DateTime? get publishedAt;
  @override
  @JsonKey(name: 'tradition_id')
  int get traditionId;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'is_featured')
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
  String? get category;
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
