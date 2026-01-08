import 'package:freezed_annotation/freezed_annotation.dart';

part 'tradition.freezed.dart';
part 'tradition.g.dart';

/// Tradition model (e.g., Buddhism, Hinduism, Christianity)
@freezed
class Tradition with _$Tradition {
  const factory Tradition({
    required int id,
    required String name,
    required String slug,
    String? description,
    String? imageUrl,
    required bool isActive,
    int? languageId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Tradition;

  factory Tradition.fromJson(Map<String, dynamic> json) =>
      _$TraditionFromJson(json);
}
