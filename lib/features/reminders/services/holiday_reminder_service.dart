import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/reminders/models/holiday_reminder.dart';

final holidayReminderServiceProvider = Provider<HolidayReminderService>((ref) {
  return HolidayReminderService(ref.read(apiClientProvider));
});

class HolidayReminderService {
  final ApiClient _client;

  HolidayReminderService(this._client);

  Future<List<HolidayReminder>> getHolidayReminders() async {
    final response = await _client.get('holiday-reminders');
    final data = response.data['data'] as List;
    return data.map((e) => HolidayReminder.fromJson(e)).toList();
  }

  Future<void> saveHolidayReminders({
    int? holidayId,
    int? calendarDayId,
    required String holidayName,
    required List<Map<String, dynamic>> reminders,
  }) async {
    await _client.post('holiday-reminders', data: {
      'holiday_id': holidayId,
      'calendar_day_id': calendarDayId,
      'holiday_name': holidayName,
      'reminders': reminders,
    });
  }

  Future<void> deleteHolidayReminder(int id) async {
    await _client.delete('holiday-reminders/$id');
  }
}
