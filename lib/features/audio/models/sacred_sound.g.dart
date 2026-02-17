// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sacred_sound.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SacredSoundImpl _$$SacredSoundImplFromJson(Map<String, dynamic> json) =>
    _$SacredSoundImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      filePath: json['file_path'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$$SacredSoundImplToJson(_$SacredSoundImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'file_path': instance.filePath,
      'type': instance.type,
    };
