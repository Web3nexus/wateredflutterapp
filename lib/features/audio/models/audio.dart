import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio.freezed.dart';
part 'audio.g.dart';

@freezed
class Audio with _$Audio {
  const factory Audio({
    required int id,
    required String title,
    String? description,
    required String audioUrl,
    String? thumbnailUrl,
    String? duration,
    String? author,
    DateTime? publishedAt,
    required int traditionId,
    required bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Audio;

  factory Audio.fromJson(Map<String, dynamic> json) => _$AudioFromJson(json);
}
