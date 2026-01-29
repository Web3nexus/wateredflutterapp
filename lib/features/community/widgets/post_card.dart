import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/community/models/post.dart';
import 'package:Watered/features/community/providers/community_providers.dart';
import 'package:Watered/core/services/interaction_service.dart';
import 'package:Watered/core/widgets/comment_bottom_sheet.dart';
import 'package:Watered/features/auth/providers/auth_provider.dart';
import 'package:Watered/features/auth/screens/login_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:share_plus/share_plus.dart';

class PostCard extends ConsumerStatefulWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  ConsumerState<PostCard> createState() => _PostCardState();
}

class _PostCardState extends ConsumerState<PostCard> {
  late bool _isLiked;
  late int _likesCount;
  late int _commentsCount;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.post.isLiked;
    _likesCount = widget.post.likesCount;
    _commentsCount = widget.post.commentsCount;
  }

  Future<void> _toggleLike() async {
    final previousLiked = _isLiked;
    final previousCount = _likesCount;

    setState(() {
      _isLiked = !_isLiked;
      _likesCount += _isLiked ? 1 : -1;
    });

    try {
      if (!ref.read(authProvider).isAuthenticated) {
        // Revert if not auth (though usually we'd redir to login first, done below)
        setState(() {
          _isLiked = previousLiked;
          _likesCount = previousCount;
        });
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LoginScreen()));
        return;
      }
      
      await ref.read(interactionServiceProvider).toggleLike('post', widget.post.id);
      // No need to refresh entire feed if local state is consistent
    } catch (e) {
      // Revert on error
      if (mounted) {
        setState(() {
          _isLiked = previousLiked;
          _likesCount = previousCount;
        });
      }
    }
  }

  void _onCommentAdded() {
    setState(() {
      _commentsCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = widget.post.user;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor.withOpacity(0.1)),
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
                      timeago.format(widget.post.createdAt),
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
          if (widget.post.content != null) ...[
            Text(
              widget.post.content!,
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
                icon: _isLiked ? Icons.favorite : Icons.favorite_border,
                label: '$_likesCount',
                color: _isLiked ? Colors.redAccent : null,
                onTap: _toggleLike,
              ),
              const SizedBox(width: 24),
              _ActionButton(
                icon: Icons.chat_bubble_outline,
                label: '$_commentsCount',
                onTap: () => CommentBottomSheet.show(
                  context, 
                  'post', 
                  widget.post.id,
                  onCommentAdded: _onCommentAdded,
                ),
              ),
              const Spacer(),
              _ActionButton(
                icon: Icons.share_outlined,
                label: '',
                onTap: () {
                  // Track share on backend
                  ref.read(interactionServiceProvider).sharePost(widget.post.id);
                  // Share via native share dialog
                  Share.share(
                    'Check out this post on Watered: ${widget.post.content ?? "Spiritual wisdom"}',
                    subject: 'Shared from Watered',
                  );
                },
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
