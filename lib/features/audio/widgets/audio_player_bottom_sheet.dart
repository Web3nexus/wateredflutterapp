import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/audio/models/audio.dart';
import 'package:Watered/features/audio/services/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class AudioPlayerBottomSheet extends ConsumerWidget {
  final Audio audio;
  const AudioPlayerBottomSheet({super.key, required this.audio});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioService = ref.watch(audioServiceProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
        border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 32),
          // Artwork
          ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: audio.thumbnailUrl != null
                ? CachedNetworkImage(
                    imageUrl: audio.thumbnailUrl!,
                    width: 240,
                    height: 240,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 240,
                    height: 240,
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    child: Icon(Icons.music_note_rounded, color: Theme.of(context).colorScheme.primary, size: 80),
                  ),
          ),
          const SizedBox(height: 32),
          // Title & Author
          Text(
            audio.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cinzel',
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            audio.author ?? 'Watered Scholar',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
              fontFamily: 'Outfit',
            ),
          ),
          const SizedBox(height: 32),
          // Progress Bar
          StreamBuilder<Duration>(
            stream: audioService.positionStream,
            builder: (context, snapshot) {
              final position = snapshot.data ?? Duration.zero;
              return StreamBuilder<Duration?>(
                stream: audioService.durationStream,
                builder: (context, snapshot) {
                  final duration = snapshot.data ?? Duration.zero;
                  return ProgressBar(
                    progress: position,
                    total: duration,
                    onSeek: (duration) => audioService.seek(duration),
                    progressBarColor: Theme.of(context).colorScheme.primary,
                    baseBarColor: Theme.of(context).dividerColor.withOpacity(0.1),
                    thumbColor: Theme.of(context).colorScheme.primary,
                    timeLabelTextStyle: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.5)),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 32),
          // Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.replay_10_rounded, size: 32, color: Theme.of(context).iconTheme.color),
                onPressed: () => audioService.seek(
                  audioService.player.position - const Duration(seconds: 10),
                ),
              ),
              const SizedBox(width: 24),
              StreamBuilder<bool>(
                stream: audioService.playingStream,
                builder: (context, snapshot) {
                  final isPlaying = snapshot.data ?? false;
                  return Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                        size: 48,
                        color: Colors.black,
                      ),
                      onPressed: () => isPlaying ? audioService.pause() : audioService.play(),
                    ),
                  );
                },
              ),
              const SizedBox(width: 24),
              IconButton(
                icon: Icon(Icons.forward_10_rounded, size: 32, color: Theme.of(context).iconTheme.color),
                onPressed: () => audioService.seek(
                  audioService.player.position + const Duration(seconds: 10),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (audio.audioUrl.contains('audiomack.com') || audio.audioUrl.contains('spotify.com') || audio.audioUrl.contains('youtube.com'))
            TextButton.icon(
              onPressed: () => launchUrl(Uri.parse(audio.audioUrl), mode: LaunchMode.externalApplication),
              icon: Icon(Icons.open_in_new_rounded, color: Theme.of(context).colorScheme.primary, size: 16),
              label: Text('OPEN IN STREAMING PLATFORM', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
