import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required int id,
    required String name,
    String? description,
    required int price, // in cents
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'audio_sample_url') String? audioSampleUrl,
    @JsonKey(name: 'is_digital') @Default(false) bool isDigital,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}
