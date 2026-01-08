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
    required int traditionId,
    int? categoryId,
    int? order,
    required bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _TextCollection;

  factory TextCollection.fromJson(Map<String, dynamic> json) =>
      _$TextCollectionFromJson(json);
}
