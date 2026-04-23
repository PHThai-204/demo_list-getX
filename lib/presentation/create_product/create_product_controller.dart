import 'dart:io';

import 'package:demo_list_getx/core/firebase/firebase_storage_service.dart';
import 'package:demo_list_getx/data/sources/remote/network/api_exception.dart';
import 'package:demo_list_getx/domain/entities/category_entity.dart';
import 'package:demo_list_getx/domain/usecase/product/create_product_usecase.dart';
import 'package:demo_list_getx/presentation/custom/dialog_custom.dart';
import 'package:demo_list_getx/presentation/custom/loading_custom.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../data/enums/status_enum.dart';
import '../../core/app_utils/app_validate.dart';
import '../../data/sources/remote/request/create_product_request.dart';
import '../../domain/usecase/category/get_categories_usecase.dart';

class CreateProductController extends GetxController {
  final CreateProductUseCase _createProductUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;

  var status = StatusEnum.initial.obs;
  var showValidationErrors = false.obs;
  var submitAttempt = 0.obs;

  var name = ''.obs;
  var code = ''.obs;
  var price = ''.obs;
  var stock = ''.obs;
  var categoryId = Rxn<int>();
  var description = ''.obs;

  var image = ''.obs;
  var imageLocalPath = ''.obs;
  var imageError = ''.obs;

  var nameError = ''.obs;
  var codeError = ''.obs;
  var priceError = ''.obs;
  var stockError = ''.obs;
  var categoryIdError = ''.obs;
  var descriptionError = ''.obs;

  var errorMessage = ''.obs;
  var categoryErrorMessage = ''.obs;

  var categories = <CategoryEntity>[].obs;
  var isCategoryLoading = false.obs;

  CreateProductController(this._createProductUseCase, this._getCategoriesUseCase);

  void onNameChanged(String value) {
    name.value = value;
    nameError.value = AppValidate.validateName(value);
  }

  void onCodeChanged(String value) {
    code.value = value;
    codeError.value = AppValidate.validateCode(value);
  }

  void onPriceChanged(String value) {
    price.value = value;
    priceError.value = AppValidate.validatePrice(value);
  }

  void onStockChanged(String value) {
    stock.value = value;
    stockError.value = AppValidate.validateStock(value);
  }

  void onDescriptionChanged(String value) {
    description.value = value;
    descriptionError.value = AppValidate.validateName(value);
  }

  void onImageChanged(String value) {
    imageLocalPath.value = value;
  }

  Future<void> submit() async {
    nameError.value = AppValidate.validateName(name.value);
    codeError.value = AppValidate.validateCode(code.value);
    priceError.value = AppValidate.validatePrice(price.value);
    stockError.value = AppValidate.validateStock(stock.value);
    categoryIdError.value = AppValidate.validateCategoryId(categoryId.value, categories);
    imageError.value = AppValidate.validateImage(image.value);
    showValidationErrors.value = true;
    submitAttempt.value++;

    if ([
      nameError,
      codeError,
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
      final request = CreateProductRequest(
        name: name.value,
        code: code.value,
        price: double.parse(price.value),
        stock: int.parse(stock.value),
        categoryId: categoryId.value,
        description: description.value.isEmpty ? null : description.value,
        image: imageUrl.isEmpty ? null : imageUrl,
      );

      await _createProductUseCase.execute(request);
      LoadingCustom.hideLoading();
      Get.back();
    } on ApiException catch (e) {
      LoadingCustom.hideLoading();
      Get.dialog(
        DialogCustom(
          title: 'notification'.tr(),
          content: e.errorMessage,
          confirmText: 'Đóng',
          onConfirm: () => Get.back(),
        ),
      );
    }
  }

  Future<void> fetchCategories() async {
    isCategoryLoading.value = true;
    try {
      final result = await _getCategoriesUseCase.execute();
      categories.value = result;
      isCategoryLoading.value = false;
    } catch (_) {}
  }

  void onCategoryIdChanged(int? value) {
    categoryId.value = value;
    categoryIdError.value = AppValidate.validateCategoryId(value, categories);
  }
}
