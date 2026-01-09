import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wateredflutterapp/core/network/api_client.dart';
import 'package:wateredflutterapp/core/network/api_error_handler.dart';
import 'package:wateredflutterapp/features/config/providers/global_settings_provider.dart';
import 'package:wateredflutterapp/features/traditions/models/text_collection.dart';
import 'package:wateredflutterapp/features/traditions/providers/tradition_provider.dart';

part 'collection_provider.g.dart';

/// Provider for text collections by tradition with language filtering
@riverpod
class CollectionList extends _$CollectionList {
  @override
  Future<PaginatedResponse<TextCollection>> build({
    required int traditionId,
    String? languageCode,
    int page = 1,
    int perPage = 20,
  }) async {
    return await fetchCollections(
      traditionId: traditionId,
      languageCode: languageCode,
      page: page,
      perPage: perPage,
    );
  }

  /// Fetch collections from API
  Future<PaginatedResponse<TextCollection>> fetchCollections({
    required int traditionId,
    String? languageCode,
    required int page,
    required int perPage,
  }) async {
    try {
      final apiClient = ref.read(apiClientProvider);
      final Map<String, dynamic> queryParams = {
        'page': page,
        'per_page': perPage,
      };

      // Add language filter if provided
      if (languageCode != null) {
        queryParams['language'] = languageCode;
      }

      final response = await apiClient.get(
        'traditions/$traditionId/collections',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data as Map<String, dynamic>;
        final collectionsData = data['data'] as List;
        final collections = collectionsData
            .map((json) =>
                TextCollection.fromJson(json as Map<String, dynamic>))
            .toList();

        return PaginatedResponse(
          data: collections,
          currentPage: data['current_page'] ?? page,
          lastPage: data['last_page'] ?? 1,
          total: data['total'] ?? collections.length,
        );
      } else {
        throw ServerException(
            'Failed to load collections', response.statusCode);
      }
    } catch (e) {
      throw ApiErrorHandler.handleError(e);
    }
  }

  /// Refresh collections
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final current = state.value;
    if (current != null) {
      state = await AsyncValue.guard(
        () => fetchCollections(
          traditionId: traditionId,
          languageCode: languageCode,
          page: 1,
          perPage: perPage,
        ),
      );
    }
  }
}

/// Provider for a single collection by ID
@riverpod
Future<TextCollection> collection(CollectionRef ref, int id) async {
  try {
    final apiClient = ref.read(apiClientProvider);
    final response = await apiClient.get('collections/$id');

    if (response.statusCode == 200 && response.data != null) {
      return TextCollection.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw ServerException('Failed to load collection', response.statusCode);
    }
  } catch (e) {
    throw ApiErrorHandler.handleError(e);
  }
}
