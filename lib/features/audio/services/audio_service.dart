import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:Watered/features/audio/models/audio.dart';

/// Provider that handles the one-time background audio initialization
final audioBackgroundInitProvider = FutureProvider<void>((ref) async {
  try {
    print('🎵 [AudioInit] Consolidating initialization...');
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.watered.audio.channel',
      androidNotificationChannelName: 'Watered Audio',
      androidNotificationOngoing: true,
      androidNotificationIcon: 'mipmap/ic_launcher',
    ).timeout(const Duration(seconds: 30)); // Increased timeout
    print('✅ [AudioInit] JustAudioBackground ready');
  } catch (e) {
    print('❌ [AudioInit] JustAudioBackground init FAILED: $e');
    // We rethrow here so that dependent providers (audioPlayerProvider) don't proceed
    rethrow;
  }
});

final audioPlayerProvider = FutureProvider<AudioPlayer>((ref) async {
  // CRITICAL: Guaranteed wait for background handler initialization
  // This is the definitive fix for LateInitializationError on Android release
  await ref.watch(audioBackgroundInitProvider.future);
  
  try {
    print('💿 [AudioPlayer] Creating new AudioPlayer instance...');
    final player = AudioPlayer();
    player.setVolume(1.0);
    ref.onDispose(() => player.dispose());
    return player;
  } catch (e) {
    print('❌ [AudioPlayer] Failed to create AudioPlayer: $e');
    rethrow;
  }
});

final audioServiceProvider = Provider<AudioService>((ref) {
  final playerAsync = ref.watch(audioPlayerProvider);
  // We return a proxy that handles the async state
  return AudioService(ref, playerAsync.valueOrNull);
});

class AudioService {
  final Ref _ref;
  final AudioPlayer? _player;
  
  AudioService(this._ref, this._player) {
    if (_player != null) {
      _player!.playbackEventStream.listen(
        (event) {
          print('📡 [AudioService] Playback Event: ${event.processingState}');
        },
        onError: (Object e, StackTrace stackTrace) {
          print('❌ [AudioService] A stream error occurred: $e');
        },
      );
    }
  }

  bool get isReady => _player != null;
  AudioPlayer get player {
    if (_player == null) throw Exception('Audio player not initialized');
    return _player!;
  }

  Stream<PlayerState> get playerStateStream => _player?.playerStateStream ?? const Stream.empty();
  Stream<Duration?> get durationStream => _player?.durationStream ?? const Stream.empty();
  Stream<Duration> get positionStream => _player?.positionStream ?? const Stream.empty();
  Stream<bool> get playingStream => _player?.playingStream ?? const Stream.empty();

  Future<void> loadAudio(Audio audio) async {
    // Always get a fresh player reference — never rely on the captured _player
    // which may be stale if the provider rebuilt after initialization.
    AudioPlayer resolvedPlayer;
    if (_player != null) {
      resolvedPlayer = _player!;
    } else {
      print('⚠️ [AudioService] Player not ready, awaiting initialization...');
      resolvedPlayer = await _ref.read(audioPlayerProvider.future);
    }

    try {
      print('🎵 [AudioService] Loading audio: ${audio.title} | URL: ${audio.audioUrl}');
      final String rawUrl = audio.audioUrl?.trim() ?? '';
      
      if (rawUrl.isEmpty) {
        throw Exception('Audio URL is empty or null for "${audio.title}"');
      }

      final uri = Uri.tryParse(rawUrl);
      if (uri == null || !uri.hasScheme) {
        throw Exception('Invalid audio URL: "$rawUrl"');
      }
      
      final String mediaId = 'audio_${audio.id}_${DateTime.now().millisecondsSinceEpoch}';

      print('🔄 [AudioService] Setting audio source: $rawUrl');
      await resolvedPlayer.setAudioSource(
        AudioSource.uri(
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
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () => throw Exception('Audio loading timed out after 30s — check network or URL'),
      );
      print('✅ [AudioService] Audio source loaded successfully');
    } catch (e, stackTrace) {
      print('❌ [AudioService] Error loading audio: $e');
      print(stackTrace);
      rethrow;
    }
  }

  Future<void> play() async => await _player?.play();
  Future<void> pause() async => await _player?.pause();
  Future<void> stop() async => await _player?.stop();
  Future<void> seek(Duration position) async => await _player?.seek(position);

  bool get isPlaying => _player?.playing ?? false;
  AudioPlayer? get internalPlayer => _player;

  bool isStreamable(String url) {
    final lowerUrl = url.toLowerCase();
    if (lowerUrl.endsWith('.mp3') || 
        lowerUrl.endsWith('.wav') || 
        lowerUrl.endsWith('.aac') || 
        lowerUrl.endsWith('.m4a') || 
        lowerUrl.endsWith('.ogg')) {
      return true;
    }

    if (lowerUrl.contains('spotify.com') || 
        lowerUrl.contains('youtube.com') ||
        lowerUrl.contains('youtu.be') ||
        lowerUrl.contains('music.apple.com')) {
      return false;
    }
    
    return true; 
  }

  bool isAudioLoaded(int audioId) {
    if (_player == null || _player!.audioSource == null) return false;
    final currentMediaId = _player!.sequenceState?.currentSource?.tag?.id;
    return currentMediaId != null && currentMediaId.contains('audio_${audioId}_');
  }
}
