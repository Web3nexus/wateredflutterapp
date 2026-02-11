// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupImpl _$$GroupImplFromJson(Map<String, dynamic> json) => _$GroupImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  type: $enumDecode(_$GroupTypeEnumMap, json['type']),
  description: json['description'] as String?,
  memberCount: (json['member_count'] as num?)?.toInt() ?? 0,
  iconUrl: json['icon_url'] as String?,
  coverImageUrl: json['cover_image_url'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  isJoined: json['isJoined'] as bool? ?? false,
);

Map<String, dynamic> _$$GroupImplToJson(_$GroupImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$GroupTypeEnumMap[instance.type]!,
      'description': instance.description,
      'member_count': instance.memberCount,
      'icon_url': instance.iconUrl,
      'cover_image_url': instance.coverImageUrl,
      'created_at': instance.createdAt?.toIso8601String(),
      'isJoined': instance.isJoined,
    };

const _$GroupTypeEnumMap = {
  GroupType.country: 'country',
  GroupType.tribe: 'tribe',
};
