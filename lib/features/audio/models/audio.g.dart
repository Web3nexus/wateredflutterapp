// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AudioImpl _$$AudioImplFromJson(Map<String, dynamic> json) => _$AudioImpl(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String?,
  description: json['description'] as String?,
  audioUrl: json['audio_url'] as String?,
  thumbnailUrl: json['thumbnail_url'] as String?,
  duration: json['duration'] as String?,
  author: json['author'] as String?,
  publishedAt: json['published_at'] == null
      ? null
      : DateTime.parse(json['published_at'] as String),
  traditionId: (json['tradition_id'] as num?)?.toInt(),
  isActive: json['is_active'] as bool? ?? true,
  isFeatured: json['is_featured'] as bool? ?? false,
  isLiked: json['is_liked'] as bool? ?? false,
  likesCount: (json['likes_count'] as num?)?.toInt(),
  commentsCount: (json['comments_count'] as num?)?.toInt(),
  category: json['category'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$$AudioImplToJson(_$AudioImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'audio_url': instance.audioUrl,
      'thumbnail_url': instance.thumbnailUrl,
      'duration': instance.duration,
      'author': instance.author,
      'published_at': instance.publishedAt?.toIso8601String(),
      'tradition_id': instance.traditionId,
      'is_active': instance.isActive,
      'is_featured': instance.isFeatured,
      'is_liked': instance.isLiked,
      'likes_count': instance.likesCount,
      'comments_count': instance.commentsCount,
      'category': instance.category,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
