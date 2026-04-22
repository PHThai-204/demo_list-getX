import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../../../core/styles/app_colors.dart';
import '../../../core/styles/app_text_styles.dart';
import '../../custom/button_custom.dart';
import 'components/password_input.dart';
import 'components/username_input.dart';
import 'login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  final LoginController loginController = Get.find<LoginController>();
  late final FocusNode _usernameFocusNode;
  late final FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _usernameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AutofillGroup(
                  child: Column(
                    children: [
                      const SizedBox(height: 100),
                      Text("login".tr(), style: AppTextStyles.style.s19.w900.blackColor),
                      const SizedBox(height: 50),
                      UsernameInput(
                        focusNode: _usernameFocusNode,
                        onSubmitted: (_) => FocusScope.of(context).requestFocus(_passwordFocusNode),
                      ),
                      const SizedBox(height: 10),
                      PasswordInput(
                        focusNode: _passwordFocusNode,
                        onSubmitted: (_) => loginController.submit(),
                      ),
                      const SizedBox(height: 20),
                      ButtonCustom(
                        title: 'login'.tr(),
                        onPressed: () => loginController.submit(),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
