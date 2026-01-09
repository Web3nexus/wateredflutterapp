import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wateredflutterapp/core/network/api_client.dart';
import 'package:wateredflutterapp/core/network/api_error_handler.dart';
import 'package:wateredflutterapp/features/config/providers/global_settings_provider.dart';
import 'package:wateredflutterapp/features/traditions/models/tradition.dart';

part 'tradition_provider.g.dart';

/// Pagination parameters
class PaginationParams {
  final int page;
  final int perPage;

  const PaginationParams({
    this.page = 1,
    this.perPage = 20,
  });
}

/// Paginated response wrapper
class PaginatedResponse<T> {
  final List<T> data;
  final int currentPage;
  final int lastPage;
  final int total;
  final bool hasMore;

  PaginatedResponse({
    required this.data,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  }) : hasMore = currentPage < lastPage;
}

/// Provider for traditions list with pagination
@riverpod
class TraditionList extends _$TraditionList {
  @override
  Future<PaginatedResponse<Tradition>> build({
    int page = 1,
    int perPage = 20,
  }) async {
    return await fetchTraditions(page: page, perPage: perPage);
  }

  /// Fetch traditions from API
  Future<PaginatedResponse<Tradition>> fetchTraditions({
    required int page,
    required int perPage,
  }) async {
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.get(
        'traditions',
        queryParameters: {
          'page': page,
          'per_page': perPage,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data as Map<String, dynamic>;
        final traditionsData = data['data'] as List;
        final traditions = traditionsData
            .map((json) => Tradition.fromJson(json as Map<String, dynamic>))
            .toList();

        return PaginatedResponse(
          data: traditions,
          currentPage: data['current_page'] ?? page,
          lastPage: data['last_page'] ?? 1,
          total: data['total'] ?? traditions.length,
        );
      } else {
        throw ServerException('Failed to load traditions', response.statusCode);
      }
    } catch (e) {
      throw ApiErrorHandler.handleError(e);
    }
  }

  /// Load next page
  Future<void> loadNextPage() async {
    final current = await future;
    if (current.hasMore) {
      // In a real app, you'd append to existing data
      // For now, just load the next page
      state = AsyncValue.data(
        await fetchTraditions(
          page: current.currentPage + 1,
          perPage: 20,
        ),
      );
    }
  }

  /// Refresh traditions
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => fetchTraditions(page: 1, perPage: 20),
    );
  }
}

/// Provider for a single tradition by ID
@riverpod
Future<Tradition> tradition(TraditionRef ref, int id) async {
  try {
    final apiClient = ref.read(apiClientProvider);
    final response = await apiClient.get('traditions/$id');

    if (response.statusCode == 200 && response.data != null) {
      return Tradition.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw ServerException('Failed to load tradition', response.statusCode);
    }
  } catch (e) {
    throw ApiErrorHandler.handleError(e);
  }
}
