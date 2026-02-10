import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/calendar/models/calendar_month.dart';
import 'package:Watered/features/calendar/models/calendar_day.dart';
import 'package:Watered/features/events/models/event.dart';

final calendarServiceProvider = Provider<CalendarService>((ref) {
  return CalendarService(ref.read(apiClientProvider));
});

class CalendarService {
  final ApiClient _client;

  CalendarService(this._client);

  Future<List<CalendarMonth>> getFullCalendar() async {
    final response = await _client.get('calendar');
    final List data = response.data['data'];
    return data.map((m) => CalendarMonth.fromJson(m)).toList();
  }

  Future<CalendarMonth> getMonth(int number) async {
    final response = await _client.get('calendar/month/$number');
    return CalendarMonth.fromJson(response.data['data']);
  }

  Future<List<CalendarDay>> getSpecialDays() async {
    final response = await _client.get('calendar/special-days');
    final List data = response.data['data'];
    return data.map((d) => CalendarDay.fromJson(d)).toList();
  }

  Future<Map<String, dynamic>> getToday() async {
    final response = await _client.get('calendar/today');
    return response.data;
  }

  Future<List<Event>> getUpcomingEvents() async {
    final response = await _client.get('events');
    final List data = response.data['data'];
    return data.map((e) => Event.fromJson(e)).toList();
  }
}
