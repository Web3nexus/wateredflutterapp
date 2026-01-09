// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookmarkImpl _$$BookmarkImplFromJson(Map<String, dynamic> json) =>
    _$BookmarkImpl(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      bookmarkableType: json['bookmarkable_type'] as String,
      bookmarkableId: (json['bookmarkable_id'] as num).toInt(),
      bookmarkable: json['bookmarkable'] as Map<String, dynamic>?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$BookmarkImplToJson(_$BookmarkImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'bookmarkable_type': instance.bookmarkableType,
      'bookmarkable_id': instance.bookmarkableId,
      'bookmarkable': instance.bookmarkable,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
