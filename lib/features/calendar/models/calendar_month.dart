import 'calendar_day.dart';

class CalendarMonth {
  final int id;
  final int number;
  final String standardName;
  final String? customName;
  final String? year;
  final String? season;
  final String? deities;
  final String? gregorianReference;
  final String? description;
  final List<CalendarDay>? days;

  CalendarMonth({
    required this.id,
    required this.number,
    required this.standardName,
    this.customName,
    this.year,
    this.season,
    this.deities,
    this.gregorianReference,
    this.description,
    this.days,
  });

  factory CalendarMonth.fromJson(Map<String, dynamic> json) {
    return CalendarMonth(
      id: json['id'],
      number: json['number'],
      standardName: json['standard_name'],
      customName: json['custom_name'],
      year: json['year'],
      season: json['season'],
      deities: json['deities'],
      gregorianReference: json['gregorian_reference'],
      description: json['description'],
      days: json['days'] != null
          ? (json['days'] as List).map((i) => CalendarDay.fromJson(i)).toList()
          : null,
    );
  }

  String get displayName => customName ?? standardName;
}
