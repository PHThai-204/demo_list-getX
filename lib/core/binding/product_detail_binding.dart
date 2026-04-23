import 'package:demo_list_getx/domain/entities/product_entity.dart';
import 'package:get/get.dart';

import '../../presentation/product_detail/product_detail_controller.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    final product = Get.arguments as ProductEntity;
    Get.lazyPut<ProductDetailController>(() => ProductDetailController(product, Get.find()));
  }
}
