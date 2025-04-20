import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:core/l10n/s.dart';

class NetworkException implements Exception {
  final String message;
  final int? statusCode;

  const NetworkException({
    required this.message,
    this.statusCode,
  });

  factory NetworkException.fromDioException(DioException dioException, BuildContext context) {
    String message;
    int? statusCode = dioException.response?.statusCode;
    final s = S.of(context)!;

    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = s.connection_timeout;
        break;
      case DioExceptionType.connectionError:
        message = s.no_internet_connection;
        break;
      case DioExceptionType.badResponse:
        if (statusCode == 401) {
          message = s.unauthorized_access;
        } else if (statusCode == 404) {
          message = s.resource_not_found;
        } else if (statusCode != null && statusCode >= 500) {
          message = s.server_error;
        } else {
          message = s.network_error_occurred;
        }
        break;
      case DioExceptionType.cancel:
        message = s.request_cancelled;
        break;
      case DioExceptionType.unknown:
      default:
        if (dioException.error != null && dioException.error.toString().contains('SocketException')) {
          message = s.no_internet_connection;
        } else {
          message = s.network_error_occurred;
        }
        break;
    }

    return NetworkException(
      message: message,
      statusCode: statusCode,
    );
  }

  @override
  String toString() => message;
}
