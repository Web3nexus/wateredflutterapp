import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/services/api_service.dart';
import 'package:Watered/features/community/services/group_service.dart';
import 'package:Watered/features/community/models/group.dart';
import 'package:Watered/features/community/models/post.dart';
import 'package:Watered/features/auth/providers/auth_provider.dart';

// Group service provider
final groupServiceProvider = Provider<GroupService>((ref) {
  final api = ref.watch(apiServiceProvider);
  return GroupService(api);
});

// Fetch all groups
final groupsListProvider = FutureProvider<List<Group>>((ref) async {
  final groupService = ref.watch(groupServiceProvider);
  final userId = ref.watch(authProvider).user?.id;
  
  // Fetch all groups
  final groups = await groupService.fetchGroups();
  
  if (userId == null) {
    return groups;
  }
  
  // Fetch user's joined group IDs
  final joinedGroupIds = await groupService.fetchUserGroupIds(userId);
  
  // Mark groups as joined
  return groups.map((group) {
    return group.copyWith(isJoined: joinedGroupIds.contains(group.id));
  }).toList();
});

// Fetch user's joined groups only
final userGroupsProvider = FutureProvider<List<Group>>((ref) async {
  final allGroups = await ref.watch(groupsListProvider.future);
  return allGroups.where((group) => group.isJoined).toList();
});

// Fetch posts for a specific group
final groupPostsProvider = FutureProvider.family<List<Post>, int>((ref, groupId) async {
  final groupService = ref.watch(groupServiceProvider);
  return await groupService.fetchGroupPosts(groupId);
});

// State provider for selected group filter (null = all groups)
final selectedGroupFilterProvider = StateProvider<int?>((ref) => null);
