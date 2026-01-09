import 'package:freezed_annotation/freezed_annotation.dart';

part 'video.freezed.dart';
part 'video.g.dart';

@freezed
class Video with _$Video {
  const factory Video({
    required int id,
    required String title,
    String? description,
    required String youtubeUrl,
    String? storageUrl,
    @Default('youtube') String videoType, // 'youtube' or 'file'
    String? thumbnailUrl,
    String? duration,
    required DateTime publishedAt,
    required int traditionId,
    required bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Video;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);
}
