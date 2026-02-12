import 'package:freezed_annotation/freezed_annotation.dart';

part 'video.freezed.dart';
part 'video.g.dart';

@freezed
class Video with _$Video {
  const factory Video({
    required int id,
    required String title,
    String? description,
    @JsonKey(name: 'youtube_url') String? youtubeUrl,
    @JsonKey(name: 'storage_url') String? storageUrl,
    @JsonKey(name: 'video_type') @Default('youtube') String videoType, // 'youtube' or 'file'
    @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
    String? duration,
    @JsonKey(name: 'published_at') DateTime? publishedAt,
    @JsonKey(name: 'tradition_id') int? traditionId,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'is_featured') @Default(false) bool isFeatured,
    @JsonKey(name: 'is_liked') @Default(false) bool isLiked,
    @JsonKey(name: 'likes_count') int? likesCount,
    @JsonKey(name: 'comments_count') int? commentsCount,
    List<String>? tags,
    String? category,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Video;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);
}
