import 'package:freezed_annotation/freezed_annotation.dart';

part 'temple.freezed.dart';
part 'temple.g.dart';

@freezed
class Temple with _$Temple {
  const factory Temple({
    required int id,
    required String name,
    String? description,
    String? address,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'image_url') String? imageUrl,
    @Default(0.0) double? distance, // For near me results
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _Temple;

  factory Temple.fromJson(Map<String, dynamic> json) => _$TempleFromJson(json);
}
