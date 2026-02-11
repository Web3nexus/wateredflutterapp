import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/community/providers/community_providers.dart';
import 'package:Watered/features/community/providers/group_providers.dart';
import 'package:Watered/features/community/models/group.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  final int? groupId;
  const CreatePostScreen({super.key, this.groupId});

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  final _contentController = TextEditingController();
  int? _selectedGroupId;

  @override
  void initState() {
    super.initState();
    _selectedGroupId = widget.groupId;
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final content = _contentController.text.trim();
    if (content.isEmpty) return;

    // Use the controller to create post
    await ref.read(communityControllerProvider.notifier).createPost(content, null, groupId: _selectedGroupId);

    // Check for errors (or just pop if optimistic)
    // For simplicity, assuming success if no exception thrown in notifier (though notifier catches it)
    // Better to listen to state changes, but popping for now
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(communityControllerProvider);
    final userGroupsAsync = ref.watch(userGroupsProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('New Post'),
        actions: [
          TextButton(
            onPressed: state.isLoading ? null : _submit,
            child: state.isLoading 
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) 
              : Text(
                  'POST',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Group Selection Dropdown
            userGroupsAsync.when(
              data: (groups) {
                if (groups.isEmpty) return const SizedBox.shrink();
                
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: theme.cardTheme.color,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: theme.dividerColor.withOpacity(0.1)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      value: _selectedGroupId,
                      hint: const Text('Post to General Feed'),
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down_rounded),
                      items: [
                        const DropdownMenuItem<int>(
                          value: null,
                          child: Text('Post to General Feed'),
                        ),
                        ...groups.map((group) {
                          return DropdownMenuItem<int>(
                            value: group.id,
                            child: Row(
                              children: [
                                Icon(
                                  group.type == GroupType.country ? Icons.public : Icons.groups,
                                  size: 16,
                                  color: theme.colorScheme.primary.withOpacity(0.7),
                                ),
                                const SizedBox(width: 8),
                                Text(group.name),
                              ],
                            ),
                          );
                        }),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedGroupId = value;
                        });
                      },
                    ),
                  ),
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),

            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null,
                style: theme.textTheme.bodyLarge,
                decoration: InputDecoration(
                  hintText: 'Share your thoughts${_selectedGroupId != null ? ' with the group' : ''}...',
                  hintStyle: TextStyle(
                    color: theme.textTheme.bodyLarge?.color?.withOpacity(0.5),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
