import 'package:flutter/material.dart';

class Reminder {
  final int? id;
  final String title;
  final TimeOfDay time;
  final List<String> days;
  final bool isActive;
  final String? soundPath;

  Reminder({
    this.id,
    required this.title,
    required this.time,
    this.days = const [],
    this.isActive = true,
    this.soundPath,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) {
    // Parse time "HH:MM:SS"
    final timeParts = json['time'].toString().split(':');
    final time = TimeOfDay(hour: int.parse(timeParts[0]), minute: int.parse(timeParts[1]));

    return Reminder(
      id: json['id'],
      title: json['title'],
      time: time,
      days: json['days'] != null ? List<String>.from(json['days']) : [],
      isActive: json['is_active'] ?? true,
      soundPath: json['sound_path'],
    );
  }
}
