import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
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

  Future<AuthResponse> signInWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn();
      final account = await googleSignIn.signIn();
      
      if (account == null) throw 'Sign in cancelled';

      final response = await _client.post('social-login', data: {
        'email': account.email,
        'name': account.displayName ?? 'Google User',
        'provider': 'google',
        'provider_id': account.id,
        'device_name': 'flutter_app',
      });

      return AuthResponse.fromJson(response.data);
    } catch (e) {
      throw 'Google sign in failed: $e';
    }
  }

  Future<AuthResponse> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final response = await _client.post('social-login', data: {
        'email': credential.email ?? '', // Apple might not provide email on subsequent logins
        'name': '${credential.givenName ?? ''} ${credential.familyName ?? ''}'.trim() == '' 
            ? 'Apple User' 
            : '${credential.givenName ?? ''} ${credential.familyName ?? ''}',
        'provider': 'apple',
        'provider_id': credential.userIdentifier,
        'device_name': 'flutter_app',
      });

      return AuthResponse.fromJson(response.data);
    } catch (e) {
      throw 'Apple sign in failed: $e';
    }
  }

  Future<void> resendVerificationEmail() async {
    try {
      await _client.post('email/resend');
    } catch (e) {
      throw 'Failed to resend verification email: $e';
    }
  }

  Future<User> getUser() async {
    final response = await _client.get('user');
    return User.fromJson(response.data);
  }
}
