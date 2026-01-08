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
    required int collectionId,
    int? order,
    required bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Chapter;

  factory Chapter.fromJson(Map<String, dynamic> json) =>
      _$ChapterFromJson(json);
}
