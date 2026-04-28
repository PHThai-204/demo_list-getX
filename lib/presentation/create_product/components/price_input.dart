import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../create_product_controller.dart';
import '../../custom/create_product_text_input.dart';

class PriceInput extends GetView<CreateProductController> {
  final FocusNode? focusNode;
  final ValueChanged<String>? onSubmitted;

  const PriceInput({super.key, this.focusNode, this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ProductTextInput(
      label: 'price'.tr(),
      hint: 'enter_price'.tr(),
      focusNode: focusNode,
      textInputAction: TextInputAction.next,
      inputType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
      onChanged: (value) => controller.onPriceChanged(value),
      onClear: () => controller.onPriceChanged(''),
      errorText: controller.priceError.value,
      showValidationErrors: controller.showValidationErrors.value,
      submitAttempt: controller.submitAttempt.value,
      onSubmitted: onSubmitted,
    ));
  }
}