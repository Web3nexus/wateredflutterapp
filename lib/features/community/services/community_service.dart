import 'package:dio/dio.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/community/models/post.dart';
import 'package:Watered/features/community/models/comment.dart';

class CommunityService {
  final ApiClient _client;

  CommunityService(this._client);

  Future<List<Post>> getPosts({int page = 1}) async {
    final response = await _client.get('community/posts', queryParameters: {'page': page});
    final data = response.data['data'] as List;
    return data.map((e) => Post.fromJson(e)).toList();
  }

  Future<Post> createPost({String? content, List<String>? mediaUrls, int? groupId}) async {
    final response = await _client.post('community/posts', data: {
      'content': content,
      'media_urls': mediaUrls,
      if (groupId != null) 'group_id': groupId,
    });
    return Post.fromJson(response.data);
  }

  Future<void> deletePost(int postId) async {
    await _client.delete('community/posts/$postId');
  }

  Future<List<Comment>> getComments(int postId, {int page = 1}) async {
    final response = await _client.get('community/posts/$postId/comments', queryParameters: {'page': page});
    final data = response.data['data'] as List;
    return data.map((e) => Comment.fromJson(e)).toList();
  }

  Future<Comment> addComment(int postId, String content) async {
    final response = await _client.post('community/posts/$postId/comments', data: {
      'content': content,
    });
    return Comment.fromJson(response.data);
  }

  Future<Map<String, dynamic>> toggleLike(int postId) async {
    final response = await _client.post('community/posts/$postId/like');
    return response.data;
  }
}
