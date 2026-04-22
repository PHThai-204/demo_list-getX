import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../generated/assets.gen.dart';
import '../../../custom/text_field_custom.dart';
import '../login_controller.dart';

class UsernameInput extends StatefulWidget {
  final FocusNode? focusNode;
  final ValueChanged<String>? onSubmitted;

  const UsernameInput({super.key, this.focusNode, this.onSubmitted});

  @override
  State<StatefulWidget> createState() => UsernameInputSTate();
}

class UsernameInputSTate extends State<UsernameInput> with SingleTickerProviderStateMixin {
  late AnimationController _animation;
  late Animation<double> _offsetAnimation;
  final controller = Get.find<LoginController>();

  @override
  void initState() {
    _animation = AnimationController(duration: const Duration(milliseconds: 360), vsync: this);
    _offsetAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: -8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _animation, curve: Curves.easeOut));
    super.initState();
  }

  void trigger() {
    _animation.stop();
    _animation.forward(from: 0.0);
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.usernameError.value.isNotEmpty && controller.showValidationErrors.value) {
        trigger();
      }
      return TextFieldCustom(
        focusNode: widget.focusNode,
        hintText: 'account'.tr(),
        labelText: "account".tr(),
        errorText: controller.showValidationErrors.value ? controller.usernameError.value : '',
        onChanged: controller.usernameChanged,
        textInputAction: TextInputAction.next,
        onSubmitted: widget.onSubmitted,
        autofillHints: const [AutofillHints.username],
        suffix: Assets.svgs.icCloseCircle.svg(),
        onClickSuffix: controller.clearUsername,
        animation: _animation,
        offset: _offsetAnimation,
      );
    });
  }
}
