class Event {
  final int id;
  final String title;
  final String? slug;
  final String? description;
  final DateTime startTime;
  final DateTime? endTime;
  final DateTime? eventDate;
  final String? eventTime;
  final String? location;
  final String? imageUrl;
  final String? bannerImage;
  final bool isPaid;
  final double? price;
  final bool isRegistered;
  final bool hasReminder;

  final String? category;
  final String? recurrence;
  final int? traditionId;
  final String? culturalOrigin;

  Event({
    required this.id,
    required this.title,
    this.slug,
    this.description,
    required this.startTime,
    this.endTime,
    this.eventDate,
    this.eventTime,
    this.location,
    this.imageUrl,
    this.bannerImage,
    this.isPaid = false,
    this.price,
    this.isRegistered = false,
    this.hasReminder = false,
    this.category,
    this.recurrence,
    this.traditionId,
    this.culturalOrigin,
  });

  String? get effectiveImageUrl => bannerImage ?? imageUrl;

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      description: json['description'],
      startTime: DateTime.parse(json['start_time']),
      endTime: json['end_time'] != null ? DateTime.parse(json['end_time']) : null,
      eventDate: json['event_date'] != null ? DateTime.parse(json['event_date']) : null,
      eventTime: json['event_time'],
      location: json['location'],
      imageUrl: json['image_url'],
      bannerImage: json['banner_image'],
      isPaid: json['is_paid'] ?? false,
      price: json['price'] != null ? double.tryParse(json['price'].toString()) : null,
      isRegistered: json['is_registered'] ?? false,
      hasReminder: json['has_reminder'] ?? false,
      category: json['category'],
      recurrence: json['recurrence'],
      traditionId: json['tradition_id'],
      culturalOrigin: json['cultural_origin'],
    );
  }
}
