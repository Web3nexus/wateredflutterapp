// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'informational.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FaqImpl _$$FaqImplFromJson(Map<String, dynamic> json) => _$FaqImpl(
  id: (json['id'] as num).toInt(),
  question: json['question'] as String,
  answer: json['answer'] as String,
  category: json['category'] as String?,
  sortOrder: (json['sort_order'] as num).toInt(),
);

Map<String, dynamic> _$$FaqImplToJson(_$FaqImpl instance) => <String, dynamic>{
  'id': instance.id,
  'question': instance.question,
  'answer': instance.answer,
  'category': instance.category,
  'sort_order': instance.sortOrder,
};

_$UserGuideImpl _$$UserGuideImplFromJson(Map<String, dynamic> json) =>
    _$UserGuideImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      content: json['content'] as String?,
      type: json['type'] as String,
      videoUrl: json['video_url'] as String?,
      sortOrder: (json['sort_order'] as num).toInt(),
    );

Map<String, dynamic> _$$UserGuideImplToJson(_$UserGuideImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'type': instance.type,
      'video_url': instance.videoUrl,
      'sort_order': instance.sortOrder,
    };
