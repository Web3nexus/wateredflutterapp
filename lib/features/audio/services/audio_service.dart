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
  
  AudioService(this._player) {
    _player.playbackEventStream.listen(
      (event) {},
      onError: (Object e, StackTrace stackTrace) {
        print('❌ [AudioService] A stream error occurred: $e');
      },
    );
  }

  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
  Stream<Duration?> get durationStream => _player.durationStream;
  Stream<Duration> get positionStream => _player.positionStream;
  Stream<bool> get playingStream => _player.playingStream;

  Future<void> loadAudio(Audio audio) async {
    try {
      print('🎵 [AudioService] Loading audio: ${audio.title}');
      final String rawUrl = audio.audioUrl?.trim() ?? '';
      print('🔗 [AudioService] Raw URL: "$rawUrl"');
      
      final uri = Uri.tryParse(rawUrl);
      
      if (rawUrl.isEmpty || uri == null || !uri.hasScheme) {
        throw Exception('Invalid or non-absolute audio URL: "$rawUrl"');
      }
      
      // We use a specific ID format for just_audio_background to ensure uniqueness
      // and prevent "platform exchange" errors caused by duplicate IDs
      final String mediaId = 'audio_${audio.id}_${DateTime.now().millisecondsSinceEpoch}';

      // Use LockCachingAudioSource for better buffering and caching
      try {
        await _player.setAudioSource(
          LockCachingAudioSource(
            uri,
            tag: MediaItem(
              id: mediaId,
              album: audio.category ?? "Watered Teachings",
              title: audio.title ?? 'Unknown Title',
              artist: audio.author?.isNotEmpty == true ? audio.author! : "Watered",
              artUri: (audio.thumbnailUrl != null && audio.thumbnailUrl!.startsWith('http')) 
                  ? Uri.tryParse(audio.thumbnailUrl!) 
                  : null,
            ),
          ),
        );
      } catch (e) {
        print('⚠️ [AudioService] LockCachingAudioSource failed, falling back to standard URI source: $e');
        // Fallback to standard source if caching fails
        await _player.setAudioSource(
          AudioSource.uri(
            uri,
            headers: {
              'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
            },
            tag: MediaItem(
              id: mediaId,
              album: audio.category ?? "Watered Teachings",
              title: audio.title ?? 'Unknown Title',
              artist: audio.author?.isNotEmpty == true ? audio.author! : "Watered",
              artUri: (audio.thumbnailUrl != null && audio.thumbnailUrl!.startsWith('http')) 
                  ? Uri.tryParse(audio.thumbnailUrl!) 
                  : null,
            ),
          ),
        );
      }
      
      print('✅ [AudioService] Audio source loaded successfully');
    } catch (e, stackTrace) {
      print('❌ [AudioService] Failed to load audio: $e');
      
      if (e is PlayerException) {
        print('❌ [AudioService] Player error: ${e.message}');
        throw Exception('Player Error: ${e.message}');
      } else if (e is PlayerInterruptedException) {
        print('❌ [AudioService] Player interrupted: ${e.message}');
        throw Exception('Playback interrupted');
      }
      
      rethrow;
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
    
    // If it's a direct audio file, it's definitely streamable
    if (lowerUrl.endsWith('.mp3') || 
        lowerUrl.endsWith('.wav') || 
        lowerUrl.endsWith('.aac') || 
        lowerUrl.endsWith('.m4a') || 
        lowerUrl.endsWith('.ogg')) {
      return true;
    }

    // Exclude known external platforms that require their own player/SDK
    if (lowerUrl.contains('spotify.com') || 
        lowerUrl.contains('youtube.com') ||
        lowerUrl.contains('youtu.be') ||
        lowerUrl.contains('music.apple.com')) {
      return false;
    }
    
    // For everything else (including potential direct links from Audiomack/Cloud), 
    // we let just_audio try to play it.
    return true; 
  }

  bool isAudioLoaded(int audioId) {
    if (_player.audioSource == null) return false;
    final currentMediaId = _player.sequenceState?.currentSource?.tag?.id;
    return currentMediaId != null && currentMediaId.contains('audio_${audioId}_');
  }
}
