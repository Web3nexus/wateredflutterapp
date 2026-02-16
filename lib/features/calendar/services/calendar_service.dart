import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/calendar/models/calendar_month.dart';
import 'package:Watered/features/calendar/models/calendar_day.dart';
import 'package:Watered/features/events/models/event.dart';
import 'package:Watered/features/reminders/models/holiday.dart';

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
    // 1. Fetch backend events - Use 'all' filter to see past and future on the calendar
    final eventResponse = await _client.get('events?filter=all');
    final List eventData = eventResponse.data['data'];
    final List<Event> events = eventData.map((e) => Event.fromJson(e)).toList();

    // 2. Fetch backend holidays and map them to Events
    try {
      final holidayResponse = await _client.get('holidays');
      final List holidayData = holidayResponse.data['data'];
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      for (var json in holidayData) {
        final holiday = Holiday.fromJson(json);
        
        // Project holiday to current or next year
        var holidayDate = DateTime(holiday.date.year, holiday.date.month, holiday.date.day);
        var projectedDate = DateTime(now.year, holidayDate.month, holidayDate.day);
        if (projectedDate.isBefore(today)) {
          projectedDate = DateTime(now.year + 1, holidayDate.month, holidayDate.day);
        }

        events.add(Event(
          id: -holiday.id, // Use negative ID for holidays
          title: holiday.name,
          description: holiday.description,
          startTime: projectedDate,
          category: 'Holiday',
        ));
      }
    } catch (e) {
      print('Error fetching holidays for calendar: $e');
    }

    // Sort combined list by date
    events.sort((a, b) => a.startTime.compareTo(b.startTime));

    return events;
  }
}
