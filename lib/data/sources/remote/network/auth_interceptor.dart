import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../../core/navigation/navigation_service.dart';
import '../../../../presentation/custom/dialog_custom.dart';
import '../../local/secure_storage.dart';

class AuthInterceptor extends InterceptorsWrapper {
  static bool _isHandlingUnauthorized = false;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await SecureStorage.getAccessToken();

    options.headers['Accept-Language'] = 'vi';
    options.headers['Authorization'] = 'Bearer $accessToken';
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      handler.next(err);
      return;
    }

    if (err.error is SocketException) {
      handler.next(err);
      return;
    }

    if (err.response?.statusCode == HttpStatus.unauthorized) {
      await _forceLogout(err);

      handler.next(err);
      return;
    }

    handler.next(err);
  }

  Future<void> _forceLogout(DioException error) async {
    if (_isHandlingUnauthorized) {
      return;
    }

    _isHandlingUnauthorized = true;

    try {
      await SecureStorage.deleteAll();

      Get.dialog(
        DialogCustom(
          title: 'notification'.tr(),
          content: 'session_expired'.tr(),
          confirmText: 'login'.tr(),
          onConfirm: () {
            Get.offAllNamed(NavigationService.login);
          },
        ),
      );
    } finally {
      _isHandlingUnauthorized = false;
    }
  }
}
