class ConsultationType {
  final int id;
  final String name;
  final int durationMinutes;
  final double price;
  final String? description;

  ConsultationType({
    required this.id,
    required this.name,
    required this.durationMinutes,
    required this.price,
    this.description,
  });

  factory ConsultationType.fromJson(Map<String, dynamic> json) {
    return ConsultationType(
      id: json['id'],
      name: json['name'],
      durationMinutes: json['duration_minutes'],
      price: double.parse(json['price'].toString()),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'duration_minutes': durationMinutes,
        'price': price,
        'description': description,
      };
}

