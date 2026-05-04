import 'package:demo_list_getx/data/sources/local/secure_storage.dart';
import 'package:demo_list_getx/data/sources/remote/network/api_exception.dart';
import 'package:demo_list_getx/presentation/custom/dialog_custom.dart';
import 'package:demo_list_getx/presentation/custom/loading_custom.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../core/app_utils/app_validate.dart';
import '../../../core/navigation/navigation_service.dart';
import '../../../domain/usecase/auth/login_usecase.dart';

class LoginController extends GetxController {
  final LoginUseCase loginUseCase;

  var username = ''.obs;
  var password = ''.obs;
  var usernameError = ''.obs;
  var passwordError = ''.obs;
  var showValidationErrors = false.obs;
  var isPasswordVisible = true.obs;
  var submitAttempt = 0.obs;

  LoginController(this.loginUseCase);

  void usernameChanged(String value) {
    username.value = value;
    usernameError.value = AppValidate.validationUsername(value);
  }

  void passwordChanged(String value) {
    password.value = value;
    passwordError.value = AppValidate.validationPassword(value);
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void clearUsername() {
    username.value = '';
  }

  void submit() async {
    submitAttempt.value++;
    showValidationErrors.value = true;
    usernameError.value = AppValidate.validationUsername(username.value);
    passwordError.value = AppValidate.validationPassword(password.value);

    if (usernameError.value.isNotEmpty || passwordError.value.isNotEmpty) return;

    LoadingCustom.show();
    try {
      final result = await loginUseCase.execute(username.value, password.value);
      SecureStorage.saveAccessToken(result);
      LoadingCustom.forceHide();
      Get.offAllNamed(NavigationService.home);
    } on ApiException catch (e) {
      LoadingCustom.forceHide();
      Get.dialog(DialogCustom(title: 'notification'.tr(), content: e.errorMessage));
    }
  }
}
