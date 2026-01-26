import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio.freezed.dart';
part 'audio.g.dart';

@freezed
class Audio with _$Audio {
  const factory Audio({
    required int id,
    required String title,
    String? description,
    @JsonKey(name: 'audioUrl') required String audioUrl,
    @JsonKey(name: 'thumbnailUrl') String? thumbnailUrl,
    @JsonKey(name: 'duration') String? duration,
    String? author,
    @JsonKey(name: 'publishedAt') DateTime? publishedAt,
    @JsonKey(name: 'traditionId') required int traditionId,
    @JsonKey(name: 'isActive') required bool isActive,
    @JsonKey(name: 'is_liked') @Default(false) bool isLiked,
    @JsonKey(name: 'createdAt') DateTime? createdAt,
    @JsonKey(name: 'updatedAt') DateTime? updatedAt,
  }) = _Audio;

  factory Audio.fromJson(Map<String, dynamic> json) => _$AudioFromJson(json);
}
