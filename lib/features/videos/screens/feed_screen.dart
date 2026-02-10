import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/videos/providers/video_provider.dart';
import 'package:Watered/features/videos/models/video.dart';
import 'package:Watered/features/videos/widgets/video_player_widget.dart';
import 'package:Watered/core/services/interaction_service.dart';
import 'package:Watered/core/widgets/comment_bottom_sheet.dart';
import 'package:Watered/features/auth/providers/auth_provider.dart';
import 'package:Watered/features/auth/screens/login_screen.dart';
import 'package:Watered/core/services/ad_service.dart';
import 'package:Watered/features/videos/providers/video_feed_providers.dart';
import 'package:Watered/features/subscription/screens/subscription_screen.dart';
import 'package:share_plus/share_plus.dart';

class FeedScreen extends ConsumerStatefulWidget {
  final int? initialVideoId;
  final bool showAppBar;
  const FeedScreen({super.key, this.initialVideoId, this.showAppBar = true});

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  int _currentIndex = 0;
  bool _initialIndexSet = false;

  @override
  Widget build(BuildContext context) {
    final videoState = ref.watch(videoListProvider());
    final isPremium = ref.watch(authProvider).user?.isPremium ?? false;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: widget.showAppBar ? AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: TabBar(
            indicatorColor: Theme.of(context).colorScheme.primary,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Colors.white70,
            tabs: const [
              Tab(text: 'For You'),
              Tab(text: 'Featured'),
            ],
          ),
        ) : null,
        body: TabBarView(
          children: [
            // FYP Tab (default, all videos)
            _VideoFeed(isFeatured: false, initialVideoId: widget.initialVideoId),
            // Featured Tab
            _VideoFeed(isFeatured: true, initialVideoId: null),
          ],
        ),
      ),
    );
  }
}

class _VideoFeed extends ConsumerStatefulWidget {
  final bool isFeatured;
  final int? initialVideoId;
  
  const _VideoFeed({required this.isFeatured, this.initialVideoId});

  @override
  ConsumerState<_VideoFeed> createState() => _VideoFeedState();
}

class _VideoFeedState extends ConsumerState<_VideoFeed> {
  int _currentIndex = 0;
  bool _initialIndexSet = false;
  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Teaching', 'Music Video', 'Ritual', 'Documentary'];

  @override
  Widget build(BuildContext context) {
    final videoState = ref.watch(videoListProvider(
      isFeatured: widget.isFeatured,
      category: _selectedCategory == 'All' ? null : _selectedCategory,
    ));
    final isPremium = ref.watch(authProvider).user?.isPremium ?? false;

    return Stack(
      children: [
        videoState.when(
          data: (videos) {
            if (videos.data.isEmpty) return const _EmptyFeed();
            
            // Set initial index once if provided
            if (widget.initialVideoId != null && !_initialIndexSet && !widget.isFeatured) {
               final index = videos.data.indexWhere((v) => v.id == widget.initialVideoId);
               if (index != -1) {
                 _currentIndex = index;
               }
               _initialIndexSet = true;
            }

            return RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(videoListProvider);
              },
              child: PageView.builder(
                    controller: PageController(initialPage: _currentIndex),
                    scrollDirection: Axis.vertical,
                    itemCount: videos.data.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final video = videos.data[index];
                      return _VideoReelItem(
                        video: video,
                        shouldPlay: index == _currentIndex,
                      );
                    },
                  ),
            );
          },
          loading: () => Center(
            child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
          ),
          error: (err, stack) => _ErrorView(error: err.toString()),
        ),

        // Category Filters (Horizontal)
        Positioned(
          top: 50, // Reduced from 80
          left: 0,
          right: 0,
          child: SizedBox(
            height: 40,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;
                return ChoiceChip(
                  label: Text(category, style: const TextStyle(fontSize: 12)),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategory = category;
                      _currentIndex = 0; // Reset index when filtering
                    });
                  },
                  backgroundColor: Colors.black45,
                  selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.black : Colors.white70,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                );
              },
            ),
          ),
        ),

        if (!isPremium)
          Positioned(
            top: 50,
            right: 16,
            child: TextButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SubscriptionScreen())),
              style: TextButton.styleFrom(
                backgroundColor: Colors.black.withOpacity(0.5),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: Text('GET PLUS+', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold, fontSize: 10)),
            ),
          ),
        const Positioned(
          top: 0, // Reduced from 40
          left: 0,
          right: 0,
          child: Center(child: AdBanner(screenKey: 'reels')),
        ),
      ],
    );
  }
}

class _VideoReelItem extends ConsumerWidget {
  final Video video;
  final bool shouldPlay;
  const _VideoReelItem({required this.video, required this.shouldPlay});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (shouldPlay) {
      Future.microtask(() {
        Future.delayed(const Duration(seconds: 2), () {
          if (ref.read(videoHeaderVisibleProvider)) {
            ref.read(videoHeaderVisibleProvider.notifier).state = false;
          }
        });
      });
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        // Video Player
        VideoPlayerWidget(video: video, shouldPlay: shouldPlay),

        // Dim Overlay (Gradient from bottom)
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.1),
                Colors.transparent,
                Colors.black.withOpacity(0.4),
                Colors.black.withOpacity(0.9),
              ],
              stops: const [0.0, 0.2, 0.7, 1.0],
            ),
          ),
        ),

        // Interaction Layer
        GestureDetector(
          onTap: () {
            ref.read(videoHeaderVisibleProvider.notifier).state = true;
          },
          behavior: HitTestBehavior.translucent,
        ),

        // Right Side Actions
        Positioned(
          right: 8,
          bottom: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Removed avatar since admin posts videos
              const SizedBox(height: 20),
              
              // Like
              _ReelAction(
                icon: Icons.favorite_rounded,
                label: '${video.likesCount ?? 0}',
                color: (video.isLiked) ? Theme.of(context).colorScheme.primary : Colors.white,
                onTap: () {
                   // Like Logic
                },
              ),
              
              // Comment
              _ReelAction(
                icon: Icons.chat_bubble_rounded,
                label: '${video.commentsCount ?? 0}', 
                onTap: () => CommentBottomSheet.show(context, 'video', video.id),
              ),

              // Save/Bookmark
              _ReelAction(
                icon: Icons.bookmark_rounded,
                label: 'Save',
                onTap: () {},
              ),

              // Share
              _ReelAction(
                icon: Icons.share_rounded,
                label: 'Share',
                onTap: () {
                   ref.read(videoHeaderVisibleProvider.notifier).state = true;
                   Share.share(video.title);
                },
              ),
              
              const SizedBox(height: 20),
              // Spinning Disc (Music)
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Colors.grey, Colors.black]),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white30, width: 8),
                ),
                child: const Icon(Icons.music_note, color: Colors.white, size: 20),
              ),
            ],
          ),
        ),

        // Bottom Metadata
        Positioned(
          left: 16,
          right: 80, // Space for right actions
          bottom: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Removed username and teacher badge since admin posts
              const SizedBox(height: 8),
              Text(
                video.description ?? video.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
              // Show tags if available
              if (video.tags != null && video.tags!.isNotEmpty)
                Wrap(
                  spacing: 8,
                  children: video.tags!.take(3).map((tag) => Text(
                    '#$tag',
                    style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 12, fontWeight: FontWeight.w600),
                  )).toList(),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ReelAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  const _ReelAction({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black26, 
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyFeed extends StatelessWidget {
  const _EmptyFeed();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.video_collection_rounded, size: 64, color: Colors.blueGrey),
          SizedBox(height: 16),
          Text('No reels available yet.', style: TextStyle(color: Colors.white54)),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String error;
  const _ErrorView({required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline_rounded, color: Colors.redAccent, size: 48),
            const SizedBox(height: 16),
            Text('Reels unavailable: $error', textAlign: TextAlign.center, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
