import 'package:demo_list_getx/core/di/injection.dart';
import 'package:demo_list_getx/domain/usecase/category/get_categories_usecase.dart';
import 'package:demo_list_getx/domain/usecase/product/get_products_usecase.dart';
import 'package:demo_list_getx/presentation/screens/home/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() =>
      Get.lazyPut(() => HomeController(getIt<GetProductsUseCase>(), getIt<GetCategoriesUseCase>()));
}
