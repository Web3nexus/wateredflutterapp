import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/audio/models/audio.dart';
import 'package:Watered/features/audio/services/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:Watered/core/services/interaction_service.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:share_plus/share_plus.dart';

class AudioPlayerBottomSheet extends ConsumerStatefulWidget {
  final Audio audio;
  const AudioPlayerBottomSheet({super.key, required this.audio});

  @override
  ConsumerState<AudioPlayerBottomSheet> createState() => _AudioPlayerBottomSheetState();
}

class _AudioPlayerBottomSheetState extends ConsumerState<AudioPlayerBottomSheet> {
  late bool _isLiked;
  late int _likesCount;
  late bool _isSaved;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.audio.isLiked;
    _likesCount = widget.audio.likesCount ?? 0;
    _isSaved = false; // TODO: Fetch from bookmarks API
  }

  @override
  Widget build(BuildContext context) {
    final audioService = ref.watch(audioServiceProvider);

    if (!audioService.isReady) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

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
            child: widget.audio.thumbnailUrl != null
                ? CachedNetworkImage(
                    imageUrl: widget.audio.thumbnailUrl!,
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
            widget.audio.title ?? 'Unknown Title',
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
            widget.audio.author ?? 'Watered Scholar',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.8),
              fontFamily: 'Outfit',
            ),
          ),
          if (widget.audio.category != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  widget.audio.category!.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
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
                  audioService.internalPlayer!.position - const Duration(seconds: 10),
                ),
              ),
              const SizedBox(width: 24),
              StreamBuilder<PlayerState>(
                stream: audioService.playerStateStream,
                builder: (context, snapshot) {
                  final state = snapshot.data;
                  final isPlaying = state?.playing ?? false;
                  final processingState = state?.processingState ?? ProcessingState.idle;

                  if (processingState == ProcessingState.loading || processingState == ProcessingState.buffering) {
                    return Container(
                      width: 80,
                      height: 80,
                      padding: const EdgeInsets.all(20),
                      child: const CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
                      ),
                    );
                  }

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
                  audioService.internalPlayer!.position + const Duration(seconds: 10),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Interaction Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  _isLiked ? Icons.favorite : Icons.favorite_border_rounded,
                  color: _isLiked ? Colors.redAccent : Theme.of(context).iconTheme.color,
                  size: 28,
                ),
                onPressed: _toggleLike,
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: Icon(
                  _isSaved ? Icons.bookmark : Icons.bookmark_border_rounded,
                  color: _isSaved ? Theme.of(context).colorScheme.primary : Theme.of(context).iconTheme.color,
                  size: 28,
                ),
                onPressed: _toggleSave,
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: Icon(
                  Icons.share_rounded,
                  color: Theme.of(context).iconTheme.color,
                  size: 28,
                ),
                onPressed: _shareAudio,
              ),
            ],
          ),
          const SizedBox(height: 16),
          if ((widget.audio.audioUrl?.contains('audiomack.com') ?? false) || 
              (widget.audio.audioUrl?.contains('spotify.com') ?? false) || 
              (widget.audio.audioUrl?.contains('youtube.com') ?? false))
            TextButton.icon(
              onPressed: () => launchUrl(Uri.parse(widget.audio.audioUrl ?? ''), mode: LaunchMode.externalApplication),
              icon: Icon(Icons.open_in_new_rounded, color: Theme.of(context).colorScheme.primary, size: 16),
              label: Text('OPEN IN STREAMING PLATFORM', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Future<void> _toggleLike() async {
    try {
      final interactionService = ref.read(interactionServiceProvider);
      final result = await interactionService.toggleLike('audio', widget.audio.id);
      
      if (mounted) {
        setState(() {
          _isLiked = result['liked'] ?? !_isLiked;
          _likesCount = result['likes_count'] ?? _likesCount;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update like: $e')),
        );
      }
    }
  }

  Future<void> _toggleSave() async {
    try {
      final apiClient = ref.read(apiClientProvider);
      
      if (_isSaved) {
        await apiClient.delete('bookmarks/item', data: {
          'bookmarkable_id': widget.audio.id,
          'bookmarkable_type': 'App\\Models\\Audio',
        });
      } else {
        await apiClient.post('bookmarks', data: {
          'bookmarkable_id': widget.audio.id,
          'bookmarkable_type': 'App\\Models\\Audio',
        });
      }
      
      if (mounted) {
        setState(() {
          _isSaved = !_isSaved;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update bookmark: $e')),
        );
      }
    }
  }

  void _shareAudio() {
    Share.share(
      '${widget.audio.title ?? "Unknown Title"} by ${widget.audio.author ?? "Unknown Artist"}\n\nListen on Watered',
      subject: widget.audio.title ?? "Audio Share",
    );
  }
}
