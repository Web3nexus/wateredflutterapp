import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/consultation/models/consultation_type.dart';

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

  Future<Map<String, dynamic>> createBooking(int typeId, DateTime startTime, String? notes) async {
    final response = await _client.post('bookings', data: {
      'consultation_type_id': typeId,
      'start_time': startTime.toIso8601String(),
      'notes': notes,
    });
    return response.data;
  }

  // Future: getMyBookings()
}
