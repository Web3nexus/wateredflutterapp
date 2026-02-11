import 'package:Watered/features/auth/models/user.dart';

class Post {
  final int id;
  final int userId;
  final String? content;
  final List<String>? mediaUrls;
  final String status;
  final DateTime createdAt;
  final User? user;
  final int likesCount;
  final int commentsCount;
  final bool isLiked;
  final int? groupId;
  final String? groupName;

  Post({
    required this.id,
    required this.userId,
    this.content,
    this.mediaUrls,
    required this.status,
    required this.createdAt,
    this.user,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.isLiked = false,
    this.groupId,
    this.groupName,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['user_id'],
      content: json['content'],
      mediaUrls: json['media_urls'] != null ? List<String>.from(json['media_urls']) : null,
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      likesCount: json['likes_count'] ?? 0,
      commentsCount: json['comments_count'] ?? 0,
      isLiked: json['is_liked'] ?? false,
      groupId: json['group_id'],
      groupName: json['group_name'],
    );
  }
}
