import 'package:freezed_annotation/freezed_annotation.dart';

part 'entry.freezed.dart';
part 'entry.g.dart';

/// Entry model (verse/passage within a chapter)
@freezed
class Entry with _$Entry {
  const factory Entry({
    required int id,
    required int number,
    required String text,
    required int chapterId,
    int? order,
    Map<String, dynamic>? metadata,
    required bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    // Relationship data
    List<EntryTranslation>? translations,
  }) = _Entry;

  factory Entry.fromJson(Map<String, dynamic> json) =>
      _$EntryFromJson(json);
}

/// EntryTranslation model for multi-language support
@freezed
class EntryTranslation with _$EntryTranslation {
  const factory EntryTranslation({
    required int id,
    required int entryId,
    required String languageCode,
    required String text,
    String? translatorName,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _EntryTranslation;

  factory EntryTranslation.fromJson(Map<String, dynamic> json) =>
      _$EntryTranslationFromJson(json);
}
