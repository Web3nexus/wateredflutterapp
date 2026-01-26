// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VideoImpl _$$VideoImplFromJson(Map<String, dynamic> json) => _$VideoImpl(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String?,
  youtubeUrl: json['youtubeUrl'] as String,
  storageUrl: json['storageUrl'] as String?,
  videoType: json['videoType'] as String? ?? 'youtube',
  thumbnailUrl: json['thumbnailUrl'] as String?,
  duration: json['duration'] as String?,
  publishedAt: DateTime.parse(json['publishedAt'] as String),
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

Map<String, dynamic> _$$VideoImplToJson(_$VideoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'youtubeUrl': instance.youtubeUrl,
      'storageUrl': instance.storageUrl,
      'videoType': instance.videoType,
      'thumbnailUrl': instance.thumbnailUrl,
      'duration': instance.duration,
      'publishedAt': instance.publishedAt.toIso8601String(),
      'traditionId': instance.traditionId,
      'isActive': instance.isActive,
      'is_liked': instance.isLiked,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
