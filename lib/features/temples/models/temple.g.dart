// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temple.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TempleImpl _$$TempleImplFromJson(Map<String, dynamic> json) => _$TempleImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String?,
  address: json['address'] as String?,
  latitude: const DoubleConverter().fromJson(json['latitude']),
  longitude: const DoubleConverter().fromJson(json['longitude']),
  imageUrl: json['image_url'] as String?,
  distance: (json['distance'] as num?)?.toDouble() ?? 0.0,
  isActive: json['is_active'] as bool? ?? true,
);

Map<String, dynamic> _$$TempleImplToJson(_$TempleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'address': instance.address,
      'latitude': const DoubleConverter().toJson(instance.latitude),
      'longitude': const DoubleConverter().toJson(instance.longitude),
      'image_url': instance.imageUrl,
      'distance': instance.distance,
      'is_active': instance.isActive,
    };
