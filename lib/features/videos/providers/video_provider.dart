import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/core/network/api_error_handler.dart';
import 'package:Watered/features/traditions/providers/tradition_provider.dart';
import 'package:Watered/features/videos/models/video.dart';

part 'video_provider.g.dart';

@riverpod
class VideoList extends _$VideoList {
  @override
  Future<PaginatedResponse<Video>> build({
    int page = 1,
    int perPage = 20,
    int? traditionId,
    String? search,
    bool isFeatured = false,
  }) async {
    return await fetchVideos(
      page: page,
      perPage: perPage,
      traditionId: traditionId,
      search: search,
      isFeatured: isFeatured,
    );
  }

  Future<PaginatedResponse<Video>> fetchVideos({
    required int page,
    required int perPage,
    int? traditionId,
    String? search,
    bool isFeatured = false,
  }) async {
    try {
      final apiClient = ref.read(apiClientProvider);
      final Map<String, dynamic> queryParams = {
        'page': page,
        'per_page': perPage,
      };

      if (traditionId != null) {
        queryParams['tradition_id'] = traditionId;
      }

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      if (isFeatured) {
        queryParams['is_featured'] = '1';
      }

      final response = await apiClient.get(
        'videos',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data as Map<String, dynamic>;
        final videosData = data['data'] as List;
        final videos = videosData
            .map((json) => Video.fromJson(json as Map<String, dynamic>))
            .toList();

        return PaginatedResponse(
          data: videos,
          currentPage: data['current_page'] ?? page,
          lastPage: data['last_page'] ?? 1,
          total: data['total'] ?? videos.length,
        );
      } else {
        throw ServerException('Failed to load videos', response.statusCode);
      }
    } catch (e) {
      throw ApiErrorHandler.handleError(e);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => fetchVideos(
        page: 1,
        perPage: 20,
        traditionId: traditionId,
        search: search,
      ),
    );
  }
}

@riverpod
Future<Video> villageVideo(VillageVideoRef ref, int id) async {
  try {
    final apiClient = ref.read(apiClientProvider);
    final response = await apiClient.get('videos/$id');

    if (response.statusCode == 200 && response.data != null) {
      return Video.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw ServerException('Failed to load video', response.statusCode);
    }
  } catch (e) {
    throw ApiErrorHandler.handleError(e);
  }
}
