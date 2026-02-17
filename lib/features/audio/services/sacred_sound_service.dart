
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/audio/models/sacred_sound.dart';

final sacredSoundServiceProvider = Provider<SacredSoundService>((ref) {
  return SacredSoundService(ref.read(apiClientProvider));
});

final sacredSoundsProvider = FutureProvider<List<SacredSound>>((ref) {
  return ref.read(sacredSoundServiceProvider).getSounds();
});

class SacredSoundService {
  final ApiClient _client;

  SacredSoundService(this._client);

  Future<List<SacredSound>> getSounds() async {
    try {
      final response = await _client.get('sacred-sounds');
      final data = response.data['data'] as List;
      return data.map((e) => SacredSound.fromJson(e)).toList();
    } catch (e) {
      print('Failed to fetch sacred sounds: $e');
      return [];
    }
  }
}
