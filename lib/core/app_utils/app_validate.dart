import 'package:demo_list_getx/domain/entities/category_entity.dart';
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

  static String validateName(String value) {
    if (value.trim().isEmpty) {
      return 'product_name_not_empty'.tr();
    }
    return '';
  }

  static String validateCode(String value) {
    if (value.trim().isEmpty) {
      return 'product_code_not_empty'.tr();
    }
    return '';
  }

  static String validatePrice(String? rawValue) {
    if (rawValue == null || rawValue.trim().isEmpty) {
      return 'price_not_empty'.tr();
    }

    final cleanValue = rawValue.trim().replaceFirst(',', '.');
    final parsedValue = double.tryParse(cleanValue);

    if (parsedValue == null || !parsedValue.isFinite || parsedValue <= 0) {
      return 'price_invalid'.tr();
    }

    return '';
  }

  static String validateStock(String? rawValue) {
    if (rawValue == null || rawValue.trim().isEmpty) {
      return 'stock_not_empty'.tr();
    }

    final parsedValue = int.tryParse(rawValue);

    if (parsedValue == null || parsedValue < 0) {
      return 'stock_invalid'.tr();
    }

    return '';
  }

  static String validateCategoryId(int? value, List<CategoryEntity> categories) {
    if (value == null) {
      return '';
    }

    if (value <= 0) {
      return 'category_invalid'.tr();
    }

    final hasCategory = categories.any((category) => category.id == value);
    if (!hasCategory) {
      return 'category_invalid'.tr();
    }

    return '';
  }

  static String validateImage(String value) {
    final raw = value.trim();
    if (raw.isEmpty) {
      return '';
    }
    final uri = Uri.tryParse(raw);
    final isHttp = uri != null && uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    if (!isHttp) {
      return '';
    }
    return '';
  }
}
