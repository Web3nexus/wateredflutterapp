import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/audio/models/audio.dart';

class LibraryState {
  final List<dynamic> allContent;
  final List<Audio> audios;
  final bool isLoading;

  const LibraryState({
    this.allContent = const [],
    this.audios = const [],
    this.isLoading = false,
  });
  LibraryState copyWith({
    List<dynamic>? allContent,
    List<Audio>? audios,
    bool? isLoading,
  }) {
    return LibraryState(
      allContent: allContent ?? this.allContent,
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
    try {
      final results = await _apiClient.get('audios', queryParameters: {'per_page': 20});

      List<Audio> audios = [];

      if (results.statusCode == 200 && results.data != null) {
        final data = results.data as Map<String, dynamic>;
        final list = data['data'] as List;
        audios = list.map((e) => Audio.fromJson(e)).toList();
      }

      final all = [...audios];
      all.sort((a, b) {
        DateTime? dateA;
        DateTime? dateB;
        
        if (a is Audio) dateA = a.publishedAt;
        if (b is Audio) dateB = b.publishedAt;

        if (dateA == null) return 1;
        if (dateB == null) return -1;
        return dateB.compareTo(dateA);
      });

      state = LibraryState(
        allContent: all,
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
