class Holiday {
  final int id;
  final String name;
  final String? theme;
  final DateTime date;
  final String? description;

  Holiday({
    required this.id,
    required this.name,
    this.theme,
    required this.date,
    this.description,
  });

  factory Holiday.fromJson(Map<String, dynamic> json) {
    return Holiday(
      id: json['id'],
      name: json['name'],
      theme: json['theme'],
      date: DateTime.parse(json['date']),
      description: json['description'],
    );
  }
}
