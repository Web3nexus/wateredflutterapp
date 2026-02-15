// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SearchResultImpl _$$SearchResultImplFromJson(Map<String, dynamic> json) =>
    _$SearchResultImpl(
      audio: json['audio'] as List<dynamic>? ?? const [],
      products:
          (json['products'] as List<dynamic>?)
              ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      temples:
          (json['temples'] as List<dynamic>?)
              ?.map((e) => Temple.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      traditions: json['traditions'] as List<dynamic>? ?? const [],
    );

Map<String, dynamic> _$$SearchResultImplToJson(_$SearchResultImpl instance) =>
    <String, dynamic>{
      'audio': instance.audio,
      'products': instance.products,
      'temples': instance.temples,
      'traditions': instance.traditions,
    };
