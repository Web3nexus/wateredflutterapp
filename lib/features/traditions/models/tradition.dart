import 'package:freezed_annotation/freezed_annotation.dart';

part 'tradition.freezed.dart';
part 'tradition.g.dart';

/// Tradition model (e.g., Buddhism, Hinduism, Christianity)
@freezed
class Tradition with _$Tradition {
  const factory Tradition({
    required int id,
    required String name,
    required String slug,
    String? description,
    @JsonKey(name: 'background_image') String? imageUrl,
    @JsonKey(name: 'is_active') required bool isActive,
    @JsonKey(name: 'language_id') int? languageId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _Tradition;

  factory Tradition.fromJson(Map<String, dynamic> json) {
    // Handle translatable description field
    final description = json['description'];
    String? descriptionText;
    if (description is Map) {
      // If description is a translatable object like {"en": "text"}
      descriptionText = description['en'] as String?;
    } else if (description is String) {
      descriptionText = description;
    }
    
    // Create a modified JSON with the extracted description
    final modifiedJson = Map<String, dynamic>.from(json);
    modifiedJson['description'] = descriptionText;
    
    return _$TraditionFromJson(modifiedJson);
  }
}

