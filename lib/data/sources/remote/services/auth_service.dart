import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';

import '../../../../core/app_utils/app_config.dart';
import '../network/api_exception.dart';
import '../network/general_interceptor.dart';
import '../request/login_request.dart';

class AuthService {
  final loginPath = 'login';

  final Dio _dio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl))
    ..interceptors.addAll([CurlLoggerDioInterceptor(printOnSuccess: true), GeneralInterceptor()]);

  Future<String> login(LoginRequest request) async {
    try {
      final response = await _dio.post(loginPath, data: request.toJson());
      return response.data['data']['access_token'] as String;
    } on ApiException {
      rethrow;
    }
  }
}
