// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TextCollectionImpl _$$TextCollectionImplFromJson(Map<String, dynamic> json) =>
    _$TextCollectionImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String?,
      coverImageUrl: json['cover_image_url'] as String?,
      traditionId: (json['traditionId'] as num?)?.toInt(),
      categoryId: (json['categoryId'] as num?)?.toInt(),
      order: (json['order'] as num?)?.toInt(),
      isActive: json['isActive'] as bool,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$TextCollectionImplToJson(
  _$TextCollectionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'slug': instance.slug,
  'description': instance.description,
  'cover_image_url': instance.coverImageUrl,
  'traditionId': instance.traditionId,
  'categoryId': instance.categoryId,
  'order': instance.order,
  'isActive': instance.isActive,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};
