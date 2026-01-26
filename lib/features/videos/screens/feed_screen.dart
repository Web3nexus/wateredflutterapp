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
import 'package:Watered/features/subscription/screens/subscription_screen.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final videoState = ref.watch(videoListProvider());
    final isPremium = ref.watch(authProvider).user?.isPremium ?? false;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          videoState.when(
            data: (videos) => videos.data.isEmpty
                ? const _EmptyFeed()
                : PageView.builder(
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
            loading: () => const Center(
              child: CircularProgressIndicator(color: Color(0xFFD4AF37)),
            ),
            error: (err, stack) => _ErrorView(error: err.toString()),
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
                child: const Text('GET PLUS+', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 10)),
              ),
            ),
          const Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Center(child: AdBanner(screenKey: 'reels')),
          ),
        ],
      ),
    );
  }
}

class _VideoReelItem extends ConsumerWidget {
  final Video video;
  final bool shouldPlay;
  const _VideoReelItem({required this.video, required this.shouldPlay});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Video Player
        VideoPlayerWidget(video: video, shouldPlay: shouldPlay),

        // Dim Overlay (Gradient)
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0),
                Colors.black.withOpacity(0),
                Colors.black.withOpacity(0.8),
              ],
              stops: const [0, 0.2, 0.7, 1],
            ),
          ),
        ),

        // Metadata Overlay
        Positioned(
          left: 16,
          right: 80,
          bottom: 40,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFD4AF37).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.5)),
                ),
                child: const Text('REEL TEACHING', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
              ),
              const SizedBox(height: 12),
              Text(video.title, style: const TextStyle(fontFamily: 'Cinzel', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 8),
              if (video.description != null)
                Text(video.description!, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 15, height: 1.4)),
            ],
          ),
        ),

        Positioned(
          right: 12,
          bottom: 40,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ActionButton(
                icon: video.isLiked ?? false ? Icons.favorite : Icons.favorite_border_rounded,
                label: 'Like',
                color: video.isLiked ?? false ? Colors.redAccent : null,
                onTap: () async {
                   if (!ref.read(authProvider).isAuthenticated) {
                     Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LoginScreen()));
                     return;
                   }
                   await ref.read(interactionServiceProvider).toggleLike('video', video.id);
                   ref.refresh(videoListProvider());
                },
              ),
              const SizedBox(height: 20),
              _ActionButton(
                icon: Icons.chat_bubble_outline_rounded,
                label: 'Comment',
                onTap: () => CommentBottomSheet.show(context, 'video', video.id),
              ),
              const SizedBox(height: 20),
              _ActionButton(icon: Icons.share_rounded, label: 'Share', onTap: () {}),
              const SizedBox(height: 20),
              _ActionButton(icon: Icons.bookmark_border_rounded, label: 'Save', onTap: () {}),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;
  const _ActionButton({required this.icon, required this.label, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.1)),
            child: Icon(icon, color: color ?? Colors.white, size: 28),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500)),
        ],
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
