import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../../core/styles/app_colors.dart';
import '../../core/styles/app_text_styles.dart';
import '../custom/button_custom.dart';
import 'components/category_dropdown_input.dart';
import 'components/code_input.dart';
import 'components/description_input.dart';
import 'components/image_input.dart';
import 'components/name_input.dart';
import 'components/price_input.dart';
import 'components/stock_input.dart';
import 'create_product_controller.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProductScreen> {
  final controller = Get.find<CreateProductController>();

  @override
  void initState() {
    super.initState();
    controller.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: Text('create_product'.tr(), style: AppTextStyles.style.s18.w700.blackColor),
          centerTitle: true,
          backgroundColor: AppColors.white,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                NameInput(),
                const SizedBox(height: 10),
                CodeInput(),
                const SizedBox(height: 10),
                PriceInput(),
                const SizedBox(height: 10),
                StockInput(),
                const SizedBox(height: 10),
                const CategoryDropdownInput(),
                const SizedBox(height: 10),
                DescriptionInput(),
                const SizedBox(height: 10),
                ImageInput(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
            child: ButtonCustom(title: 'create_product'.tr(), onPressed: () => controller.submit()),
          ),
        ),
      ),
    );
  }
}
