import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wateredflutterapp/core/network/api_client.dart';
import 'package:wateredflutterapp/features/consultation/models/consultation_type.dart';
import 'package:wateredflutterapp/features/consultation/models/booking.dart';
import 'package:intl/intl.dart';

final bookingServiceProvider = Provider<BookingService>((ref) {
  return BookingService(ref.read(apiClientProvider));
});

class BookingService {
  final ApiClient _client;

  BookingService(this._client);

  Future<List<ConsultationType>> getConsultationTypes() async {
    try {
      final response = await _client.get('consultation-types');
      final List data = response.data['data'] ?? [];
      return data.map((e) => ConsultationType.fromJson(e)).toList();
    } catch (e) {
      throw 'Failed to load consultation types.';
    }
  }

  Future<List<Booking>> getMyBookings() async {
    try {
      final response = await _client.get('bookings');
      final List data = response.data['data'] ?? [];
      return data.map((e) => Booking.fromJson(e)).toList();
    } catch (e) {
      throw 'Failed to load bookings.';
    }
  }

  Future<void> createBooking({
    required int consultationTypeId,
    required DateTime scheduledAt,
    String? notes,
  }) async {
    try {
      // Format to MySQL DATETIME format manually or use toIso8601String()
      // Laravel casts: 'scheduled_at' => 'datetime' expects standard format.
      // DateFormat('yyyy-MM-dd HH:mm:ss').format(scheduledAt) is safer for MySQL.
      await _client.post('bookings', data: {
        'consultation_type_id': consultationTypeId,
        'scheduled_at': DateFormat('yyyy-MM-dd HH:mm:ss').format(scheduledAt),
        'notes': notes,
      });
    } catch (e) {
      throw 'Failed to create booking.';
    }
  }
}
