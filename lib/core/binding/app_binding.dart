import 'package:demo_list_getx/data/sources/remote/services/auth_service.dart';
import 'package:demo_list_getx/data/sources/remote/services/general_service.dart';
import 'package:demo_list_getx/domain/repositories/auth_repository.dart';
import 'package:demo_list_getx/domain/repositories/general_repository.dart';
import 'package:demo_list_getx/domain/usecase/auth/login_usecase.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../data/repositories_impl/auth_repository_impl.dart';
import '../../data/repositories_impl/general_repository_impl.dart';
import '../../data/sources/remote/network/dio_client.dart';
import '../../domain/usecase/category/get_categories_usecase.dart';
import '../../domain/usecase/product/create_product_usecase.dart';
import '../../domain/usecase/product/get_products_usecase.dart';
import '../../domain/usecase/product/remove_product_usecase.dart';
import '../../domain/usecase/product/update_product_usecase.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dio>(() => DioClient.dio);

    Get.lazyPut(() => GeneralService(Get.find<Dio>()));
    Get.lazyPut(() => AuthService(Get.find<Dio>()));

    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()));
    Get.lazyPut<GeneralRepository>(() => GeneralRepositoryImpl(Get.find()));

    Get.put(LoginUseCase(Get.find()));
    Get.put(GetProductsUseCase(Get.find()));
    Get.put(GetCategoriesUseCase(Get.find()));
    Get.put(RemoveProductUseCase(Get.find()));
    Get.put(CreateProductUseCase(Get.find()));
    Get.put(UpdateProductUseCase(Get.find()));
  }
}
