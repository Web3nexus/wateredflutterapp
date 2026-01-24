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

  Future<List<Event>> getEvents({int page = 1}) async {
    final response = await _client.get('events', queryParameters: {'page': page});
    final data = response.data['data'] as List;
    return data.map((e) => Event.fromJson(e)).toList();
  }

  Future<void> registerForEvent(int eventId) async {
    await _client.post('events/$eventId/register');
  }

  Future<void> cancelRegistration(int eventId) async {
    await _client.delete('events/$eventId/register');
  }
}
