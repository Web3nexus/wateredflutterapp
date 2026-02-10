import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/core/network/api_error_handler.dart';
import 'package:Watered/features/traditions/models/text_collection.dart'; // Make sure this model exists or create it

part 'text_collection_provider.g.dart';

@riverpod
class TextCollectionList extends _$TextCollectionList {
  @override
  Future<List<TextCollection>> build() async {
    return fetchTextCollections();
  }

  Future<List<TextCollection>> fetchTextCollections() async {
     try {
      final apiClient = ref.read(apiClientProvider);
      // Fetching all text collections directly, skipping tradition filter
      final response = await apiClient.get('text-collections'); 

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data as Map<String, dynamic>;
        final list = data['data'] as List;
        return list.map((e) => TextCollection.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      throw ApiErrorHandler.handleError(e);
    }
  }
}
