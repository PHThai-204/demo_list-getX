import 'dart:io';

import 'package:demo_list_getx/core/app_utils/app_validate.dart';
import 'package:demo_list_getx/data/sources/remote/network/api_exception.dart';
import 'package:demo_list_getx/domain/entities/category_entity.dart';
import 'package:demo_list_getx/domain/usecase/product/update_product_usecase.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/sources/remote/firebase/firebase_storage_service.dart';
import '../../data/sources/remote/request/update_product_request.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecase/category/get_categories_usecase.dart';
import '../custom/dialog_custom.dart';
import '../custom/loading_custom.dart';

class UpdateProductController extends GetxController {
  final UpdateProductUseCase _updateProductUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;
  final ProductEntity product;

  UpdateProductController(
    this._updateProductUseCase,
    this._getCategoriesUseCase, {
    required this.product,
  });

  var categories = <CategoryEntity>[].obs;
  var isCategoryLoading = false.obs;
  var showValidationErrors = false.obs;
  var submitAttempt = 0.obs;

  var name = ''.obs;
  var code = ''.obs;
  var price = ''.obs;
  var stock = ''.obs;
  var categoryId = RxnInt();
  var description = ''.obs;
  var image = ''.obs;
  var imageLocalPath = ''.obs;

  var nameError = ''.obs;
  var priceError = ''.obs;
  var stockError = ''.obs;
  var categoryIdError = ''.obs;
  var descriptionError = ''.obs;
  var imageError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    name.value = product.name;
    code.value = product.code;
    price.value = product.price.toString();
    stock.value = product.stock.toString();
    categoryId.value = product.category?.id;
    description.value = product.description ?? '';
    image.value = product.image ?? '';

    fetchCategories();
  }

  Future<void> fetchCategories() async {
    isCategoryLoading.value = true;
    try {
      final result = await _getCategoriesUseCase.execute();
      categories.assignAll(result);
    } catch (_) {
    } finally {
      isCategoryLoading.value = false;
    }
  }

  void onNameChanged(String value) {
    name.value = value;
    nameError.value = AppValidate.validateName(value);
  }

  void onPriceChanged(String value) {
    price.value = value;
    priceError.value = AppValidate.validatePrice(value);
  }

  void onStockChanged(String value) {
    stock.value = value;
    stockError.value = AppValidate.validateStock(value);
  }

  void onCategoryIdChanged(int? value) {
    categoryId.value = value;
    categoryIdError.value = AppValidate.validateCategoryId(value, categories);
  }

  void onDescriptionChanged(String value) {
    description.value = value;
  }

  void onImageChanged(String value) {
    image.value = value;
  }

  void onImageLocalPathChanged(String value) {
    imageLocalPath.value = value;
  }

  Future<void> submit() async {
    nameError.value = AppValidate.validateName(name.value);
    priceError.value = AppValidate.validatePrice(price.value);
    stockError.value = AppValidate.validateStock(stock.value);
    categoryIdError.value = AppValidate.validateCategoryId(categoryId.value, categories);
    imageError.value = AppValidate.validateImage(image.value);
    submitAttempt.value++;
    showValidationErrors.value = true;

    if ([
      nameError,
      priceError,
      stockError,
      categoryIdError,
      descriptionError,
      imageError,
    ].any((error) => error.value.isNotEmpty)) {
      return;
    }

    LoadingCustom.show();
    try {
      var imageUrl = image.value;
      if (imageLocalPath.isNotEmpty) {
        imageUrl = await FirebaseStorageHelper.uploadImage(file: File(imageLocalPath.value));
      }

      final request = UpdateProductRequest(
        name: name.value,
        price: double.parse(price.value),
        stock: int.parse(stock.value),
        categoryId: categoryId.value,
        description: description.value.isEmpty ? null : description.value,
        image: imageUrl.isEmpty ? null : imageUrl,
      );

      await _updateProductUseCase.execute(product.id, request);
      LoadingCustom.hideLoading();
      Get.back(result: true);
    } on ApiException catch (e) {
      LoadingCustom.hideLoading();
      Get.dialog(
        DialogCustom(
          title: 'notification'.tr(),
          content: e.errorMessage,
          onConfirm: () => Get.back(),
        ),
      );
    }
  }
}
