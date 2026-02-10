class Event {
  final int id;
  final String title;
  final String? description;
  final DateTime startTime;
  final DateTime? endTime;
  final String? location;
  final String? imageUrl;
  final bool isPaid;
  final double? price;
  final bool isRegistered;

  final String? category;
  final String? recurrence;
  final int? traditionId;
  final String? culturalOrigin;

  Event({
    required this.id,
    required this.title,
    this.description,
    required this.startTime,
    this.endTime,
    this.location,
    this.imageUrl,
    this.isPaid = false,
    this.price,
    this.isRegistered = false,
    this.category,
    this.recurrence,
    this.traditionId,
    this.culturalOrigin,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      startTime: DateTime.parse(json['start_time']),
      endTime: json['end_time'] != null ? DateTime.parse(json['end_time']) : null,
      location: json['location'],
      imageUrl: json['image_url'],
      isPaid: json['is_paid'] ?? false,
      price: json['price'] != null ? double.tryParse(json['price'].toString()) : null,
      isRegistered: json['is_registered'] ?? false,
      category: json['category'],
      recurrence: json['recurrence'],
      traditionId: json['tradition_id'],
      culturalOrigin: json['cultural_origin'],
    );
  }
}
