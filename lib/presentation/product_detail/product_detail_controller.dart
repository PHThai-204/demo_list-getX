import 'package:demo_list_getx/data/sources/remote/network/api_exception.dart';
import 'package:demo_list_getx/domain/entities/product_entity.dart';
import 'package:demo_list_getx/domain/usecase/product/remove_product_usecase.dart';
import 'package:demo_list_getx/presentation/custom/dialog_custom.dart';
import 'package:demo_list_getx/presentation/custom/loading_custom.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ProductDetailController extends GetxController {
  final RemoveProductUseCase removeProductUseCase;

  final ProductEntity product;

  ProductDetailController(this.product, this.removeProductUseCase);

  var errorMessage = ''.obs;

  Future<void> deleteProduct() async {
    LoadingCustom.show();
    try {
      await removeProductUseCase.execute(product.id);
      LoadingCustom.hideLoading();
      Get.back(result: true);
    } on ApiException catch (e) {
      LoadingCustom.hideLoading();
      Get.dialog(
        DialogCustom(
          title: 'notification'.tr(),
          content: e.errorMessage,
          confirmText: 'close'.tr(),
          onConfirm: () => Get.back(),
        ),
      );
    }
  }
}
