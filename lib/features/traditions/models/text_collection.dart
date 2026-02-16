import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_collection.freezed.dart';
part 'text_collection.g.dart';

/// TextCollection model (similar to Book in Bible/Quran structure)
@freezed
class TextCollection with _$TextCollection {
  const factory TextCollection({
    required int id,
    required String name,
    required String slug,
    String? description,
    @JsonKey(name: 'cover_image_url') String? coverImageUrl,
    @JsonKey(name: 'tradition_id') int? traditionId,
    @JsonKey(name: 'category_id') int? categoryId,
    int? order,
    @JsonKey(name: 'is_active') required bool isActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _TextCollection;

  factory TextCollection.fromJson(Map<String, dynamic> json) =>
      _$TextCollectionFromJson(json);
}
