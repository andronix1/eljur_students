import 'package:eljur_students/core/failure/failure.dart';

sealed class ApiResponse {
  static ApiResponse fromJson<T>(Map<String, dynamic> json,
      T Function(Map<String, dynamic> json) deserializeResponse) {
    json = json['response'];
    if (json.containsKey('error') && json['error'] != null) {
      return ApiError(message: json['error']);
    }
    return ApiSuccess(response: deserializeResponse(json['result']));
  }
}

class ApiError implements ApiResponse, Failure {
  final String message;

  ApiError({required this.message});
}

class ApiSuccess<T> implements ApiResponse {
  final T response;

  ApiSuccess({required this.response});
}
