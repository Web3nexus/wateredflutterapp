import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio.freezed.dart';
part 'audio.g.dart';

@freezed
class Audio with _$Audio {
  const factory Audio({
    required int id,
    String? title,
    String? description,
    @JsonKey(name: 'audio_url') String? audioUrl,
    @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
    @JsonKey(name: 'duration') String? duration,
    String? author,
    @JsonKey(name: 'published_at') DateTime? publishedAt,
    @JsonKey(name: 'tradition_id') int? traditionId,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'is_featured') @Default(false) bool isFeatured,
    @JsonKey(name: 'is_liked') @Default(false) bool isLiked,
    @JsonKey(name: 'likes_count') int? likesCount,
    @JsonKey(name: 'comments_count') int? commentsCount,
    String? category,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _Audio;

  factory Audio.fromJson(Map<String, dynamic> json) => _$AudioFromJson(json);
}
