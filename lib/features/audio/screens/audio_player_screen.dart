import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:Watered/features/audio/models/audio.dart';
import 'package:Watered/features/audio/services/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Watered/core/services/interaction_service.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AudioPlayerScreen extends ConsumerStatefulWidget {
  final Audio audio;

  const AudioPlayerScreen({super.key, required this.audio});

  @override
  ConsumerState<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends ConsumerState<AudioPlayerScreen> {
  bool _isLoading = true;
  String? _error;
  bool _isLiked = false;
  int _likesCount = 0;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.audio.isLiked;
    _likesCount = widget.audio.likesCount ?? 0;
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    // Safety check: Wait for player to be instantiated if it isn't yet
    if (!ref.read(audioServiceProvider).isReady) {
      print('⏳ [AudioScreen] Waiting for AudioService to be ready...');
      await ref.read(audioPlayerProvider.future);
    }
    // Re-read after await to get the updated service instance with player set
    final audioService = ref.read(audioServiceProvider);
    
    // Check if streamable before loading
    if (!audioService.isStreamable(widget.audio.audioUrl ?? '')) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _error = "This content is hosted on an external platform (${_getPlatformName(widget.audio.audioUrl ?? '')}). Please use the button below to listen there.";
        });
      }
      return;
    }

    try {
      await audioService.loadAudio(widget.audio);
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        await audioService.play();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _error = "Unable to play audio: ${e.toString()}";
        });
      }
    }
  }

  // No need for dispose here, AudioService manages the player lifecycle
  // @override
  // void dispose() {
  //   _player.dispose();
  //   super.dispose();
  // }

  String _formatDuration(Duration? duration) {
    if (duration == null) return '--:--';
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final audioService = ref.watch(audioServiceProvider);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final secondaryTextColor = textColor.withOpacity(0.6);
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: textColor, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Column(
          children: [
            Text(
              'NOW PLAYING',
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontSize: 10,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.audio.title ?? 'Unknown Title',
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert_rounded, color: textColor),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Album Art or Error Display
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: _error != null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline_rounded,
                              size: 80,
                              color: Colors.redAccent.withOpacity(0.7),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Playback Error',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: Text(
                                _error!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: secondaryTextColor,
                                  height: 1.5,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  _error = null;
                                  _isLoading = true;
                                });
                                _initPlayer();
                              },
                              icon: const Icon(Icons.refresh_rounded),
                              label: const Text('Retry'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Audio URL: ${widget.audio.audioUrl ?? "None"}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10,
                                color: secondaryTextColor.withOpacity(0.5),
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                      )
                    : _isLoading
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(color: theme.colorScheme.primary),
                                const SizedBox(height: 16),
                                Text(
                                  'Loading audio...',
                                  style: TextStyle(color: secondaryTextColor),
                                ),
                              ],
                            ),
                          )
                        : _error != null && !audioService.isStreamable(widget.audio.audioUrl ?? '')
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.open_in_new_rounded, size: 64, color: theme.colorScheme.primary),
                                    const SizedBox(height: 24),
                                    ElevatedButton.icon(
                                      onPressed: () => launchUrl(Uri.parse(widget.audio.audioUrl ?? '')),
                                      icon: const Icon(Icons.launch_rounded),
                                      label: Text('Open in ${_getPlatformName(widget.audio.audioUrl ?? '')}'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: theme.colorScheme.primary,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 30,
                                  offset: const Offset(0, 15),
                                ),
                              ],
                              image: widget.audio.thumbnailUrl != null 
                                  ? DecorationImage(
                                      image: CachedNetworkImageProvider(widget.audio.thumbnailUrl!),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: widget.audio.thumbnailUrl == null
                              ? Container(
                                  decoration: BoxDecoration(
                                    color: theme.dividerColor.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Icon(Icons.music_note, size: 100, color: theme.colorScheme.primary.withOpacity(0.3)),
                                )
                              : null,
                          ),
              ),
            ),
            
            const SizedBox(height: 40),

            // Track Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.audio.title ?? 'Unknown Title',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Outfit', // Using Outfit or similar if avail
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          widget.audio.author ?? 'Unknown Artist',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: secondaryTextColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          _isLiked ? Icons.favorite : Icons.favorite_border_rounded,
                          color: _isLiked ? Colors.redAccent : textColor,
                          size: 28,
                        ),
                        onPressed: _toggleLike,
                      ),
                      IconButton(
                        icon: Icon(
                          _isSaved ? Icons.bookmark : Icons.bookmark_border_rounded,
                          color: _isSaved ? theme.colorScheme.primary : textColor,
                          size: 28,
                        ),
                        onPressed: _toggleSave,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.share_rounded,
                          color: textColor,
                          size: 28,
                        ),
                        onPressed: _shareAudio,
                      ),
                    ],
                  ),
                ],
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
                    final total = snapshot.data ?? Duration.zero;
                    
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 4,
                              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                              overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
                              activeTrackColor: Colors.blue, // Using blue as requested
                              inactiveTrackColor: theme.dividerColor.withOpacity(0.1),
                              thumbColor: Colors.blue,
                              overlayColor: Colors.blue.withOpacity(0.2),
                            ),
                            child: Slider(
                              value: position.inSeconds.toDouble().clamp(0, total.inSeconds.toDouble()),
                              max: total.inSeconds.toDouble() > 0 ? total.inSeconds.toDouble() : 1,
                              onChanged: (val) {
                                audioService.seek(Duration(seconds: val.toInt()));
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_formatDuration(position), style: TextStyle(color: secondaryTextColor, fontSize: 12)),
                                Text(_formatDuration(total), style: TextStyle(color: secondaryTextColor, fontSize: 12)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                );
              },
            ),

            const SizedBox(height: 24),

            // Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.shuffle_rounded, color: secondaryTextColor, size: 24),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.skip_previous_rounded, color: Colors.blue, size: 36),
                  onPressed: () {},
                ),
                StreamBuilder<bool>(
                  stream: audioService.playingStream,
                  builder: (context, snapshot) {
                    final playing = snapshot.data ?? false;
                    return Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: Colors.blue, // Using blue as requested
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: IconButton(
                        iconSize: 32,
                        icon: Icon(playing ? Icons.pause_rounded : Icons.play_arrow_rounded, color: Colors.white),
                        onPressed: () {
                          if (playing) {
                            audioService.pause();
                          } else {
                            audioService.play();
                          }
                        },
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.skip_next_rounded, color: Colors.blue, size: 36),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.repeat_rounded, color: secondaryTextColor, size: 24),
                  onPressed: () {},
                ),
              ],
            ),

            const SizedBox(height: 48),

          ],
        ),
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
        // Remove bookmark
        await apiClient.delete('bookmarks/item', data: {
          'bookmarkable_id': widget.audio.id,
          'bookmarkable_type': 'App\\Models\\Audio',
        });
      } else {
        // Add bookmark
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

  String _getPlatformName(String url) {
    final lower = url.toLowerCase();
    if (lower.contains('youtube.com') || lower.contains('youtu.be')) return 'YouTube';
    if (lower.contains('spotify.com')) return 'Spotify';
    if (lower.contains('audiomack.com')) return 'Audiomack';
    if (lower.contains('music.apple.com')) return 'Apple Music';
    return 'Browser';
  }
}

