import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wateredflutterapp/core/network/api_client.dart';
import 'package:wateredflutterapp/core/network/api_error_handler.dart';
import 'package:wateredflutterapp/features/config/providers/global_settings_provider.dart';
import 'package:wateredflutterapp/features/traditions/models/entry.dart';
import 'package:wateredflutterapp/features/traditions/providers/tradition_provider.dart';

part 'entry_provider.g.dart';

/// Provider for entries by chapter with bookmark hooks
@riverpod
class EntryList extends _$EntryList {
  @override
  Future<PaginatedResponse<Entry>> build({
    required int chapterId,
    String? languageCode,
    int page = 1,
    int perPage = 50,
  }) async {
    return await fetchEntries(
      chapterId: chapterId,
      languageCode: languageCode,
      page: page,
      perPage: perPage,
    );
  }

  /// Fetch entries from API
  Future<PaginatedResponse<Entry>> fetchEntries({
    required int chapterId,
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
        'chapters/$chapterId/entries',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data as Map<String, dynamic>;
        final entriesData = data['data'] as List;
        final entries = entriesData
            .map((json) => Entry.fromJson(json as Map<String, dynamic>))
            .toList();

        return PaginatedResponse(
          data: entries,
          currentPage: data['current_page'] ?? page,
          lastPage: data['last_page'] ?? 1,
          total: data['total'] ?? entries.length,
        );
      } else {
        throw ServerException('Failed to load entries', response.statusCode);
      }
    } catch (e) {
      throw ApiErrorHandler.handleError(e);
    }
  }
}

/// Provider for a single entry by ID
@riverpod
Future<Entry> entry(EntryRef ref, int id, {String? languageCode}) async {
  try {
    final apiClient = ref.read(apiClientProvider);
    final queryParams = <String, dynamic>{};

    if (languageCode != null) {
      queryParams['language'] = languageCode;
    }

    final response = await apiClient.get(
      'entries/$id',
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
    );

    if (response.statusCode == 200 && response.data != null) {
      return Entry.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw ServerException('Failed to load entry', response.statusCode);
    }
  } catch (e) {
    throw ApiErrorHandler.handleError(e);
  }
}
