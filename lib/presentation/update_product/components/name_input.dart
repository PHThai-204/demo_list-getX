import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../create_product/components/create_product_text_input.dart';
import '../update_product_controller.dart';

class NameInput extends GetView<UpdateProductController> {
  final FocusNode? focusNode;
  final ValueChanged<String>? onSubmitted;

  const NameInput({super.key, required this.focusNode, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Obx(() => CreateProductTextInput(
      label: 'product_name'.tr(),
      hint: 'enter_product_name'.tr(),
      focusNode: focusNode,
      textInputAction: TextInputAction.next,
      onChanged: (value) => controller.onNameChanged(value),
      onClear: () => controller.onNameChanged(''),
      errorText: controller.nameError.value,
      showValidationErrors: controller.showValidationErrors.value,
      submitAttempt: controller.submitAttempt.value,
      initialValue: controller.name.value,
      onSubmitted: onSubmitted,
    ));
  }
}