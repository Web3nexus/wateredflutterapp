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
      backgroundImageUrl: json['background_image_url'] as String?,
      publishDate: DateTime.parse(json['publish_date'] as String),
    );

Map<String, dynamic> _$$DailyWisdomImplToJson(_$DailyWisdomImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quote': instance.quote,
      'author': instance.author,
      'background_image_url': instance.backgroundImageUrl,
      'publish_date': instance.publishDate.toIso8601String(),
    };
