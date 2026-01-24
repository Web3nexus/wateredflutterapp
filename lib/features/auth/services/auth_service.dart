import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/auth/models/auth_response.dart';
import 'package:Watered/features/auth/models/user.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref.read(apiClientProvider));
});



class AuthService {
  final ApiClient _client;

  AuthService(this._client);

  Future<AuthResponse> login({required String email, required String password}) async {
    try {
      final response = await _client.post('login', data: {
        'email': email,
        'password': password,
        'device_name': 'flutter_app', // Required for Sanctum
      });
      
      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        throw 'Invalid credentials.';
      }
      throw 'Login failed. Please try again.';
    }
  }

  Future<AuthResponse> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await _client.post('register', data: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'device_name': 'flutter_app',
      });
      
      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        // Simple error parsing for now, can be improved
        final errors = e.response?.data['errors'];
        if (errors != null) {
            return Future.error(errors.values.first.first);
        }
      }
      throw 'Registration failed. Please try again.';
    }
  }

  Future<void> logout() async {
    try {
      await _client.post('logout');
    } catch (_) {
      // Ignore logout errors
    } finally {
      await _client.clearToken();
    }
  }

  Future<User> getUser() async {
    final response = await _client.get('user');
    return User.fromJson(response.data);
  }
}
