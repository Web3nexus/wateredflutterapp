import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/profile/models/informational.dart';

part 'informational_provider.g.dart';

@riverpod
Future<Map<String, List<Faq>>> faqList(FaqListRef ref) async {
  final response = await ref.read(apiClientProvider).get('faqs');
  final data = response.data['data'] as Map<String, dynamic>;
  
  return data.map((key, value) {
    final list = (value as List).map((e) => Faq.fromJson(e as Map<String, dynamic>)).toList();
    return MapEntry(key, list);
  });
}

@riverpod
Future<List<UserGuide>> userGuides(UserGuidesRef ref) async {
  final response = await ref.read(apiClientProvider).get('user-guides');
  final data = response.data['data'] as List;
  
  return data.map((e) => UserGuide.fromJson(e as Map<String, dynamic>)).toList();
}
