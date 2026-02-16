import 'package:freezed_annotation/freezed_annotation.dart';

part 'chapter.freezed.dart';
part 'chapter.g.dart';

/// Chapter model within a TextCollection
@freezed
class Chapter with _$Chapter {
  const factory Chapter({
    required int id,
    required String name,
    required int number,
    String? description,
    @JsonKey(name: 'collection_id') required int collectionId,
    int? order,
    @JsonKey(name: 'is_active') required bool isActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _Chapter;

  factory Chapter.fromJson(Map<String, dynamic> json) =>
      _$ChapterFromJson(json);
}
