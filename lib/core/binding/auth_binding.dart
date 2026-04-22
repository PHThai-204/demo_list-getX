import 'package:get/get.dart';

import '../../domain/usecase/auth/login_usecase.dart';
import '../../presentation/screens/login/login_controller.dart';
import '../di/injection.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(getIt<LoginUseCase>()));
  }
}
