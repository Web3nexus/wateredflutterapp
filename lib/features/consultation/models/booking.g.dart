// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookingImpl _$$BookingImplFromJson(Map<String, dynamic> json) =>
    _$BookingImpl(
      id: (json['id'] as num).toInt(),
      consultationTypeId: (json['consultation_type_id'] as num).toInt(),
      scheduledAt: DateTime.parse(json['start_time'] as String),
      status: json['status'] as String,
      notes: json['notes'] as String?,
      consultationType: json['consultation_type'] == null
          ? null
          : ConsultationType.fromJson(
              json['consultation_type'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$$BookingImplToJson(_$BookingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'consultation_type_id': instance.consultationTypeId,
      'start_time': instance.scheduledAt.toIso8601String(),
      'status': instance.status,
      'notes': instance.notes,
      'consultation_type': instance.consultationType,
    };
