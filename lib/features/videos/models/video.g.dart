// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VideoImpl _$$VideoImplFromJson(Map<String, dynamic> json) => _$VideoImpl(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String?,
  youtubeUrl: json['youtube_url'] as String,
  storageUrl: json['storage_url'] as String?,
  videoType: json['video_type'] as String? ?? 'youtube',
  thumbnailUrl: json['thumbnail_url'] as String?,
  duration: json['duration'] as String?,
  publishedAt: json['published_at'] == null
      ? null
      : DateTime.parse(json['published_at'] as String),
  traditionId: (json['tradition_id'] as num).toInt(),
  isActive: json['is_active'] as bool,
  isFeatured: json['is_featured'] as bool? ?? false,
  isLiked: json['is_liked'] as bool? ?? false,
  likesCount: (json['likes_count'] as num?)?.toInt(),
  commentsCount: (json['comments_count'] as num?)?.toInt(),
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  category: json['category'] as String?,
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
      'youtube_url': instance.youtubeUrl,
      'storage_url': instance.storageUrl,
      'video_type': instance.videoType,
      'thumbnail_url': instance.thumbnailUrl,
      'duration': instance.duration,
      'published_at': instance.publishedAt?.toIso8601String(),
      'tradition_id': instance.traditionId,
      'is_active': instance.isActive,
      'is_featured': instance.isFeatured,
      'is_liked': instance.isLiked,
      'likes_count': instance.likesCount,
      'comments_count': instance.commentsCount,
      'tags': instance.tags,
      'category': instance.category,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
