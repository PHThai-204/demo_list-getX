import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../create_product/components/create_product_text_input.dart';
import '../update_product_controller.dart';

class PriceInput extends GetView<UpdateProductController> {
  final FocusNode? focusNode;
  final ValueChanged<String>? onSubmitted;

  const PriceInput({super.key, required this.focusNode, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CreateProductTextInput(
        label: 'price'.tr(),
        hint: 'enter_price'.tr(),
        focusNode: focusNode,
        textInputAction: TextInputAction.next,
        onChanged: (value) => controller.price.value = value,
        inputType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
        errorText: controller.priceError.value,
        showValidationErrors: controller.showValidationErrors.value,
        submitAttempt: controller.submitAttempt.value,
        initialValue: controller.price.value,
        onClear: () {},
      ),
    );
  }
}
