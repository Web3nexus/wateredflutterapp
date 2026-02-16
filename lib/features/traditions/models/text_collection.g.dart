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
      traditionId: (json['tradition_id'] as num?)?.toInt(),
      categoryId: (json['category_id'] as num?)?.toInt(),
      order: (json['order'] as num?)?.toInt(),
      isActive: json['is_active'] as bool,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$TextCollectionImplToJson(
  _$TextCollectionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'slug': instance.slug,
  'description': instance.description,
  'cover_image_url': instance.coverImageUrl,
  'tradition_id': instance.traditionId,
  'category_id': instance.categoryId,
  'order': instance.order,
  'is_active': instance.isActive,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};
