import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:Watered/features/consultation/models/consultation_type.dart';

part 'booking.freezed.dart';
part 'booking.g.dart';

@freezed
class Booking with _$Booking {
  const factory Booking({
    required int id,
    @JsonKey(name: 'consultation_type_id') required int consultationTypeId,
    @JsonKey(name: 'start_time') required DateTime scheduledAt,
    required String status,
    String? notes,
    @JsonKey(name: 'consultation_type') ConsultationType? consultationType,
  }) = _Booking;

  factory Booking.fromJson(Map<String, dynamic> json) => _$BookingFromJson(json);
}
