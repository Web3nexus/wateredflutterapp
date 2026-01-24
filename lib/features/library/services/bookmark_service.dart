import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/library/models/bookmark.dart';

final bookmarkServiceProvider = Provider<BookmarkService>((ref) {
  return BookmarkService(ref.read(apiClientProvider));
});

class BookmarkService {
  final ApiClient _client;

  BookmarkService(this._client);

  Future<List<Bookmark>> getBookmarks() async {
    try {
      final response = await _client.get('bookmarks');
      // Assuming paginated or list response. If Laravel default resource collection:
      final List data = response.data['data'] ?? [];
      return data.map((e) => Bookmark.fromJson(e)).toList();
    } catch (e) {
      throw 'Failed to load bookmarks.';
    }
  }

  Future<void> addBookmark({
    required String
    type, // 'App\Models\Video', 'App\Models\Audio' etc, or short names 'video', 'audio'
    required int id,
  }) async {
    try {
      await _client.post(
        'bookmarks',
        data: {'bookmarkable_type': type, 'bookmarkable_id': id},
      );
    } catch (e) {
      throw 'Failed to bookmark item.';
    }
  }

  Future<void> removeBookmark(int bookmarkId) async {
    try {
      await _client.delete('bookmarks/$bookmarkId');
    } catch (e) {
      throw 'Failed to remove bookmark.';
    }
  }

  // Helper to remove by item specific if we don't have the bookmark ID handy locally
  Future<void> removeBookmarkByItem({
    required String type,
    required int id,
  }) async {
    try {
      await _client.delete(
        'bookmarks/item',
        queryParameters: {'bookmarkable_type': type, 'bookmarkable_id': id},
      );
    } catch (e) {
      throw 'Failed to remove bookmark.';
    }
  }
}
