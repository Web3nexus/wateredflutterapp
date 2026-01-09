// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consultation_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConsultationTypeImpl _$$ConsultationTypeImplFromJson(
  Map<String, dynamic> json,
) => _$ConsultationTypeImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String?,
  durationMinutes: (json['duration_minutes'] as num).toInt(),
  price: (json['price'] as num).toInt(),
  imageUrl: json['image_url'] as String?,
);

Map<String, dynamic> _$$ConsultationTypeImplToJson(
  _$ConsultationTypeImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'duration_minutes': instance.durationMinutes,
  'price': instance.price,
  'image_url': instance.imageUrl,
};
