import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/incantations/models/incantation.dart';

final incantationServiceProvider = Provider<IncantationService>((ref) {
  return IncantationService(ref.read(apiClientProvider));
});

class IncantationService {
  final ApiClient _client;

  IncantationService(this._client);

  Future<List<Incantation>> getIncantations({String? category}) async {
    final Map<String, dynamic> queryParams = {};
    if (category != null && category != 'All') {
      queryParams['category'] = category;
    }
    final response = await _client.get('incantations', queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((e) => Incantation.fromJson(e)).toList();
  }
}
