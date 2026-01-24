import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/incantations/models/incantation.dart';
import 'package:just_audio/just_audio.dart';

class IncantationDetailScreen extends ConsumerStatefulWidget {
  final Incantation incantation;

  const IncantationDetailScreen({super.key, required this.incantation});

  @override
  ConsumerState<IncantationDetailScreen> createState() => _IncantationDetailScreenState();
}

class _IncantationDetailScreenState extends ConsumerState<IncantationDetailScreen> {
  late AudioPlayer _player;
  bool _isPlaying = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _initAudio();
  }

  Future<void> _initAudio() async {
    if (widget.incantation.audioUrl != null) {
      try {
        setState(() => _isLoading = true);
        await _player.setUrl(widget.incantation.audioUrl!);
        
        _player.playerStateStream.listen((state) {
            if (mounted) {
                setState(() {
                    _isPlaying = state.playing;
                    // Reset when finished
                    if (state.processingState == ProcessingState.completed) {
                        _isPlaying = false;
                        _player.seek(Duration.zero);
                        _player.pause();
                    }
                });
            }
        });

      } catch (e) {
        print("Error loading audio: $e");
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final incantation = widget.incantation;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(incantation.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Center for audio player feel
          children: [
            if (incantation.audioUrl != null) ...[
                Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.colorScheme.primary.withOpacity(0.1),
                        border: Border.all(color: theme.colorScheme.primary.withOpacity(0.3), width: 2),
                        boxShadow: [
                            BoxShadow(
                                color: theme.colorScheme.primary.withOpacity(0.2),
                                blurRadius: 30,
                                spreadRadius: 5,
                            )
                        ]
                    ),
                    child: Center(
                        child: _isLoading 
                            ? const CircularProgressIndicator()
                            : IconButton(
                                iconSize: 64,
                                icon: Icon(_isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded),
                                color: theme.colorScheme.primary,
                                onPressed: () {
                                    if (_isPlaying) {
                                        _player.pause();
                                    } else {
                                        _player.play();
                                    }
                                },
                            ),
                    ),
                ),
                const SizedBox(height: 32),
            ],

            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Incantation Text',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
            ),
            const SizedBox(height: 16),
            if (incantation.content != null)
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    incantation.content!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.8,
                      fontSize: 18,
                      fontFamily: 'Cinzel', // More mystical font for incantations
                    ),
                  ),
              )
            else
              const Text('Text content unavailable.'),
          ],
        ),
      ),
    );
  }
}
