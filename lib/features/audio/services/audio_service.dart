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
      print('🎵 [AudioService] Loading audio: ${audio.title}');
      print('🎵 [AudioService] Audio URL: ${audio.audioUrl}');
      print('🎵 [AudioService] Audio ID: ${audio.id}');
      
      // Validate URL
      final uri = Uri.tryParse(audio.audioUrl);
      if (uri == null) {
        throw Exception('Invalid audio URL: ${audio.audioUrl}');
      }
      
      print('🎵 [AudioService] Parsed URI - Scheme: ${uri.scheme}, Host: ${uri.host}');
      
      await _player.setAudioSource(
        AudioSource.uri(
          uri,
          tag: MediaItem(
            id: audio.id.toString(),
            album: "Watered Teachings",
            title: audio.title,
            artist: audio.author ?? "Unknown Recitor",
            artUri: audio.thumbnailUrl != null ? Uri.tryParse(audio.thumbnailUrl!) : null,
          ),
        ),
      );
      
      print('✅ [AudioService] Audio source loaded successfully');
    } catch (e, stackTrace) {
      print('❌ [AudioService] Failed to load audio: $e');
      print('❌ [AudioService] Stack trace: $stackTrace');
      
      // Provide more specific error messages
      if (e.toString().contains('Unable to connect')) {
        throw Exception('Network error: Unable to connect to audio source. Please check your internet connection.');
      } else if (e.toString().contains('404')) {
        throw Exception('Audio file not found (404). The audio may have been removed.');
      } else if (e.toString().contains('403')) {
        throw Exception('Access denied (403). The audio source may require authentication.');
      } else if (e.toString().contains('Invalid audio URL')) {
        rethrow;
      } else {
        throw Exception('Failed to load audio: ${e.toString()}');
      }
    }
  }

  Future<void> play() async => await _player.play();
  Future<void> pause() async => await _player.pause();
  Future<void> stop() async => await _player.stop();
  Future<void> seek(Duration position) async => await _player.seek(position);

  bool get isPlaying => _player.playing;
  AudioPlayer get player => _player;

  bool isStreamable(String url) {
    final lowerUrl = url.toLowerCase();
    // Exclude known external platforms
    if (lowerUrl.contains('audiomack.com') || 
        lowerUrl.contains('spotify.com') || 
        lowerUrl.contains('youtube.com') ||
        lowerUrl.contains('youtu.be')) {
      return false;
    }
    // Check for common audio extensions or assume streamable if not a known platform
    return true; 
  }
}
