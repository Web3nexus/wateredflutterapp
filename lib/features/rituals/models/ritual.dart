class Ritual {
  final int id;
  final String title;
  final String? description;
  final String? content;
  final List<String>? mediaUrls;

  final String? category;
  final String? timeOfDay;
  final int? traditionId;
  final bool isSacredDaily;

  Ritual({
    required this.id,
    required this.title,
    this.description,
    this.content,
    this.mediaUrls,
    this.category,
    this.timeOfDay,
    this.traditionId,
    this.isSacredDaily = false,
  });

  factory Ritual.fromJson(Map<String, dynamic> json) {
    return Ritual(
      id: json['id'] is num ? (json['id'] as num).toInt() : 0,
      title: json['title']?.toString() ?? 'Untitled Ritual',
      description: json['description']?.toString(),
      content: json['content']?.toString(),
      mediaUrls: json['media_urls'] is List 
          ? List<String>.from(json['media_urls']) 
          : [],
      category: json['category']?.toString(),
      timeOfDay: json['time_of_day']?.toString(),
      traditionId: json['tradition_id'] is num ? (json['tradition_id'] as num).toInt() : null,
      isSacredDaily: json['is_sacred_daily'] == true || json['is_sacred_daily'] == 1,
    );
  }

  DateTime? get scheduledTime {
    if (timeOfDay == null) return null;
    try {
      final parts = timeOfDay!.split(':');
      final now = DateTime.now();
      return DateTime(now.year, now.month, now.day, int.parse(parts[0]), int.parse(parts[1]));
    } catch (e) {
      return null;
    }
  }

  bool get isPast {
    final time = scheduledTime;
    if (time == null) return false;
    return DateTime.now().isAfter(time);
  }

  String get formattedTime {
    if (timeOfDay == null) return '--:--';
    return timeOfDay!;
  }
}
