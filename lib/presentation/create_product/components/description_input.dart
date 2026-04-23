import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../create_product_controller.dart';
import 'create_product_text_input.dart';

class DescriptionInput extends GetView<CreateProductController> {
  final FocusNode? focusNode;
  final ValueChanged<String>? onSubmitted;

  const DescriptionInput({super.key, this.focusNode, this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Obx(() => CreateProductTextInput(
      label: 'description'.tr(),
      hint: 'enter_product_desc'.tr(),
      focusNode: focusNode,
      maxLines: 3,
      textInputAction: TextInputAction.done,
      onChanged: (value) => controller.onDescriptionChanged(value),
      onClear: () => controller.onDescriptionChanged(''),
      errorText: controller.descriptionError.value,
      showValidationErrors: controller.showValidationErrors.value,
      submitAttempt: controller.submitAttempt.value,
      onSubmitted: onSubmitted,
    ));
  }
}
