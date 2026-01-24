import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/audio/models/audio.dart';
import 'package:Watered/features/audio/providers/audio_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:Watered/features/audio/services/audio_service.dart';
import 'package:Watered/features/audio/providers/current_audio_provider.dart';
import 'package:Watered/features/audio/widgets/audio_player_bottom_sheet.dart';

class AudioFeedScreen extends ConsumerWidget {
  const AudioFeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioState = ref.watch(audioListProvider());

    return Scaffold(
      appBar: AppBar(title: const Text('AUDIO TEACHINGS')),
      body: RefreshIndicator(
        onRefresh: () => ref.read(audioListProvider().notifier).refresh(),
        child: audioState.when(
          data: (audios) => audios.data.isEmpty
              ? const _EmptyAudioFeed()
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  itemCount: audios.data.length,
                  itemBuilder: (context, index) {
                    return _AudioCard(audio: audios.data[index]);
                  },
                ),
          loading: () => const _AudioFeedLoading(),
          error: (err, stack) => Center(child: Text('Wisdom delayed: $err')),
        ),
      ),
    );
  }
}

class _AudioCard extends ConsumerWidget {
  final Audio audio;
  const _AudioCard({required this.audio});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: InkWell(
        onTap: () async {
          ref.read(currentAudioProvider.notifier).state = audio;
          await ref.read(audioServiceProvider).loadAudio(audio);
          await ref.read(audioServiceProvider).play();

          if (context.mounted) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => AudioPlayerBottomSheet(audio: audio),
            );
          }
        },
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Artwork
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: audio.thumbnailUrl != null
                    ? CachedNetworkImage(
                        imageUrl: audio.thumbnailUrl!,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(color: Colors.white10),
                      )
                    : Container(
                        width: 80,
                        height: 80,
                        color: const Color(0xFFD4AF37).withOpacity(0.1),
                        child: const Icon(
                          Icons.music_note_rounded,
                          color: Color(0xFFD4AF37),
                        ),
                      ),
              ),
              const SizedBox(width: 16),
              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      audio.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Outfit',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      audio.author ?? 'Watered Scholar',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.5),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (audio.duration != null) ...[
                          Icon(
                            Icons.timer_outlined,
                            size: 12,
                            color: const Color(0xFFD4AF37).withOpacity(0.7),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            audio.duration!,
                            style: TextStyle(
                              fontSize: 11,
                              color: const Color(0xFFD4AF37).withOpacity(0.7),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              // Play Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFD4AF37).withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: Color(0xFFD4AF37),
                  size: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AudioFeedLoading extends StatelessWidget {
  const _AudioFeedLoading();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.white10,
        highlightColor: Colors.white.withOpacity(0.05),
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          height: 104,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
    );
  }
}

class _EmptyAudioFeed extends StatelessWidget {
  const _EmptyAudioFeed();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.mic_none_rounded,
            size: 64,
            color: Colors.blueGrey.shade700,
          ),
          const SizedBox(height: 16),
          const Text(
            'The sound of silence... no audios yet.',
            style: TextStyle(color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }
}
