import 'package:demo_list_getx/data/sources/remote/network/api_exception.dart';
import 'package:demo_list_getx/data/sources/remote/request/login_request.dart';
import 'package:demo_list_getx/data/sources/remote/services/auth_service.dart';
import 'package:demo_list_getx/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl(this._authService);
  @override
  Future<String> login(LoginRequest request) async {
    try {
      return await _authService.login(request);
    } catch (e) {
      throw ApiException.from(e);
    }
  }

}