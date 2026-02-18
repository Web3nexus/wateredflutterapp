
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/audio/services/audio_service.dart';

class IsolatePlayerScreen extends ConsumerStatefulWidget {
  const IsolatePlayerScreen({super.key});

  @override
  ConsumerState<IsolatePlayerScreen> createState() => _IsolatePlayerScreenState();
}

class _IsolatePlayerScreenState extends ConsumerState<IsolatePlayerScreen> {
  late AudioPlayer _player;
  // Public domain MP3 from S3 (reliable)
  final _testUrl = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';
  String _status = 'Idle';

  @override
  void initState() {
    super.initState();
    // Note: We don't read player here anymore as it's async. 
    // We'll get it when needed or in the first frame.
    WidgetsBinding.instance.addPostFrameCallback((_) => _initPlayer());
  }

  Future<void> _initPlayer() async {
    try {
      _player = await ref.read(audioPlayerProvider.future);
      
      _player.playerStateStream.listen((state) {
        if (mounted) {
          setState(() {
            _status = 'State: ${state.processingState} | Playing: ${state.playing}';
          });
        }
      });
      
      _player.playbackEventStream.listen((event) {}, onError: (Object e, StackTrace stackTrace) {
        print('A stream error occurred: $e');
        if (mounted) setState(() => _status = 'Error: $e');
      });
    } catch (e) {
      if (mounted) setState(() => _status = 'Init Error: $e');
    }
  }

  Future<void> _play() async {
    try {
      await _player.setUrl(_testUrl);
      await _player.play();
    } catch (e) {
      if (mounted) setState(() => _status = 'Load Error: $e');
    }
  }

  @override
  void dispose() {
    // _player.dispose(); // Do not dispose shared player
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Audio Isolation Test')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Test URL: $_testUrl', textAlign: TextAlign.center),
            const SizedBox(height: 20),
            Text(_status, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _play,
              child: const Text('PLAY TEST AUDIO'),
            ),
          ],
        ),
      ),
    );
  }
}
