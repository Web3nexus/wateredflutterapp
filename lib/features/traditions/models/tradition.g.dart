// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tradition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TraditionImpl _$$TraditionImplFromJson(Map<String, dynamic> json) =>
    _$TraditionImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      isActive: json['isActive'] as bool,
      languageId: (json['languageId'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$TraditionImplToJson(_$TraditionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'isActive': instance.isActive,
      'languageId': instance.languageId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
