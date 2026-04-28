import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../custom/create_product_text_input.dart';
import '../update_product_controller.dart'; // Giữ nguyên widget custom

class DescriptionInput extends GetView<UpdateProductController> {
  final FocusNode? focusNode;
  final ValueChanged<String>? onSubmitted;

  const DescriptionInput({super.key, this.focusNode, this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ProductTextInput(
      label: 'description'.tr(),
      hint: 'enter_product_desc'.tr(),
      focusNode: focusNode,
      textInputAction: TextInputAction.next,
      onChanged: (value) => controller.onDescriptionChanged(value),
      onClear: () => controller.onDescriptionChanged(''),
      errorText: controller.descriptionError.value,
      showValidationErrors: controller.showValidationErrors.value,
      submitAttempt: controller.submitAttempt.value,
      onSubmitted: onSubmitted,
      maxLines: 5,
      initialValue: controller.description.value,
    ));
  }
}