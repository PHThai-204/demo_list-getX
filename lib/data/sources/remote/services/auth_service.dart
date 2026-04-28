import 'package:dio/dio.dart';

import '../network/api_exception.dart';
import '../request/login_request.dart';

class AuthService {
  final Dio _dio;

  final loginPath = 'login';

  AuthService(this._dio);

  Future<String> login(LoginRequest request) async {
    try {
      final response = await _dio.post(loginPath, data: request.toJson());
      return response.data['data']['access_token'] as String;
    } on ApiException {
      rethrow;
    }
  }
}
