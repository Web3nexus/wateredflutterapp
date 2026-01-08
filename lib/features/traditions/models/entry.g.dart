// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EntryImpl _$$EntryImplFromJson(Map<String, dynamic> json) => _$EntryImpl(
  id: (json['id'] as num).toInt(),
  number: (json['number'] as num).toInt(),
  text: json['text'] as String,
  chapterId: (json['chapterId'] as num).toInt(),
  order: (json['order'] as num?)?.toInt(),
  metadata: json['metadata'] as Map<String, dynamic>?,
  isActive: json['isActive'] as bool,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  translations: (json['translations'] as List<dynamic>?)
      ?.map((e) => EntryTranslation.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$EntryImplToJson(_$EntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'text': instance.text,
      'chapterId': instance.chapterId,
      'order': instance.order,
      'metadata': instance.metadata,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'translations': instance.translations,
    };

_$EntryTranslationImpl _$$EntryTranslationImplFromJson(
  Map<String, dynamic> json,
) => _$EntryTranslationImpl(
  id: (json['id'] as num).toInt(),
  entryId: (json['entryId'] as num).toInt(),
  languageCode: json['languageCode'] as String,
  text: json['text'] as String,
  translatorName: json['translatorName'] as String?,
  notes: json['notes'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$EntryTranslationImplToJson(
  _$EntryTranslationImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'entryId': instance.entryId,
  'languageCode': instance.languageCode,
  'text': instance.text,
  'translatorName': instance.translatorName,
  'notes': instance.notes,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};
