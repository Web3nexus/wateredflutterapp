class Incantation {
  final int id;
  final String title;
  final String? description;
  final String? content;
  final String? audioUrl;
  final bool isPaid;

  Incantation({
    required this.id,
    required this.title,
    this.description,
    this.content,
    this.audioUrl,
    this.isPaid = false,
  });

  factory Incantation.fromJson(Map<String, dynamic> json) {
    return Incantation(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      content: json['content'],
      audioUrl: json['audio_url'],
      isPaid: json['is_paid'] ?? false,
    );
  }
}
