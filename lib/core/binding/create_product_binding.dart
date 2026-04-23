import 'package:get/get.dart';

import '../../presentation/create_product/create_product_controller.dart';

class CreateProductBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => CreateProductController(Get.find(), Get.find()));
  }
}