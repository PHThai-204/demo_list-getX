import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../create_product_controller.dart';
import '../../custom/create_product_text_input.dart';

class NameInput extends GetView<CreateProductController> {
  final FocusNode? focusNode;
  final ValueChanged<String>? onSubmitted;

  const NameInput({super.key, this.focusNode, this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ProductTextInput(
      label: 'product_name'.tr(),
      hint: 'enter_product_name'.tr(),
      focusNode: focusNode,
      textInputAction: TextInputAction.next,
      onChanged: (value) => controller.onNameChanged(value),
      onClear: () => controller.onNameChanged(''),
      errorText: controller.nameError.value,
      showValidationErrors: controller.showValidationErrors.value,
      submitAttempt: controller.submitAttempt.value,
      onSubmitted: onSubmitted,
    ));
  }
}