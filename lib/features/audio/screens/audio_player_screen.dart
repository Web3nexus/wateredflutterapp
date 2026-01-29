import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:Watered/features/audio/models/audio.dart';
import 'package:Watered/features/audio/services/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AudioPlayerScreen extends ConsumerStatefulWidget {
  final Audio audio;

  const AudioPlayerScreen({super.key, required this.audio});

  @override
  ConsumerState<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends ConsumerState<AudioPlayerScreen> {
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    final audioService = ref.read(audioServiceProvider);
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
          _error = e.toString();
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
              widget.audio.title,
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
            // Album Art
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Container(
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
                          widget.audio.title,
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
                  IconButton(
                    icon: Icon(
                      widget.audio.isLiked ? Icons.favorite : Icons.favorite_border_rounded,
                      color: Colors.redAccent,
                      size: 28,
                    ),
                    onPressed: () {
                      // Toggle like logic
                    },
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

            // Bottom Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _BottomAction(icon: Icons.ios_share_rounded, label: 'SHARE', onTap: () {}),
                const SizedBox(width: 40),
                _BottomAction(icon: Icons.playlist_add_rounded, label: 'ADD', onTap: () {}),
                const SizedBox(width: 40),
                _BottomAction(icon: Icons.lyrics_outlined, label: 'LYRICS', onTap: () {}),
              ],
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _BottomAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _BottomAction({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryTextColor = theme.textTheme.bodyMedium?.color?.withOpacity(0.5) ?? Colors.grey;

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.blue, size: 24),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: secondaryTextColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
