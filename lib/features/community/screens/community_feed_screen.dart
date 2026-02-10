import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/community/providers/community_providers.dart';
import 'package:Watered/features/community/widgets/post_card.dart';
import 'package:Watered/features/community/screens/create_post_screen.dart';
import 'package:Watered/features/auth/providers/auth_provider.dart';
import 'package:Watered/features/auth/screens/login_screen.dart';
import 'package:Watered/features/subscription/screens/subscription_screen.dart';
import 'package:Watered/core/services/ad_service.dart';

import 'package:Watered/features/blog/screens/blog_screen.dart';

class CommunityFeedScreen extends ConsumerWidget {
  const CommunityFeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isPremium = ref.watch(authProvider).user?.isPremium ?? false;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('COMMUNITY'),
          bottom: TabBar(
            tabs: const [
              Tab(text: 'Feed'),
              Tab(text: 'Blog'),
            ],
            indicatorColor: theme.colorScheme.primary,
            labelColor: theme.colorScheme.primary,
            unselectedLabelColor: Colors.grey,
          ),
          actions: [
            if (!isPremium)
              TextButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SubscriptionScreen())),
                child: Text('GET PLUS+', style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            const SizedBox(width: 8),
          ],
        ),
        body: TabBarView(
          children: [
            _buildFeedTab(context, ref, theme),
            const BlogScreen(embed: true),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: Colors.white,
          onPressed: () {
             if (!ref.read(authProvider).isAuthenticated) {
               ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(content: Text('Please log in to share with the community.')),
               );
               Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LoginScreen()));
               return;
             }
             Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CreatePostScreen()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildFeedTab(BuildContext context, WidgetRef ref, ThemeData theme) {
    final postsAsync = ref.watch(postsProvider);
    
    return RefreshIndicator(
      onRefresh: () async => ref.refresh(postsProvider),
      child: Column(
        children: [
          const AdBanner(screenKey: 'community'),
          Expanded(
            child: postsAsync.when(
              data: (posts) {
                if (posts.isEmpty) {
                  return Center(
                    child: Text(
                      'No posts yet.\nBe the first to share!',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.textTheme.bodyLarge?.color?.withOpacity(0.5),
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return PostCard(post: posts[index]);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.wifi_off_rounded, color: Colors.grey, size: 48),
                      const SizedBox(height: 16),
                      Text(
                        'Connection timeout. Please check your internet and try again.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
