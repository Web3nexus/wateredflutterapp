import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wateredflutterapp/core/network/api_client.dart';
import 'package:wateredflutterapp/features/search/models/daily_wisdom.dart';
import 'package:wateredflutterapp/features/search/models/search_result.dart';

final searchServiceProvider = Provider<SearchService>((ref) {
  return SearchService(ref.read(apiClientProvider));
});

class SearchService {
  final ApiClient _client;

  SearchService(this._client);

  Future<DailyWisdom?> getDailyWisdom() async {
    try {
      final response = await _client.get('daily-wisdom');
      if (response.data['data'] != null) {
        return DailyWisdom.fromJson(response.data['data']);
      }
      return null;
    } catch (e) {
      // Fail silently for wisdom
      return null;
    }
  }

  Future<SearchResult> search(String query) async {
    if (query.trim().isEmpty) return const SearchResult();
    try {
      final response = await _client.get('search', queryParameters: {'query': query});
      return SearchResult.fromJson(response.data); // data is top level here? Wait, controller returns keyed array directly: keys [videos, audio...]
    } catch (e) {
      throw 'Search failed.';
    }
  }
}
