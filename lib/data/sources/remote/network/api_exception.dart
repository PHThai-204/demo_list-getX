import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

class ApiException {
  final int errorCode;
  final String errorMessage;
  final String? errorKey;
  final String? logMessage;
  final Object exception;
  final DioException? networkError;

  ApiException._({
    this.errorCode = 0,
    this.errorMessage = '',
    this.errorKey,
    this.logMessage,
    required this.exception,
    this.networkError,
  });

  factory ApiException.fromDio(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.badResponse:
        return _handleErrorWithResponse(exception);

      case DioExceptionType.cancel:
        return ApiException._(
          exception: exception,
          errorMessage: 'request_cancelled'.tr(),
          networkError: exception,
        );

      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return ApiException._(
          exception: exception,
          errorMessage: _timeOutMessages[exception.type]!.tr(),
          networkError: exception,
        );

      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        if (exception.error is SocketException ||
            exception.error is HttpException) {
          return ApiException._(
            exception: exception,
            errorMessage: 'error_internet'.tr(),
            networkError: exception,
          );
        }

        return ApiException._(
          exception: exception,
          errorMessage: exception.error?.toString() ?? 'Unknown error',
          networkError: exception,
        );
    }
  }

  factory ApiException.from(Object error, [StackTrace? stackTrace]) {
    if (error is DioException) {
      return ApiException.fromDio(error);
    }

    log('Non-Dio error: $error\n$stackTrace');

    return ApiException._(
      exception: error,
      errorMessage: error.toString(),
    );
  }

  @override
  String toString() {
    return '''
ApiException(
  errorCode: $errorCode,
  errorMessage: $errorMessage,
  errorKey: $errorKey,
  logMessage: $logMessage,
  exception: $exception
)
''';
  }
}

ApiException _handleErrorWithResponse(DioException exception) {
  try {
    final response = exception.response;
    final data = response?.data;

    if (data is Map<String, dynamic>) {
      return ApiException._(
        exception: exception,
        networkError: exception,
        errorMessage: data['message'] ?? 'Unknown error',
        errorCode: data['status_code'] ?? response?.statusCode ?? 0,
        errorKey: data['error_key'],
        logMessage: data['log'],
      );
    }

    return ApiException._(
      exception: exception,
      networkError: exception,
      errorMessage: response?.statusMessage ?? 'Unexpected error',
      errorCode: response?.statusCode ?? 0,
    );
  } catch (e, stackTrace) {
    log('Parse error failed: $e\n$stackTrace');

    return ApiException._(
      exception: exception,
      networkError: exception,
      errorMessage: 'parse_error'.tr(),
    );
  }
}

final Map<DioExceptionType, String> _timeOutMessages = {
  DioExceptionType.connectionTimeout: 'connection_timeout',
  DioExceptionType.receiveTimeout: 'receive_timeout',
  DioExceptionType.sendTimeout: 'send_timeout',
};