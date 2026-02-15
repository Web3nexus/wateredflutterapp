import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/audio/models/audio.dart';

class FeaturedContent {
  final List<Audio> audios;

  const FeaturedContent({this.audios = const []});

  List<dynamic> get all => [...audios]..shuffle();
}

final featuredContentProvider = FutureProvider<FeaturedContent>((ref) async {
  final apiClient = ref.read(apiClientProvider);
  
  // parallel fetch
  final results = await apiClient.get('audios', queryParameters: {'featured': true, 'per_page': 5});

  final audioResponse = results;

  List<Audio> audios = [];

  if (audioResponse.statusCode == 200 && audioResponse.data != null) {
      final data = audioResponse.data as Map<String, dynamic>;
      final list = data['data'] as List;
      audios = list.map((e) => Audio.fromJson(e)).toList();
  }

  return FeaturedContent(audios: audios);
});
