import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wateredflutterapp/features/videos/models/video.dart';
import 'package:wateredflutterapp/features/commerce/models/product.dart';
import 'package:wateredflutterapp/features/temples/models/temple.dart';

part 'search_result.freezed.dart';
part 'search_result.g.dart';

@freezed
class SearchResult with _$SearchResult {
  const factory SearchResult({
    @Default([]) List<Video> videos,
    @Default([]) List<dynamic> audio, // Placeholder until Audio model imported/created
    @Default([]) List<Product> products,
    @Default([]) List<Temple> temples,
    @Default([]) List<dynamic> traditions, // Placeholder
  }) = _SearchResult;

  factory SearchResult.fromJson(Map<String, dynamic> json) => _$SearchResultFromJson(json);
}
