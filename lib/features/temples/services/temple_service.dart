import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/temples/models/temple.dart';

final templeServiceProvider = Provider<TempleService>((ref) {
  return TempleService(ref.read(apiClientProvider));
});

class TempleService {
  final ApiClient _client;

  TempleService(this._client);

  Future<List<Temple>> getTemples() async {
    try {
      final response = await _client.get('temples');
      final List data = response.data['data'] ?? [];
      return data.map((e) => Temple.fromJson(e)).toList();
    } catch (e) {
      throw 'Failed to load temples.';
    }
  }

  Future<List<Temple>> getTemplesNearMe(double lat, double lng, {double radius = 50}) async {
    try {
      final response = await _client.get('temples/near-me', queryParameters: {
        'latitude': lat,
        'longitude': lng,
        'radius': radius,
      });
      final List data = response.data['data'] ?? [];
      return data.map((e) => Temple.fromJson(e)).toList();
    } catch (e) {
      throw 'Failed to load nearby temples.';
    }
  }
}
