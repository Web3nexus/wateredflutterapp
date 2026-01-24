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
      // Token likely invalid
      await _apiClient.clearToken();
      state = const AuthState();
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
}
