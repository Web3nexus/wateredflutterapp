import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/services/navigation_service.dart';

/// Provider for API Client
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(
    navigationService: ref.read(navigationServiceProvider),
  );
});

/// API client wrapper for Dio with automatic token attachment and base configuration
class ApiClient {
  final NavigationService _navigationService;
  final FlutterSecureStorage _secureStorage;
  late final Dio _dio;
  
  // Updated to use Laravel Herd domain for simulator access
  // Updated to use Live Production URL
  static const String baseUrl = 'https://mywatered.com/api/v1/';
  static const String tokenKey = 'auth_token';

  ApiClient({
    FlutterSecureStorage? secureStorage,
    NavigationService? navigationService,
  })  : _secureStorage = secureStorage ?? const FlutterSecureStorage(),
        _navigationService = navigationService ?? NavigationService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        },
      ),
    );

    // Bypass SSL certificate verification for local development
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };

    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Automatically attach token to requests
          final token = await _secureStorage.read(key: tokenKey);
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          
          // Log request
          print('🌐 ${options.method} ${options.path}');
          
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // Log response
          print('✅ ${response.statusCode} ${response.requestOptions.path}');
          return handler.next(response);
        },
        onError: (error, handler) {
          // Log error with more detail
          print('❌ ERROR: ${error.requestOptions.method} ${error.requestOptions.path}');
          print('❌ Status: ${error.response?.statusCode}');
          print('❌ Message: ${error.message}');
          
          // Check for internet connectivity errors
          if (error.type == DioExceptionType.connectionError || 
              error.type == DioExceptionType.connectionTimeout) {
            _navigationService.showNoInternetDialog();
          }

          // Handle 401 Unauthorized globally
          if (error.response?.statusCode == 401) {
             print('🔒 401 Unauthorized detected - Clearing token and redirecting to login');
             _secureStorage.delete(key: tokenKey).then((_) {
               // We need a way to reset the auth state in Riverpod. 
               // For now, let's just use the navigation service to push login or restart
               _navigationService.navigatorKey.currentState?.pushNamedAndRemoveUntil('/', (route) => false);
             });
          }

          if (error.response?.data != null) {
            print('❌ Data: ${error.response?.data}');
          }
          // Log headers for debugging 403s (often related to missing/wrong headers)
          print('❌ Headers: ${error.response?.headers}');
          print('❌ Full Error: ${error.error}');
          return handler.next(error);
        },
      ),
    );
  }

  /// GET request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// POST request
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// PUT request
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// DELETE request
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// Save authentication token
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: tokenKey, value: token);
  }

  /// Get authentication token
  Future<String?> getToken() async {
    return await _secureStorage.read(key: tokenKey);
  }

  /// Clear authentication token
  Future<void> clearToken() async {
    await _secureStorage.delete(key: tokenKey);
  }
}
