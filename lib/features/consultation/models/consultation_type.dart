import 'package:freezed_annotation/freezed_annotation.dart';

part 'consultation_type.freezed.dart';
part 'consultation_type.g.dart';

@freezed
class ConsultationType with _$ConsultationType {
  const factory ConsultationType({
    required int id,
    required String name,
    String? description,
    @JsonKey(name: 'duration_minutes') required int durationMinutes,
    required int price, // cents
    @JsonKey(name: 'image_url') String? imageUrl,
  }) = _ConsultationType;

  factory ConsultationType.fromJson(Map<String, dynamic> json) => _$ConsultationTypeFromJson(json);
}
