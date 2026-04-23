import 'package:get/get.dart';

import '../../presentation/screens/login/login_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(Get.find()));
  }
}
