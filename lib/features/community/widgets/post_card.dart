import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/community/models/post.dart';
import 'package:Watered/features/community/providers/community_providers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostCard extends ConsumerWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final user = post.user;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                backgroundImage: user?.profilePhotoUrl != null
                    ? CachedNetworkImageProvider(user!.profilePhotoUrl!)
                    : null,
                child: user?.profilePhotoUrl == null
                    ? Text(
                        (user?.name ?? '?').substring(0, 1).toUpperCase(),
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.name ?? 'Unknown',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      timeago.format(post.createdAt),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.textTheme.bodySmall?.color?.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
              if (false) // TODO: Add menu for delete/report if owner
                IconButton(
                  icon: const Icon(Icons.more_horiz),
                  onPressed: () {},
                ),
            ],
          ),
          const SizedBox(height: 12),
          // Content
          if (post.content != null) ...[
            Text(
              post.content!,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 15,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
          ],
          // Actions
          Row(
            children: [
              _ActionButton(
                icon: post.isLiked ? Icons.favorite : Icons.favorite_border,
                label: '${post.likesCount}',
                color: post.isLiked ? Colors.redAccent : null,
                onTap: () {
                    ref.read(communityControllerProvider.notifier).toggleLike(post.id);
                },
              ),
              const SizedBox(width: 24),
              _ActionButton(
                icon: Icons.chat_bubble_outline,
                label: '${post.commentsCount}',
                onTap: () {
                  // TODO: Navigate to details
                },
              ),
              const Spacer(),
              _ActionButton(
                icon: Icons.share_outlined,
                label: '',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final finalColor = color ?? theme.iconTheme.color?.withOpacity(0.7);

    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 20, color: finalColor),
          if (label.isNotEmpty) ...[
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: finalColor,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
