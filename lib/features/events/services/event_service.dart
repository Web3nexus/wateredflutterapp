import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/events/models/event.dart';

final eventServiceProvider = Provider<EventService>((ref) {
  return EventService(ref.read(apiClientProvider));
});

class EventService {
  final ApiClient _client;

  EventService(this._client);

  Future<List<Event>> getEvents({
    int page = 1,
    String? category,
    String? recurrence,
    int? traditionId,
    String? filter,
  }) async {
    final Map<String, dynamic> queryParams = {'page': page};
    if (category != null && category != 'All') queryParams['category'] = category;
    if (recurrence != null && recurrence != 'All') queryParams['recurrence'] = recurrence;
    if (traditionId != null) queryParams['tradition_id'] = traditionId;
    if (filter != null) queryParams['filter'] = filter;

    final response = await _client.get('events', queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((e) => Event.fromJson(e)).toList();
  }

  Future<void> registerForEvent(int eventId) async {
    await _client.post('events/$eventId/register');
  }

  Future<void> cancelRegistration(int eventId) async {
    await _client.delete('events/$eventId/register');
  }

  Future<void> saveReminder(int eventId, {DateTime? reminderTime}) async {
    await _client.post(
      'events/$eventId/reminder',
      data: reminderTime != null ? {'reminder_time': reminderTime.toIso8601String()} : null,
    );
  }

  Future<void> removeReminder(int eventId) async {
    await _client.delete('events/$eventId/reminder');
  }

  Future<Map<String, dynamic>> initiatePayment(int eventId) async {
    final response = await _client.post('events/$eventId/payment');
    return response.data['data'];
  }
}
