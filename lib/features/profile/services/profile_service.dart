import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/auth/models/user.dart';
import 'package:http_parser/http_parser.dart';

final profileServiceProvider = Provider<ProfileService>((ref) {
  return ProfileService(ref.read(apiClientProvider));
});

class ProfileService {
  final ApiClient _client;

  ProfileService(this._client);

  Future<User> updateProfile({required String name, required String email}) async {
    final response = await _client.post('profile/update', data: {
      'name': name,
      'email': email,
    });
    return User.fromJson(response.data['user']);
  }

  Future<User> uploadPhoto(File imageFile) async {
    final fileName = imageFile.path.split('/').last;
    final formData = FormData.fromMap({
      'photo': await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
        contentType: MediaType('image', fileName.split('.').last),
      ),
    });

    final response = await _client.post('profile/photo', data: formData);
    return User.fromJson(response.data['user']);
  }

  Future<User> getProfile() async {
    final response = await _client.get('profile');
    return User.fromJson(response.data['user']);
  }
}
