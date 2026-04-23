import 'package:demo_list_getx/domain/entities/product_entity.dart';
import 'package:demo_list_getx/presentation/update_product/update_product_controller.dart';
import 'package:get/get.dart';

class UpdateProductBinding extends Bindings {
  @override
  void dependencies() {
    final product = Get.arguments as ProductEntity;

    Get.lazyPut<UpdateProductController>(
      () => UpdateProductController(Get.find(), Get.find(), product: product),
    );
  }
}
