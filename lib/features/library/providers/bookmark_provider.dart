import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/library/models/bookmark.dart';
import 'package:Watered/features/library/services/bookmark_service.dart';

final bookmarkListProvider = StateNotifierProvider.autoDispose<BookmarkListNotifier, AsyncValue<List<Bookmark>>>((ref) {
  final service = ref.watch(bookmarkServiceProvider);
  return BookmarkListNotifier(service);
});

class BookmarkListNotifier extends StateNotifier<AsyncValue<List<Bookmark>>> {
  final BookmarkService _service;

  BookmarkListNotifier(this._service) : super(const AsyncValue.loading()) {
    loadBookmarks();
  }

  Future<void> loadBookmarks() async {
    try {
      state = const AsyncValue.loading();
      final bookmarks = await _service.getBookmarks();
      state = AsyncValue.data(bookmarks);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
  
  Future<void> refresh() async {
      await loadBookmarks();
  }

  Future<void> toggleBookmark({
    required String type,
    required int id,
    required bool isBookmarked, // Current state
    int? bookmarkId, // If we have it
  }) async {
    try {
      // Optimistic update could be complex here as we need the full object to add.
      // For now, we'll just do the call and refresh.
      if (isBookmarked) {
          if (bookmarkId != null) {
              await _service.removeBookmark(bookmarkId);
          } else {
               await _service.removeBookmarkByItem(type: type, id: id);
          }
      } else {
        await _service.addBookmark(type: type, id: id);
      }
      await loadBookmarks(); // Refresh list
    } catch (e) {
      // Revert or show error
    }
  }
}
