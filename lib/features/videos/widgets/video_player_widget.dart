import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'package:wateredflutterapp/features/videos/models/video.dart';
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
        _chewieController = ChewieController(
          videoPlayerController: _videoController!,
          autoPlay: false,
          looping: true,
          showControls: false, // TikTok style usually has minimal controls
          aspectRatio: _videoController!.value.aspectRatio,
        );
      }
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
    if (!_isInitialized) return;
    if (widget.video.videoType == 'youtube') {
      _youtubeController?.play();
    } else {
      _videoController?.play();
    }
  }

  void _pause() {
    if (!_isInitialized) return;
    if (widget.video.videoType == 'youtube') {
      _youtubeController?.pause();
    } else {
      _videoController?.pause();
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
      return Center(
        child: CircularProgressIndicator(
          color: const Color(0xFFD4AF37),
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
        progressIndicatorColor: const Color(0xFFD4AF37),
        progressColors: const ProgressBarColors(
          playedColor: Color(0xFFD4AF37),
          handleColor: Color(0xFFD4AF37),
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
