import 'package:get/get.dart';

import '../../presentation/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(Get.find(), Get.find()));
  }
}
