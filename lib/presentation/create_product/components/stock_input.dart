import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../create_product_controller.dart';
import '../../custom/product_text_input.dart';

class StockInput extends GetView<CreateProductController> {
  final FocusNode? focusNode;
  final ValueChanged<String>? onSubmitted;

  const StockInput({super.key, this.focusNode, this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ProductTextInput(
      label: 'stock'.tr(),
      hint: 'enter_stock'.tr(),
      focusNode: focusNode,
      textInputAction: TextInputAction.next,
      inputType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: (value) => controller.onStockChanged(value),
      onClear: () => controller.onStockChanged(''),
      errorText: controller.stockError.value,
      showValidationErrors: controller.showValidationErrors.value,
      submitAttempt: controller.submitAttempt.value,
      onSubmitted: onSubmitted,
    ));
  }
}