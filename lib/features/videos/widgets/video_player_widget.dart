import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'package:Watered/features/videos/models/video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerWidget extends ConsumerStatefulWidget {
  final Video video;
  final bool shouldPlay;

  const VideoPlayerWidget({
    super.key,
    required this.video,
    required this.shouldPlay,
  });

  @override
  ConsumerState<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends ConsumerState<VideoPlayerWidget> {
  // Youtube
  YoutubePlayerController? _youtubeController;

  // Generic
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;

  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  @override
  void didUpdateWidget(covariant VideoPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.shouldPlay != widget.shouldPlay) {
      if (widget.shouldPlay) {
        _play();
      } else {
        _pause();
      }
    }
  }

  Future<void> _initializePlayer() async {
    try {
      if (widget.video.videoType == 'youtube') {
        final videoId = YoutubePlayer.convertUrlToId(widget.video.youtubeUrl);
        if (videoId != null) {
          _youtubeController = YoutubePlayerController(
            initialVideoId: videoId,
            flags: const YoutubePlayerFlags(
              autoPlay: false,
              mute: false,
              disableDragSeek: true,
              loop: true,
              forceHD: true,
            ),
          );
        }
      } else {
        // Generic video (Bunny.net, S3, etc)
        if (widget.video.storageUrl != null) {
          _videoController = VideoPlayerController.networkUrl(
            Uri.parse(widget.video.storageUrl!),
          );
          await _videoController!.initialize();
          
          _videoController!.addListener(() {
            if (_videoController!.value.hasError) {
              print('Video Player Error: ${_videoController!.value.errorDescription}');
            }
          });

          _chewieController = ChewieController(
            videoPlayerController: _videoController!,
            autoPlay: widget.shouldPlay,
            looping: true,
            showControls: false,
            aspectRatio: _videoController!.value.aspectRatio,
            errorBuilder: (context, errorMessage) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.white, size: 40),
                    const SizedBox(height: 12),
                    Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          );
        }
      }
    } catch (e) {
      print('Error initializing video player: $e');
    }

    if (mounted) {
      setState(() {
        _isInitialized = true;
      });
      if (widget.shouldPlay) {
        _play();
      }
    }
  }

  void _play() {
    if (!_isInitialized) {
      print('Video not initialized, skipping play()');
      return;
    }
    if (widget.video.videoType == 'youtube') {
      _youtubeController?.play();
    } else {
      if (_videoController != null && !_videoController!.value.isPlaying) {
        _videoController!.play().then((_) {
          if (mounted) setState(() {});
        }).catchError((e) {
          print('Error playing video: $e');
        });
      }
    }
  }

  void _pause() {
    if (!_isInitialized) return;
    if (widget.video.videoType == 'youtube') {
      _youtubeController?.pause();
    } else {
      if (_videoController != null && _videoController!.value.isPlaying) {
        _videoController?.pause();
      }
    }
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
            strokeWidth: 2,
          ),
        ),
      );
    }

    if (widget.video.videoType == 'youtube') {
      if (_youtubeController == null) {
        return const Center(child: Text('Invalid YouTube URL', style: TextStyle(color: Colors.white)));
      }
      return YoutubePlayer(
        controller: _youtubeController!,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Theme.of(context).colorScheme.primary,
        progressColors: const ProgressBarColors(
          playedColor: Theme.of(context).colorScheme.primary,
          handleColor: Theme.of(context).colorScheme.primary,
        ),
        bottomActions: const [], // Hide default controls for TikTok feel
      );
    } else {
      // File / Storage video
      if (_chewieController != null && _chewieController!.videoPlayerController.value.isInitialized) {
        return Chewie(controller: _chewieController!);
      } else {
        return const Center(child: Text('Video unavailable', style: TextStyle(color: Colors.white)));
      }
    }
  }
}
