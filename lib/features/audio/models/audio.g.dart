// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AudioImpl _$$AudioImplFromJson(Map<String, dynamic> json) => _$AudioImpl(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String?,
  audioUrl: json['audioUrl'] as String,
  thumbnailUrl: json['thumbnailUrl'] as String?,
  duration: json['duration'] as String?,
  author: json['author'] as String?,
  publishedAt: json['publishedAt'] == null
      ? null
      : DateTime.parse(json['publishedAt'] as String),
  traditionId: (json['traditionId'] as num).toInt(),
  isActive: json['isActive'] as bool,
  isLiked: json['is_liked'] as bool? ?? false,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$AudioImplToJson(_$AudioImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'audioUrl': instance.audioUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'duration': instance.duration,
      'author': instance.author,
      'publishedAt': instance.publishedAt?.toIso8601String(),
      'traditionId': instance.traditionId,
      'isActive': instance.isActive,
      'is_liked': instance.isLiked,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
