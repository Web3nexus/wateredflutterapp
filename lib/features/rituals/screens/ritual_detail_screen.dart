import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/rituals/models/ritual.dart';
import 'package:just_audio/just_audio.dart';
import 'package:Watered/features/audio/services/audio_service.dart'; // Add import

class RitualDetailScreen extends ConsumerStatefulWidget {
  final Ritual ritual;

  const RitualDetailScreen({super.key, required this.ritual});

  @override
  ConsumerState<RitualDetailScreen> createState() => _RitualDetailScreenState();
}

class _RitualDetailScreenState extends ConsumerState<RitualDetailScreen> {
  late AudioPlayer _player;
  bool _isPlaying = false;
  bool _isLoading = false;
  String? _currentUrl;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _player = await ref.read(audioPlayerProvider.future);
      if (widget.ritual.mediaUrls != null && widget.ritual.mediaUrls!.isNotEmpty) {
        _initAudio(widget.ritual.mediaUrls!.first);
      }
    });
  }

  Future<void> _initAudio(String url) async {
    try {
      setState(() {
        _isLoading = true;
        _currentUrl = url;
      });
      await _player.setUrl(url);
      
      _player.playerStateStream.listen((state) {
        if (mounted) {
          setState(() {
            _isPlaying = state.playing;
            if (state.processingState == ProcessingState.completed) {
              _isPlaying = false;
              _player.seek(Duration.zero);
              _player.pause();
            }
          });
        }
      });
    } catch (e) {
      print("Error loading ritual audio: $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    // _player.dispose(); // Do NOT dispose shared player
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ritual = widget.ritual;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(ritual.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (ritual.description != null) ...[
              Text(
                ritual.description!,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: theme.textTheme.bodyLarge?.color?.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 24),
            ],

            if (ritual.mediaUrls != null && ritual.mediaUrls!.isNotEmpty) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: theme.colorScheme.primary.withOpacity(0.1)),
                ),
                child: Column(
                  children: [
                    Text(
                      'RITUAL AUDIO',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: theme.colorScheme.primary.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _isLoading 
                      ? const CircularProgressIndicator()
                      : IconButton(
                          iconSize: 64,
                          icon: Icon(_isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_filled_rounded),
                          color: theme.colorScheme.primary,
                          onPressed: () {
                            if (_isPlaying) {
                              _player.pause();
                            } else {
                              _player.play();
                            }
                          },
                        ),
                    if (ritual.mediaUrls!.length > 1) ...[
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: ritual.mediaUrls!.length,
                          itemBuilder: (context, index) {
                            final url = ritual.mediaUrls![index];
                            final isCurrent = _currentUrl == url;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ChoiceChip(
                                label: Text('Part ${index + 1}'),
                                selected: isCurrent,
                                onSelected: (selected) {
                                  if (selected) _initAudio(url);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
            
            Text(
              'Instructions',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            if (ritual.content != null)
              Text(
                ritual.content!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.8,
                  fontSize: 16,
                ),
              )
            else
              const Text('Content coming soon...'),
          ],
        ),
      ),
    );
  }
}
