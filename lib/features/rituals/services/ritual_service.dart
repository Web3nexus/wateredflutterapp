import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/rituals/models/ritual.dart';

final ritualServiceProvider = Provider<RitualService>((ref) {
  return RitualService(ref.read(apiClientProvider));
});

class RitualService {
  final ApiClient _client;

  RitualService(this._client);

  Future<List<Ritual>> getRituals({String? category}) async {
    final Map<String, dynamic> queryParams = {};
    if (category != null && category != 'All') {
      queryParams['category'] = category;
    }
    final response = await _client.get('rituals', queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((e) => Ritual.fromJson(e)).toList();
  }

  Future<Ritual> getRitualDetails(int id) async {
    final response = await _client.get('rituals/$id');
    return Ritual.fromJson(response.data);
  }
}
