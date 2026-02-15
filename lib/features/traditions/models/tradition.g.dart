// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tradition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TraditionImpl _$$TraditionImplFromJson(Map<String, dynamic> json) =>
    _$TraditionImpl(
      id: (json['id'] as num).toInt(),
      name: const TranslatableStringConverter().fromJson(json['name']),
      slug: json['slug'] as String,
      description: const TranslatableStringConverter().fromJson(
        json['description'],
      ),
      imageUrl: json['background_image'] as String?,
      isActive: json['is_active'] as bool,
      languageId: (json['language_id'] as num?)?.toInt(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$TraditionImplToJson(_$TraditionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': const TranslatableStringConverter().toJson(instance.name),
      'slug': instance.slug,
      'description': _$JsonConverterToJson<dynamic, String>(
        instance.description,
        const TranslatableStringConverter().toJson,
      ),
      'background_image': instance.imageUrl,
      'is_active': instance.isActive,
      'language_id': instance.languageId,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
