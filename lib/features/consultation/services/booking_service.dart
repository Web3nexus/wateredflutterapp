import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/consultation/models/consultation_type.dart';
import 'package:Watered/features/consultation/models/booking.dart';

final bookingServiceProvider = Provider<BookingService>((ref) {
  return BookingService(ref.read(apiClientProvider));
});

class BookingService {
  final ApiClient _client;

  BookingService(this._client);

  Future<List<ConsultationType>> getConsultationTypes() async {
    final response = await _client.get('consultation-types');
    final data = response.data['data'] as List;
    return data.map((e) => ConsultationType.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> createBooking({
    required int consultationTypeId,
    required DateTime scheduledAt,
    String? notes,
  }) async {
    final response = await _client.post('bookings', data: {
      'consultation_type_id': consultationTypeId,
      'start_time': scheduledAt.toIso8601String(),
      'notes': notes,
    });
    return response.data;
  }

  Future<List<Booking>> getMyBookings() async {
    final response = await _client.get('bookings');
    final data = response.data['data'] as List;
    return data.map((e) => Booking.fromJson(e)).toList();
  }
}
