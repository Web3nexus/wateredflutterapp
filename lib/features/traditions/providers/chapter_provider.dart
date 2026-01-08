import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wateredflutterapp/core/network/api_client.dart';
import 'package:wateredflutterapp/core/network/api_error_handler.dart';
import 'package:wateredflutterapp/features/config/providers/global_settings_provider.dart';
import 'package:wateredflutterapp/features/traditions/models/chapter.dart';
import 'package:wateredflutterapp/features/traditions/providers/tradition_provider.dart';

part 'chapter_provider.g.dart';

/// Provider for chapters by collection
@riverpod
class ChapterList extends _$ChapterList {
  @override
  Future<PaginatedResponse<Chapter>> build({
    required int collectionId,
    int page = 1,
    int perPage = 50,
  }) async {
    return await fetchChapters(
      collectionId: collectionId,
      page: page,
      perPage: perPage,
    );
  }

  /// Fetch chapters from API
  Future<PaginatedResponse<Chapter>> fetchChapters({
    required int collectionId,
    required int page,
    required int perPage,
  }) async {
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.get(
        '/collections/$collectionId/chapters',
        queryParameters: {
          'page': page,
          'per_page': perPage,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data as Map<String, dynamic>;
        final chaptersData = data['data'] as List;
        final chapters = chaptersData
            .map((json) => Chapter.fromJson(json as Map<String, dynamic>))
            .toList();

        return PaginatedResponse(
          data: chapters,
          currentPage: data['current_page'] ?? page,
          lastPage: data['last_page'] ?? 1,
          total: data['total'] ?? chapters.length,
        );
      } else {
        throw ServerException('Failed to load chapters', response.statusCode);
      }
    } catch (e) {
      throw ApiErrorHandler.handleError(e);
    }
  }
}

/// Provider for a single chapter by ID
@riverpod
Future<Chapter> chapter(ChapterRef ref, int id) async {
  try {
    final apiClient = ref.read(apiClientProvider);
    final response = await apiClient.get('/chapters/$id');

    if (response.statusCode == 200 && response.data != null) {
      return Chapter.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw ServerException('Failed to load chapter', response.statusCode);
    }
  } catch (e) {
    throw ApiErrorHandler.handleError(e);
  }
}
