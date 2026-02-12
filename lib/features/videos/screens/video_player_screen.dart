import 'package:flutter/material.dart';
import 'package:Watered/features/videos/models/video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:Watered/features/activity/widgets/activity_tracker.dart';

class VideoPlayerScreen extends StatefulWidget {
  final Video video;
  final bool shouldPlay;
  const VideoPlayerScreen({super.key, required this.video, this.shouldPlay = false});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  YoutubePlayerController? _youtubeController;
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _isYoutube = true;

  @override
  void initState() {
    super.initState();
    _isYoutube = widget.video.videoType == 'youtube';
    
    if (_isYoutube) {
      final videoId = YoutubePlayer.convertUrlToId(widget.video.youtubeUrl ?? '') ?? '';
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: YoutubePlayerFlags(
          autoPlay: widget.shouldPlay,
          mute: false,
        ),
      );
    } else if (widget.video.storageUrl != null) {
      _initializeFilePlayer();
    }
  }

  Future<void> _initializeFilePlayer() async {
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.video.storageUrl!),
    );
    
    await _videoPlayerController!.initialize();
    
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      autoPlay: widget.shouldPlay,
      looping: false,
      aspectRatio: _videoPlayerController!.value.aspectRatio,
      placeholder: Container(
        color: Colors.black,
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
    
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    // Reset system UI when leaving video player
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ActivityTracker(
      pageName: 'video_player',
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              widget.video.title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          body: Center(
            child: _isYoutube
                ? YoutubePlayer(
                    controller: _youtubeController!,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Theme.of(context).colorScheme.primary,
                  )
                : _chewieController != null
                    ? AspectRatio(
                        aspectRatio: _videoPlayerController!.value.aspectRatio,
                        child: Chewie(controller: _chewieController!),
                      )
                    : const CircularProgressIndicator(),
          ),
        ),
    );
  }
}
