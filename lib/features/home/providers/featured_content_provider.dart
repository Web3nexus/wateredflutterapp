import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/videos/models/video.dart';
import 'package:Watered/features/audio/models/audio.dart';

class FeaturedContent {
  final List<Video> videos;
  final List<Audio> audios;

  const FeaturedContent({this.videos = const [], this.audios = const []});

  List<dynamic> get all => [...videos, ...audios]..shuffle();
}

final featuredContentProvider = FutureProvider<FeaturedContent>((ref) async {
  final apiClient = ref.read(apiClientProvider);
  
  // parallel fetch
  final results = await Future.wait([
    apiClient.get('videos', queryParameters: {'featured': true, 'per_page': 5}),
    apiClient.get('audios', queryParameters: {'featured': true, 'per_page': 5}),
  ]);

  final videoResponse = results[0];
  final audioResponse = results[1];

  List<Video> videos = [];
  List<Audio> audios = [];

  if (videoResponse.statusCode == 200 && videoResponse.data != null) {
      final data = videoResponse.data as Map<String, dynamic>;
      final list = data['data'] as List;
      videos = list.map((e) => Video.fromJson(e)).toList();
  }

  if (audioResponse.statusCode == 200 && audioResponse.data != null) {
      final data = audioResponse.data as Map<String, dynamic>;
      final list = data['data'] as List;
      audios = list.map((e) => Audio.fromJson(e)).toList();
  }

  return FeaturedContent(videos: videos, audios: audios);
});
