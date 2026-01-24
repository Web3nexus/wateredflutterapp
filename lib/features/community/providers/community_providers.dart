import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/community/services/community_service.dart';
import 'package:Watered/features/community/models/post.dart';

final communityServiceProvider = Provider<CommunityService>((ref) {
  return CommunityService(ref.read(apiClientProvider));
});

final postsProvider = FutureProvider.autoDispose<List<Post>>((ref) async {
  final service = ref.watch(communityServiceProvider);
  return await service.getPosts();
});

class CommunityController extends StateNotifier<AsyncValue<void>> {
  final CommunityService _service;
  final Ref _ref;

  CommunityController(this._service, this._ref) : super(const AsyncValue.data(null));

  Future<void> createPost(String? content, List<String>? mediaUrls) async {
    state = const AsyncValue.loading();
    try {
      await _service.createPost(content: content, mediaUrls: mediaUrls);
      _ref.refresh(postsProvider); // Refresh feed
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> toggleLike(int postId) async {
    try {
        // Optimistic update could go here, but kept simple for now
        await _service.toggleLike(postId);
        _ref.invalidate(postsProvider); 
    } catch (e) {
        // Handle error
    }
  }
}

final communityControllerProvider = StateNotifierProvider<CommunityController, AsyncValue<void>>((ref) {
  return CommunityController(ref.watch(communityServiceProvider), ref);
});
