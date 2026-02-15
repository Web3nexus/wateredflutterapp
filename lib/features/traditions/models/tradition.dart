import 'package:freezed_annotation/freezed_annotation.dart';

part 'tradition.freezed.dart';
part 'tradition.g.dart';

class TranslatableStringConverter implements JsonConverter<String, dynamic> {
  const TranslatableStringConverter();

  @override
  String fromJson(dynamic json) {
    if (json is Map) {
      return json['en']?.toString() ?? json.values.first?.toString() ?? '';
    }
    return json?.toString() ?? '';
  }

  @override
  dynamic toJson(String object) => object;
}

/// Tradition model (e.g., Buddhism, Hinduism, Christianity)
@freezed
class Tradition with _$Tradition {
  const factory Tradition({
    required int id,
    @TranslatableStringConverter() required String name,
    required String slug,
    @TranslatableStringConverter() String? description,
    @JsonKey(name: 'background_image') String? imageUrl,
    @JsonKey(name: 'is_active') required bool isActive,
    @JsonKey(name: 'language_id') int? languageId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _Tradition;

  factory Tradition.fromJson(Map<String, dynamic> json) =>
      _$TraditionFromJson(json);
}

