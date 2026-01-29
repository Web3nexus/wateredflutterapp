import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:Watered/features/audio/models/audio.dart';

final audioPlayerProvider = Provider<AudioPlayer>((ref) {
  final player = AudioPlayer();
  player.setVolume(1.0); // Ensure volume is up
  ref.onDispose(() => player.dispose());
  return player;
});

final audioServiceProvider = Provider<AudioService>((ref) {
  return AudioService(ref.watch(audioPlayerProvider));
});

class AudioService {
  final AudioPlayer _player;
  
  AudioService(this._player);

  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
  Stream<Duration?> get durationStream => _player.durationStream;
  Stream<Duration> get positionStream => _player.positionStream;
  Stream<bool> get playingStream => _player.playingStream;

  Future<void> loadAudio(Audio audio) async {
    try {
      await _player.setAudioSource(
        AudioSource.uri(
          Uri.parse(audio.audioUrl),
          tag: MediaItem(
            id: audio.id.toString(),
            album: "Watered Teachings",
            title: audio.title,
            artist: audio.author ?? "Unknown Recitor",
            artUri: audio.thumbnailUrl != null ? Uri.parse(audio.thumbnailUrl!) : null,
          ),
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> play() async => await _player.play();
  Future<void> pause() async => await _player.pause();
  Future<void> stop() async => await _player.stop();
  Future<void> seek(Duration position) async => await _player.seek(position);

  bool get isPlaying => _player.playing;
  AudioPlayer get player => _player;
}
