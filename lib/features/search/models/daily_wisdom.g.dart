// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_wisdom.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyWisdomImpl _$$DailyWisdomImplFromJson(Map<String, dynamic> json) =>
    _$DailyWisdomImpl(
      id: (json['id'] as num).toInt(),
      quote: json['quote'] as String,
      author: json['author'] as String?,
      chapterNumber: (json['chapter_number'] as num?)?.toInt(),
      verseNumber: (json['verse_number'] as num?)?.toInt(),
      backgroundImageUrl: json['background_image_url'] as String?,
      publishDate: DateTime.parse(json['active_date'] as String),
    );

Map<String, dynamic> _$$DailyWisdomImplToJson(_$DailyWisdomImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quote': instance.quote,
      'author': instance.author,
      'chapter_number': instance.chapterNumber,
      'verse_number': instance.verseNumber,
      'background_image_url': instance.backgroundImageUrl,
      'active_date': instance.publishDate.toIso8601String(),
    };
