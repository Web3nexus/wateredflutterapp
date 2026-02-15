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
      // Handle 401 Unauthorized (invalid credentials)
      if (e.response?.statusCode == 401) {
        throw 'Invalid email or password.';
      }
      
      // Handle 422 Validation Error
      if (e.response?.statusCode == 422) {
        final errors = e.response?.data['errors'];
        if (errors != null && errors is Map) {
          // Return the first validation error message
          final firstError = errors.values.first;
          if (firstError is List && firstError.isNotEmpty) {
            throw firstError.first.toString();
          }
        }
        throw 'Invalid credentials. Please check your email and password.';
      }
      
      // Handle network errors
      if (e.type == DioExceptionType.connectionTimeout || 
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw 'Network error. Please check your internet connection.';
      }
      
      // Generic error
      throw 'Login failed. Please try again later.';
    } catch (e) {
      // Catch any other errors
      if (e is String) rethrow;
      throw 'An unexpected error occurred. Please try again.';
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
      // Handle 422 Validation Error
      if (e.response?.statusCode == 422) {
        final errors = e.response?.data['errors'];
        if (errors != null && errors is Map) {
          // Check for specific field errors
          if (errors.containsKey('email')) {
            final emailErrors = errors['email'];
            if (emailErrors is List && emailErrors.isNotEmpty) {
              final errorMsg = emailErrors.first.toString().toLowerCase();
              if (errorMsg.contains('taken') || errorMsg.contains('already')) {
                throw 'This email is already registered. Please login instead.';
              }
              throw emailErrors.first.toString();
            }
          }
          
          if (errors.containsKey('password')) {
            final passwordErrors = errors['password'];
            if (passwordErrors is List && passwordErrors.isNotEmpty) {
              throw passwordErrors.first.toString();
            }
          }
          
          if (errors.containsKey('name')) {
            final nameErrors = errors['name'];
            if (nameErrors is List && nameErrors.isNotEmpty) {
              throw nameErrors.first.toString();
            }
          }
          
          // Return the first validation error if no specific field matched
          final firstError = errors.values.first;
          if (firstError is List && firstError.isNotEmpty) {
            throw firstError.first.toString();
          }
        }
        throw 'Please check your information and try again.';
      }
      
      // Handle network errors
      if (e.type == DioExceptionType.connectionTimeout || 
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw 'Network error. Please check your internet connection.';
      }
      
      // Generic error
      throw 'Registration failed. Please try again later.';
    } catch (e) {
      // Catch any other errors
      if (e is String) rethrow;
      throw 'An unexpected error occurred. Please try again.';
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

  Future<void> forgotPassword(String email) async {
    try {
      await _client.post('forgot-password', data: {'email': email});
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        final errors = e.response?.data['errors'];
        if (errors != null && errors is Map && errors.containsKey('email')) {
          final emailErrors = errors['email'];
          if (emailErrors is List && emailErrors.isNotEmpty) {
            throw emailErrors.first.toString();
          }
        }
        throw 'Unable to send reset link. Please check your email address.';
      }
      
      if (e.type == DioExceptionType.connectionTimeout || 
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw 'Network error. Please check your internet connection.';
      }
      
      throw 'Failed to send reset link. Please try again later.';
    } catch (e) {
      if (e is String) rethrow;
      throw 'An unexpected error occurred. Please try again.';
    }
  }

  Future<void> resetPassword({
    required String email,
    required String token,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      await _client.post('reset-password', data: {
        'email': email,
        'token': token,
        'password': password,
        'password_confirmation': passwordConfirmation,
      });
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        final errors = e.response?.data['errors'];
        if (errors != null && errors is Map) {
          if (errors.containsKey('email')) {
            final emailErrors = errors['email'];
            if (emailErrors is List && emailErrors.isNotEmpty) {
              throw emailErrors.first.toString();
            }
          }
          
          if (errors.containsKey('password')) {
            final passwordErrors = errors['password'];
            if (passwordErrors is List && passwordErrors.isNotEmpty) {
              throw passwordErrors.first.toString();
            }
          }
          
          if (errors.containsKey('token')) {
            throw 'Invalid or expired reset token. Please request a new reset link.';
          }
        }
        throw 'Failed to reset password. Please check your information.';
      }
      
      if (e.type == DioExceptionType.connectionTimeout || 
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw 'Network error. Please check your internet connection.';
      }
      
      throw 'Failed to reset password. Please try again later.';
    } catch (e) {
      if (e is String) rethrow;
      throw 'An unexpected error occurred. Please try again.';
    }
  }
}
