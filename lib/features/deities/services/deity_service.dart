import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/deities/models/deity.dart';
import 'package:Watered/features/traditions/models/tradition.dart';

final deityServiceProvider = Provider<DeityService>((ref) {
  return DeityService(ref.read(apiClientProvider));
});

class DeityService {
  final ApiClient _client;

  DeityService(this._client);

  Future<Map<String, dynamic>> getDeities({int? traditionId, String? search, int page = 1}) async {
    final Map<String, dynamic> params = {'page': page};
    if (traditionId != null) params['tradition_id'] = traditionId;
    if (search != null && search.isNotEmpty) params['search'] = search;
    params['per_page'] = 20;

    final response = await _client.get('deities', queryParameters: params);
    return response.data;
  }
  
  // Also need traditions for the filter
  Future<List<Tradition>> getTraditions() async {
    final response = await _client.get('traditions', queryParameters: {'per_page': 100});
     final data = response.data['data'] as List;
    return data.map((e) => Tradition.fromJson(e)).toList();
  }
}
