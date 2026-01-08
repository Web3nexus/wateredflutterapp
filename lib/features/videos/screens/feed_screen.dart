import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wateredflutterapp/features/videos/providers/video_provider.dart';
import 'package:wateredflutterapp/features/videos/models/video.dart';

class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoState = ref.watch(videoListProvider());

    return Scaffold(
      backgroundColor: Colors.black,
      body: videoState.when(
        data: (videos) => videos.data.isEmpty
            ? const _EmptyFeed()
            : PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: videos.data.length,
                itemBuilder: (context, index) {
                  final video = videos.data[index];
                  return _VideoReelItem(video: video);
                },
              ),
        loading: () => const Center(
          child: CircularProgressIndicator(color: Color(0xFFD4AF37)),
        ),
        error: (err, stack) => _ErrorView(error: err.toString()),
      ),
    );
  }
}

class _VideoReelItem extends StatelessWidget {
  final Video video;
  const _VideoReelItem({required this.video});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Video/Thumbnail (TikTok style)
        if (video.thumbnailUrl != null)
          Image.network(
            video.thumbnailUrl!,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => _buildPlaceholder(),
          )
        else
          _buildPlaceholder(),

        // Dim Overlay
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

        // Play Button Center
        Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(0.3),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: const Icon(
              Icons.play_arrow_rounded,
              size: 60,
              color: Colors.white70,
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
                child: const Text(
                  'REEL TEACHING',
                  style: TextStyle(
                    color: Color(0xFFD4AF37),
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                video.title,
                style: const TextStyle(
                  fontFamily: 'Cinzel',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black, blurRadius: 10)],
                ),
              ),
              const SizedBox(height: 8),
              if (video.description != null)
                Text(
                  video.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 15,
                    height: 1.4,
                    shadows: const [Shadow(color: Colors.black, blurRadius: 4)],
                  ),
                ),
            ],
          ),
        ),

        // Right Action Bar
        Positioned(
          right: 12,
          bottom: 40,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ActionButton(icon: Icons.favorite_border_rounded, label: 'Liking'),
              const SizedBox(height: 20),
              _ActionButton(icon: Icons.chat_bubble_outline_rounded, label: 'Discuss'),
              const SizedBox(height: 20),
              _ActionButton(icon: Icons.share_rounded, label: 'Spread'),
              const SizedBox(height: 20),
              _ActionButton(icon: Icons.bookmark_border_rounded, label: 'Save'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: const Color(0xFF0F172A),
      child: Center(
        child: Icon(
          Icons.video_library_rounded,
          size: 80,
          color: Colors.white.withOpacity(0.05),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.1),
          ),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
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
          const SizedBox(height: 16),
          const Text('No reels available yet.', style: TextStyle(color: Colors.white54)),
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
            Text(
              'Reels unavailable: $error',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
