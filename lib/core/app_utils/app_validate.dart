import 'package:easy_localization/easy_localization.dart';

class AppValidate {
  static String validationUsername(String username) {
    final value = username.trim();
    if (value.isEmpty) {
      return 'username_empty_error'.tr();
    } else {
      return '';
    }
  }

  static String validationPassword(String password) {
    final value = password.trim();
    if (value.isEmpty) {
      return "password_empty_error".tr();
    } else if (value.length > 50 || value.length < 6) {
      return 'password_fail'.tr();
    } else {
      return '';
    }
  }
}
