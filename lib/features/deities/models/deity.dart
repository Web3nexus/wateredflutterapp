class Deity {
  final int id;
  final String name;
  final String? description;
  final String? imageUrl;
  final int? traditionId;
  final String? origin;
  final String? mythologyStory;
  final String? symbols;
  final String? domains;
  final String? sacredElements;

  Deity({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    this.traditionId,
    this.origin,
    this.mythologyStory,
    this.symbols,
    this.domains,
    this.sacredElements,
  });

  factory Deity.fromJson(Map<String, dynamic> json) {
    return Deity(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['image_url'],
      traditionId: json['tradition_id'],
      origin: json['origin'],
      mythologyStory: json['mythology_story'],
      symbols: json['symbols'],
      domains: json['domains'],
      sacredElements: json['sacred_elements'],
    );
  }
}
