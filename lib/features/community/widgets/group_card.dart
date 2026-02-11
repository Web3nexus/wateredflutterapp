import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Watered/features/community/models/group.dart';
import 'package:Watered/features/community/providers/group_providers.dart';
import 'package:Watered/features/community/screens/group_detail_screen.dart';

class GroupCard extends ConsumerWidget {
  final Group group;

  const GroupCard({super.key, required this.group});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => GroupDetailScreen(group: group),
          ),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: group.isJoined
                ? theme.colorScheme.primary.withOpacity(0.3)
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            // Group Icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: group.iconUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl: group.iconUrl!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          _getGroupIcon(),
                          color: theme.colorScheme.primary,
                          size: 30,
                        ),
                      ),
                    )
                  : Icon(
                      _getGroupIcon(),
                      color: theme.colorScheme.primary,
                      size: 30,
                    ),
            ),
            const SizedBox(width: 16),
            
            // Group Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          group.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      _buildTypeBadge(theme),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${group.memberCount} members',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
                    ),
                  ),
                  if (group.description != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      group.description!,
                      style: theme.textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 12),
            
            // Join/Leave Button
            _buildActionButton(context, ref, theme),
          ],
        ),
      ),
    );
  }

  IconData _getGroupIcon() {
    return group.type == GroupType.country
        ? Icons.public_rounded
        : Icons.groups_rounded;
  }

  Widget _buildTypeBadge(ThemeData theme) {
    final isCountry = group.type == GroupType.country;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isCountry
            ? Colors.blue.withOpacity(0.1)
            : Colors.purple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        isCountry ? 'COUNTRY' : 'TRIBE',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: isCountry ? Colors.blue : Colors.purple,
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, WidgetRef ref, ThemeData theme) {
    return ElevatedButton(
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
          // Refresh groups list
          ref.invalidate(groupsListProvider);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.toString()}')),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: group.isJoined
            ? theme.cardTheme.color
            : theme.colorScheme.primary,
        foregroundColor: group.isJoined
            ? theme.textTheme.bodyMedium?.color
            : Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: group.isJoined
              ? BorderSide(color: theme.dividerColor.withOpacity(0.2))
              : BorderSide.none,
        ),
      ),
      child: Text(
        group.isJoined ? 'Joined' : 'Join',
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}
