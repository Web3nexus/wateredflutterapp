import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/auth/models/auth_response.dart';
import 'package:Watered/features/auth/models/user.dart' as app_user;

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref.read(apiClientProvider));
});

class AuthService {
  final ApiClient _client;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthService(this._client);

  Future<AuthResponse> login({required String email, required String password}) async {
    try {
      // 1. Authenticate with Firebase
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = userCredential.user;
      if (firebaseUser == null) throw 'Firebase login failed';

      // 2. Sync with custom backend to get token and full app user data
      final idToken = await firebaseUser.getIdToken();
      final response = await _client.post('social-login', data: {
        'email': firebaseUser.email,
        'name': firebaseUser.displayName ?? 'User',
        'provider': 'firebase_email',
        'provider_id': firebaseUser.uid,
        'id_token': idToken,
        'device_name': 'flutter_app',
      });
      
      return AuthResponse.fromJson(response.data);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password' || e.code == 'invalid-credential') {
        throw 'Invalid email or password.';
      }
      throw e.message ?? 'Login failed. Please try again.';
    } catch (e) {
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
      // 1. Create user in Firebase
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = userCredential.user;
      if (firebaseUser == null) throw 'Firebase registration failed';

      // Update display name
      await firebaseUser.updateDisplayName(name);

      // 2. Sync with custom backend
      final idToken = await firebaseUser.getIdToken();
      final response = await _client.post('social-login', data: {
        'email': email,
        'name': name,
        'provider': 'firebase_email',
        'provider_id': firebaseUser.uid,
        'id_token': idToken,
        'device_name': 'flutter_app',
      });
      
      // 3. Send verification email via Firebase
      await firebaseUser.sendEmailVerification();
      
      return AuthResponse.fromJson(response.data);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw 'This email is already registered. Please login instead.';
      }
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      }
      throw e.message ?? 'Registration failed. Please try again.';
    } catch (e) {
      if (e is String) rethrow;
      throw 'An unexpected error occurred. Please try again.';
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
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
      final googleUser = await googleSignIn.signIn();
      
      if (googleUser == null) throw 'Sign in cancelled';

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 1. Sign in to Firebase
      final userCredential = await _auth.signInWithCredential(credential);
      final firebaseUser = userCredential.user;

      if (firebaseUser == null) throw 'Firebase Google sign in failed';

      // 2. Sync with custom backend
      final idToken = await firebaseUser.getIdToken();
      final response = await _client.post('social-login', data: {
        'email': firebaseUser.email,
        'name': firebaseUser.displayName ?? 'Google User',
        'provider': 'google',
        'provider_id': firebaseUser.uid,
        'id_token': idToken,
        'device_name': 'flutter_app',
      });

      return AuthResponse.fromJson(response.data);
    } catch (e) {
      if (e is String) rethrow;
      throw 'Google sign in failed. Please try again.';
    }
  }

  Future<AuthResponse> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Firebase Apple Sign-In
      final OAuthProvider oAuthProvider = OAuthProvider('apple.com');
      final AuthCredential credential = oAuthProvider.credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final firebaseUser = userCredential.user;

      if (firebaseUser == null) throw 'Firebase Apple sign in failed';

      final idToken = await firebaseUser.getIdToken();
      final response = await _client.post('social-login', data: {
        'email': firebaseUser.email ?? appleCredential.email ?? '',
        'name': firebaseUser.displayName ?? '${appleCredential.givenName ?? ''} ${appleCredential.familyName ?? ''}'.trim() == '' 
            ? 'Apple User' 
            : '${appleCredential.givenName ?? ''} ${appleCredential.familyName ?? ''}',
        'provider': 'apple',
        'provider_id': firebaseUser.uid,
        'id_token': idToken,
        'device_name': 'flutter_app',
      });

      return AuthResponse.fromJson(response.data);
    } catch (e) {
      if (e is String) rethrow;
      throw 'Apple sign in failed. Please try again.';
    }
  }

  Future<void> resendVerificationEmail() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await user.sendEmailVerification();
      } else {
        // Fallback to backend if firebase user is not found session-wise
        await _client.post('email/resend');
      }
    } catch (e) {
      throw 'Failed to resend verification email: $e';
    }
  }

  Future<app_user.User> getUser() async {
    final response = await _client.get('user');
    return app_user.User.fromJson(response.data);
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
