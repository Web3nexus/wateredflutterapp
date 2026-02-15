import 'package:freezed_annotation/freezed_annotation.dart';

part 'temple.freezed.dart';
part 'temple.g.dart';

class DoubleConverter implements JsonConverter<double?, dynamic> {
  const DoubleConverter();

  @override
  double? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is num) return json.toDouble();
    if (json is String) return double.tryParse(json);
    return null;
  }

  @override
  dynamic toJson(double? object) => object;
}

@freezed
class Temple with _$Temple {
  const factory Temple({
    required int id,
    required String name,
    String? description,
    String? address,
    @DoubleConverter() double? latitude,
    @DoubleConverter() double? longitude,
    @JsonKey(name: 'image_url') String? imageUrl,
    @Default(0.0) double? distance, // For near me results
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _Temple;

  factory Temple.fromJson(Map<String, dynamic> json) => _$TempleFromJson(json);
}
