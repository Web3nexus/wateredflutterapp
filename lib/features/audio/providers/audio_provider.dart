import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/core/network/api_error_handler.dart';
import 'package:Watered/features/traditions/providers/tradition_provider.dart';
import 'package:Watered/features/audio/models/audio.dart';

part 'audio_provider.g.dart';

@riverpod
class AudioList extends _$AudioList {
  String? _lastCategory;

  @override
  Future<PaginatedResponse<Audio>> build({
    int page = 1,
    int perPage = 20,
    int? traditionId,
    String? search,
    String? category,
  }) async {
    _lastCategory = category;
    return await fetchAudios(
      page: page,
      perPage: perPage,
      traditionId: traditionId,
      search: search,
      category: category,
    );
  }

  Future<PaginatedResponse<Audio>> fetchAudios({
    required int page,
    required int perPage,
    int? traditionId,
    String? search,
    String? category,
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

      if (category != null && category.isNotEmpty) {
        queryParams['category'] = category == 'Teachings' ? 'Music' : category;
      }

      final response = await apiClient.get(
        'audios',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data as Map<String, dynamic>;
        final audiosData = data['data'] as List;
        final audios = audiosData
            .map((json) => Audio.fromJson(json as Map<String, dynamic>))
            .toList();

        return PaginatedResponse(
          data: audios,
          currentPage: data['current_page'] ?? page,
          lastPage: data['last_page'] ?? 1,
          total: data['total'] ?? audios.length,
        );
      } else {
        throw ServerException(
          'Failed to load audio teachings',
          response.statusCode,
        );
      }
    } catch (e) {
      throw ApiErrorHandler.handleError(e);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => fetchAudios(
        page: 1,
        perPage: 20,
        traditionId: traditionId,
        search: search,
        category: _lastCategory,
      ),
    );
  }
}

@riverpod
Future<List<String>> audioCategories(AudioCategoriesRef ref) async {
  try {
    final apiClient = ref.read(apiClientProvider);
    final response = await apiClient.get('audio-categories');

    if (response.statusCode == 200 && response.data != null) {
      final data = response.data['data'] as List;
      return ['All', ...data.map((cat) {
        final name = cat['name'] as String;
        return name == 'Music' ? 'Teachings' : name;
      })];
    }
    return ['All', 'Incantation', 'Teachings', 'Sermons', 'Meditation'];
  } catch (e) {
    return ['All', 'Incantation', 'Teachings', 'Sermons', 'Meditation'];
  }
}

@riverpod
Future<Audio> audioDetail(AudioDetailRef ref, int id) async {
  try {
    final apiClient = ref.read(apiClientProvider);
    final response = await apiClient.get('audios/$id');

    if (response.statusCode == 200 && response.data != null) {
      return Audio.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw ServerException('Failed to load audio detail', response.statusCode);
    }
  } catch (e) {
    throw ApiErrorHandler.handleError(e);
  }
}
