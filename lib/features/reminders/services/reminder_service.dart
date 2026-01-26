import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/reminders/models/reminder.dart';

final reminderServiceProvider = Provider<ReminderService>((ref) {
  return ReminderService(ref.read(apiClientProvider));
});

class ReminderService {
  final ApiClient _client;

  ReminderService(this._client);

  Future<List<Reminder>> getReminders() async {
    final response = await _client.get('reminders');
    final data = response.data['data'] as List;
    return data.map((e) => Reminder.fromJson(e)).toList();
  }

  Future<void> saveReminder(String title, TimeOfDay time, List<String> days, {String? soundPath}) async {
    final timeStr = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:00';
    
    await _client.post('reminders', data: {
      'title': title,
      'time': timeStr,
      'days': days,
      'is_active': true,
      'sound_path': soundPath,
    });
  }
  
  Future<void> updateReminder(int id, {bool? isActive, String? soundPath}) async {
       await _client.put('reminders/$id', data: {
      if (isActive != null) 'is_active': isActive,
      if (soundPath != null) 'sound_path': soundPath,
    });
  }

  Future<void> deleteReminder(int id) async {
    await _client.delete('reminders/$id');
  }
}
