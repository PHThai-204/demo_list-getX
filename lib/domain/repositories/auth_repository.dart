import '../../data/sources/remote/request/login_request.dart';

abstract class AuthRepository {
  Future<String> login(LoginRequest request);
}