import 'package:dio/dio.dart';

/// Custom exceptions for API errors
abstract class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, [this.statusCode]);

  @override
  String toString() => message;
}

class NetworkException extends ApiException {
  NetworkException(super.message);
}

class TimeoutException extends ApiException {
  TimeoutException(super.message);
}

class ServerException extends ApiException {
  ServerException(super.message, super.statusCode);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(String message) : super(message, 401);
}

class NotFoundException extends ApiException {
  NotFoundException(String message) : super(message, 404);
}

class ValidationException extends ApiException {
  final Map<String, dynamic>? errors;

  ValidationException(String message, [this.errors]) : super(message, 422);
}

/// API error handler to map Dio errors to custom exceptions
class ApiErrorHandler {
  static ApiException handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return TimeoutException(
            'Request timeout. Please check your internet connection.',
          );

        case DioExceptionType.connectionError:
          return NetworkException(
            'No internet connection. Please check your network settings.',
          );

        case DioExceptionType.badResponse:
          return _handleResponseError(error.response);

        case DioExceptionType.cancel:
          return NetworkException('Request was cancelled.');

        default:
          return NetworkException(
            'An unexpected error occurred. Please try again.',
          );
      }
    }

    return NetworkException('An unknown error occurred: $error');
  }

  static ApiException _handleResponseError(Response? response) {
    if (response == null) {
      return ServerException('Server error occurred.', null);
    }

    final statusCode = response.statusCode ?? 0;
    final data = response.data;

    // Extract error message from response
    String message = 'An error occurred.';
    if (data is Map<String, dynamic>) {
      message = data['message'] ?? data['error'] ?? message;
    }

    switch (statusCode) {
      case 400:
        return ServerException('Bad request: $message', statusCode);
      
      case 401:
        return UnauthorizedException(
          message.isEmpty ? 'Unauthorized. Please login again.' : message,
        );
      
      case 403:
        return ServerException(
          'Forbidden: You do not have permission to access this resource.',
          statusCode,
        );
      
      case 404:
        return NotFoundException(
          message.isEmpty ? 'Resource not found.' : message,
        );
      
      case 422:
        Map<String, dynamic>? errors;
        if (data is Map<String, dynamic> && data.containsKey('errors')) {
          errors = data['errors'] as Map<String, dynamic>?;
        }
        return ValidationException(message, errors);
      
      case 500:
      case 502:
      case 503:
        return ServerException(
          'Server error. Please try again later.',
          statusCode,
        );
      
      default:
        return ServerException(message, statusCode);
    }
  }
}
