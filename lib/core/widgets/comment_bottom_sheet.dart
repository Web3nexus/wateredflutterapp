import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/services/interaction_service.dart';
import 'package:Watered/features/auth/providers/auth_provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentBottomSheet extends ConsumerStatefulWidget {
  final String type;
  final int id;
  final VoidCallback? onCommentAdded;

  const CommentBottomSheet({super.key, required this.type, required this.id, this.onCommentAdded});

  static void show(BuildContext context, String type, int id, {VoidCallback? onCommentAdded}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CommentBottomSheet(type: type, id: id, onCommentAdded: onCommentAdded),
    );
  }

  @override
  ConsumerState<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends ConsumerState<CommentBottomSheet> {
  final _commentController = TextEditingController();
  bool _isLoading = false;
  List<dynamic> _comments = [];
  bool _isFetching = true;

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  Future<void> _fetchComments() async {
    try {
      final comments = await ref.read(interactionServiceProvider).getComments(widget.type, widget.id);
      if (mounted) {
        setState(() {
          _comments = comments;
          _isFetching = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isFetching = false);
    }
  }

  Future<void> _submitComment() async {
    final content = _commentController.text.trim();
    if (content.isEmpty) return;

    if (!ref.read(authProvider).isAuthenticated) {
       ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Please log in to comment.')),
       );
       return;
    }

    setState(() => _isLoading = true);
    try {
      await ref.read(interactionServiceProvider).addComment(widget.type, widget.id, content);
      _commentController.clear();
      _fetchComments(); // Refresh
      widget.onCommentAdded?.call();
    } catch (e) {
      // Error
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Comments',
            style: TextStyle(fontFamily: 'Cinzel', fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(height: 32),
          Expanded(
            child: _isFetching 
              ? const Center(child: CircularProgressIndicator())
              : _comments.isEmpty
                ? const Center(child: Text('No comments yet.'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _comments.length,
                    itemBuilder: (context, index) {
                      final comment = _comments[index];
                      final user = comment['user'];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                              child: Text(
                                (user?['name'] ?? '?').substring(0, 1).toUpperCase(),
                                style: TextStyle(color: theme.colorScheme.primary, fontSize: 12),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        user?['name'] ?? 'Unknown',
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        timeago.format(DateTime.parse(comment['created_at'])),
                                        style: TextStyle(color: Colors.white38, fontSize: 11),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(comment['content']),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 12, 20, 12 + bottomPadding),
            decoration: BoxDecoration(
              color: theme.cardTheme.color,
              border: const Border(top: BorderSide(color: Colors.white10)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: 'Add a comment...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _isLoading ? null : _submitComment,
                  icon: _isLoading 
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : Icon(Icons.send_rounded, color: theme.colorScheme.primary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
