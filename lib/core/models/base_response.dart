import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_response.freezed.dart';
part 'base_response.g.dart';

/// Generic API response wrapper
@Freezed(genericArgumentFactories: true)
class BaseResponse<T> with _$BaseResponse<T> {
  const factory BaseResponse({
    required bool success,
    String? message,
    T? data,
    Map<String, dynamic>? errors,
  }) = _BaseResponse<T>;

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$BaseResponseFromJson(json, fromJsonT);
}

/// Success response helper
BaseResponse<T> successResponse<T>(T data, [String? message]) {
  return BaseResponse(
    success: true,
    message: message,
    data: data,
  );
}

/// Error response helper
BaseResponse<T> errorResponse<T>(String message, [Map<String, dynamic>? errors]) {
  return BaseResponse(
    success: false,
    message: message,
    errors: errors,
  );
}
