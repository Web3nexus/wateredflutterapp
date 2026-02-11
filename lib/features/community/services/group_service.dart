import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/community/models/group.dart';
import 'package:Watered/features/community/models/post.dart';

class GroupService {
  final ApiClient _api;

  GroupService(this._api);

  /// Fetch all available groups
  Future<List<Group>> fetchGroups() async {
    try {
      final response = await _api.get('/api/groups');
      final List<dynamic> data = response['data'] ?? [];
      return data.map((json) => Group.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch groups: $e');
    }
  }

  /// Fetch groups the user has joined
  Future<List<int>> fetchUserGroupIds(int userId) async {
    try {
      final response = await _api.get('/api/users/$userId/groups');
      final List<dynamic> data = response['data'] ?? [];
      return data.map<int>((json) => json['id'] as int).toList();
    } catch (e) {
      throw Exception('Failed to fetch user groups: $e');
    }
  }

  /// Join a group
  Future<void> joinGroup(int groupId) async {
    try {
      await _api.post('/api/groups/$groupId/join', {});
    } catch (e) {
      throw Exception('Failed to join group: $e');
    }
  }

  /// Leave a group
  Future<void> leaveGroup(int groupId) async {
    try {
      await _api.delete('/api/groups/$groupId/leave');
    } catch (e) {
      throw Exception('Failed to leave group: $e');
    }
  }

  /// Fetch posts for a specific group
  Future<List<Post>> fetchGroupPosts(int groupId) async {
    try {
      final response = await _api.get('/api/groups/$groupId/posts');
      final List<dynamic> data = response['data'] ?? [];
      return data.map((json) => Post.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch group posts: $e');
    }
  }
}
