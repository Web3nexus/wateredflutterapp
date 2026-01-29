import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/network/api_client.dart';

final interactionServiceProvider = Provider<InteractionService>((ref) {
  return InteractionService(ref.read(apiClientProvider));
});

class InteractionService {
  final ApiClient _client;

  InteractionService(this._client);

  /// Toggle like on any content type (post, video, audio)
  Future<Map<String, dynamic>> toggleLike(String type, int id) async {
    final response = await _client.post('interact/like', data: {
      'type': type,
      'id': id,
    });
    return response.data;
  }

  /// Add comment to any content type
  Future<Map<String, dynamic>> addComment(String type, int id, String content) async {
    final response = await _client.post('interact/comment', data: {
      'type': type,
      'id': id,
      'content': content,
    });
    return response.data;
  }

  /// Fetch comments for any content type
  Future<List<dynamic>> getComments(String type, int id) async {
    final response = await _client.get('interact/comments', queryParameters: {
      'type': type,
      'id': id,
    });
    return response.data['data'];
  }

  /// Share post (track on backend)
  Future<void> sharePost(int postId) async {
    try {
      await _client.post('posts/$postId/share');
    } catch (e) {
      // Silently fail - sharing should work even if tracking fails
    }
  }
}
