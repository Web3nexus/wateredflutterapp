class Ritual {
  final int id;
  final String title;
  final String? description;
  final String? content;
  final List<String>? mediaUrls;

  final String? category;
  final String? timeOfDay;
  final int? traditionId;

  Ritual({
    required this.id,
    required this.title,
    this.description,
    this.content,
    this.mediaUrls,
    this.category,
    this.timeOfDay,
    this.traditionId,
  });

  factory Ritual.fromJson(Map<String, dynamic> json) {
    return Ritual(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      content: json['content'],
      mediaUrls: json['media_urls'] != null ? List<String>.from(json['media_urls']) : null,
      category: json['category'],
      timeOfDay: json['time_of_day'],
      traditionId: json['tradition_id'],
    );
  }
}
