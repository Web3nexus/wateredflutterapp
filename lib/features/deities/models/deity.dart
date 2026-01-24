class Deity {
  final int id;
  final String name;
  final String? description;
  final String? imageUrl;
  final int traditionId;

  Deity({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    required this.traditionId,
  });

  factory Deity.fromJson(Map<String, dynamic> json) {
    return Deity(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['image_url'],
      traditionId: json['tradition_id'],
    );
  }
}
