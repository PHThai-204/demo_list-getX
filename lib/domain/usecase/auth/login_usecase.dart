import 'package:demo_list_getx/domain/repositories/auth_repository.dart';

import '../../../data/sources/remote/request/login_request.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<String> execute(String username, String password) {
    final request = LoginRequest(username: username, password: password);
    return _repository.login(request);
  }
}