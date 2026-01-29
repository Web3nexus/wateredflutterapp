import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/videos/models/video.dart';
import 'package:Watered/features/audio/models/audio.dart';

class LibraryState {
  final List<dynamic> allContent;
  final List<Video> videos;
  final List<Audio> audios;
  final bool isLoading;

  const LibraryState({
    this.allContent = const [],
    this.videos = const [],
    this.audios = const [],
    this.isLoading = false,
  });

  LibraryState copyWith({
    List<dynamic>? allContent,
    List<Video>? videos,
    List<Audio>? audios,
    bool? isLoading,
  }) {
    return LibraryState(
      allContent: allContent ?? this.allContent,
      videos: videos ?? this.videos,
      audios: audios ?? this.audios,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class LibraryNotifier extends StateNotifier<LibraryState> {
  final ApiClient _apiClient;

  LibraryNotifier(this._apiClient) : super(const LibraryState()) {
    refresh();
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true);
    try {
      final results = await Future.wait([
        _apiClient.get('videos', queryParameters: {'per_page': 20}),
        _apiClient.get('audios', queryParameters: {'per_page': 20}),
      ]);

      List<Video> videos = [];
      List<Audio> audios = [];

      if (results[0].statusCode == 200 && results[0].data != null) {
        final data = results[0].data as Map<String, dynamic>;
        final list = data['data'] as List;
        videos = list.map((e) => Video.fromJson(e)).toList();
      }

      if (results[1].statusCode == 200 && results[1].data != null) {
        final data = results[1].data as Map<String, dynamic>;
        final list = data['data'] as List;
        audios = list.map((e) => Audio.fromJson(e)).toList();
      }

      final all = [...videos, ...audios];
      all.sort((a, b) {
        DateTime? dateA;
        DateTime? dateB;
        
        if (a is Video) dateA = a.publishedAt;
        if (a is Audio) dateA = a.publishedAt;
        if (b is Video) dateB = b.publishedAt;
        if (b is Audio) dateB = b.publishedAt;

        if (dateA == null) return 1;
        if (dateB == null) return -1;
        return dateB.compareTo(dateA);
      });

      state = LibraryState(
        allContent: all,
        videos: videos,
        audios: audios,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      // Handle error gracefully or expose in state
      print("Library fetch error: $e");
    }
  }
}

final libraryProvider = StateNotifierProvider<LibraryNotifier, LibraryState>((ref) {
  return LibraryNotifier(ref.read(apiClientProvider));
});
