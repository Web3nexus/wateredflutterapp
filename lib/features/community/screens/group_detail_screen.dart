import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Watered/features/community/models/group.dart';
import 'package:Watered/features/community/providers/group_providers.dart';
import 'package:Watered/features/community/widgets/post_card.dart';
import 'package:Watered/features/community/screens/create_post_screen.dart';

class GroupDetailScreen extends ConsumerWidget {
  final Group group;

  const GroupDetailScreen({super.key, required this.group});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final postsAsync = ref.watch(groupPostsProvider(group.id));

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          // App Bar with Cover Image
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: group.coverImageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: group.coverImageUrl!,
                      fit: BoxFit.cover,
                      color: Colors.black.withOpacity(0.3),
                      colorBlendMode: BlendMode.darken,
                    )
                  : Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            theme.colorScheme.primary.withOpacity(0.8),
                            theme.colorScheme.primary.withOpacity(0.4),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
            ),
          ),

          // Group Info
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Group Icon
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: theme.cardTheme.color,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: theme.dividerColor.withOpacity(0.1),
                            width: 2,
                          ),
                        ),
                        child: group.iconUrl != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: CachedNetworkImage(
                                  imageUrl: group.iconUrl!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Icon(
                                group.type == GroupType.country
                                    ? Icons.public_rounded
                                    : Icons.groups_rounded,
                                color: theme.colorScheme.primary,
                                size: 40,
                              ),
                      ),
                      const SizedBox(width: 16),
                      
                      // Group Name and Stats
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              group.name,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${group.memberCount} members',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Join/Leave Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final groupService = ref.read(groupServiceProvider);
                        try {
                          if (group.isJoined) {
                            await groupService.leaveGroup(group.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Left ${group.name}')),
                            );
                          } else {
                            await groupService.joinGroup(group.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Joined ${group.name}')),
                            );
                          }
                          ref.invalidate(groupsListProvider);
                          ref.invalidate(groupPostsProvider(group.id));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: ${e.toString()}')),
                          );
                        }
                      },
                      icon: Icon(group.isJoined ? Icons.check : Icons.add),
                      label: Text(group.isJoined ? 'Joined' : 'Join Group'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: group.isJoined
                            ? theme.cardTheme.color
                            : theme.colorScheme.primary,
                        foregroundColor: group.isJoined
                            ? theme.textTheme.bodyMedium?.color
                            : Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: group.isJoined
                              ? BorderSide(color: theme.dividerColor.withOpacity(0.2))
                              : BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  
                  if (group.description != null) ...[
                    const SizedBox(height: 20),
                    Text(
                      'About',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      group.description!,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                  
                  const SizedBox(height: 24),
                  Text(
                    'POSTS',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),

          // Posts List
          postsAsync.when(
            data: (posts) {
              if (posts.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.post_add_rounded,
                          size: 64,
                          color: theme.textTheme.bodyLarge?.color?.withOpacity(0.3),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No posts yet in this group',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.textTheme.bodyLarge?.color?.withOpacity(0.5),
                          ),
                        ),
                        if (group.isJoined) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Be the first to share!',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.textTheme.bodyMedium?.color?.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }
              
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: PostCard(post: posts[index]),
                    );
                  },
                  childCount: posts.length,
                ),
              );
            },
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stack) => SliverFillRemaining(
              child: Center(
                child: Text(
                  'Failed to load posts',
                  style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: group.isJoined
          ? FloatingActionButton(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: Colors.white,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CreatePostScreen(groupId: group.id),
                  ),
                );
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
