import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/audio/providers/current_audio_provider.dart';
import 'package:Watered/features/audio/services/audio_service.dart';
import 'package:Watered/features/audio/widgets/audio_player_bottom_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MiniPlayer extends ConsumerWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentAudio = ref.watch(currentAudioProvider);
    final audioService = ref.watch(audioServiceProvider);

    if (currentAudio == null) return const SizedBox.shrink();

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => AudioPlayerBottomSheet(audio: currentAudio),
        );
      },
      child: Container(
        height: 64,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            // Artwork
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: currentAudio.thumbnailUrl != null
                  ? CachedNetworkImage(
                      imageUrl: currentAudio.thumbnailUrl!,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: 40,
                      height: 40,
                      color: const Color(0xFFD4AF37).withOpacity(0.1),
                      child: const Icon(Icons.music_note_rounded, color: Color(0xFFD4AF37), size: 20),
                    ),
            ),
            const SizedBox(width: 12),
            // Title & Author
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentAudio.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    currentAudio.author ?? 'Watered Scholar',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
            // Play/Pause Control
            StreamBuilder<bool>(
              stream: audioService.playingStream,
              builder: (context, snapshot) {
                final isPlaying = snapshot.data ?? false;
                return IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    color: const Color(0xFFD4AF37),
                    size: 32,
                  ),
                  onPressed: () => isPlaying ? audioService.pause() : audioService.play(),
                );
              },
            ),
            // Close button
            IconButton(
              icon: Icon(Icons.close_rounded, color: Colors.white.withOpacity(0.3), size: 20),
              onPressed: () {
                audioService.stop();
                ref.read(currentAudioProvider.notifier).state = null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
