import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/auth/models/user.dart';
import 'package:Watered/features/auth/services/auth_service.dart';

// State wrapper
class AuthState {
  final User? user;
  final bool isLoading;
  final String? error;

  const AuthState({this.user, this.isLoading = false, this.error});

  bool get isAuthenticated => user != null;
  
  AuthState copyWith({User? user, bool? isLoading, String? error}) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error, // Allow clearing error by passing null
    );
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  final apiClient = ref.watch(apiClientProvider);
  return AuthNotifier(authService, apiClient);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;
  final ApiClient _apiClient;

  AuthNotifier(this._authService, this._apiClient) : super(const AuthState());

  Future<void> checkAuthStatus() async {
    final token = await _apiClient.getToken();
    if (token == null) {
      state = const AuthState(); // Not authenticated
      return;
    }

    try {
      state = state.copyWith(isLoading: true);
      final user = await _authService.getUser();
      state = AuthState(user: user);
    } catch (e) {
      // ONLY clear token and logout if it's a 401 Unauthorized
      // This ensures persistent login even if network is briefly down on start
      if (e.toString().contains('401')) {
        await _apiClient.clearToken();
        state = const AuthState();
      } else {
        // Just stop loading but keep the "authenticated" state if token exists
        // The user might be redirected to an error screen if a crucial request fails later
        state = state.copyWith(isLoading: false);
      }
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final authResponse = await _authService.login(email: email, password: password);
      
      await _apiClient.saveToken(authResponse.token);
      state = AuthState(user: authResponse.user);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final authResponse = await _authService.register(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      
      await _apiClient.saveToken(authResponse.token);
      state = AuthState(user: authResponse.user);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    state = const AuthState();
  }

  Future<bool> signInWithGoogle() async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final authResponse = await _authService.signInWithGoogle();
      
      await _apiClient.saveToken(authResponse.token);
      state = AuthState(user: authResponse.user);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> signInWithApple() async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final authResponse = await _authService.signInWithApple();
      
      await _apiClient.saveToken(authResponse.token);
      state = AuthState(user: authResponse.user);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<void> resendVerificationEmail() async {
    await _authService.resendVerificationEmail();
  }

  Future<void> reloadUser() async {
     try {
       final user = await _authService.getUser();
       state = state.copyWith(user: user);
     } catch (e) {
       // Ignore error silently or log it
     }
  }

  void updateUser(User user) {
    state = state.copyWith(user: user);
  }
}
