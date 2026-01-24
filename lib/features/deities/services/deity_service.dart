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

  Future<List<Deity>> getDeities({int? traditionId, String? search}) async {
    final Map<String, dynamic> params = {};
    if (traditionId != null) params['tradition_id'] = traditionId;
    if (search != null && search.isNotEmpty) params['search'] = search;

    final response = await _client.get('deities', queryParameters: params);
    final data = response.data['data'] as List;
    return data.map((e) => Deity.fromJson(e)).toList();
  }
  
  // Also need traditions for the filter
  Future<List<Tradition>> getTraditions() async {
    final response = await _client.get('traditions');
     final data = response.data['data'] as List;
    return data.map((e) => Tradition.fromJson(e)).toList();
  }
}
