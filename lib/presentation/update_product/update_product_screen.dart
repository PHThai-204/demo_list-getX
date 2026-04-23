import 'package:demo_list_getx/presentation/update_product/update_product_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../../core/styles/app_colors.dart';
import '../../core/styles/app_text_styles.dart';
import '../custom/button_custom.dart';
import 'components/category_dropdown_input.dart';
import 'components/description_input.dart';
import 'components/image_input.dart';
import 'components/name_input.dart';
import 'components/price_input.dart';
import 'components/stock_input.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key});

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final UpdateProductController controller = Get.find<UpdateProductController>();

  late final FocusNode _nameFocusNode = FocusNode();
  late final FocusNode _priceFocusNode = FocusNode();
  late final FocusNode _stockFocusNode = FocusNode();
  late final FocusNode _descriptionFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: Text('update_product'.tr(), style: AppTextStyles.style.s18.w700.blackColor),
          centerTitle: true,
          backgroundColor: AppColors.white,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                NameInput(
                  focusNode: _nameFocusNode,
                  onSubmitted: (_) => FocusScope.of(context).requestFocus(_priceFocusNode),
                ),
                const SizedBox(height: 10),
                PriceInput(
                  focusNode: _priceFocusNode,
                  onSubmitted: (_) => FocusScope.of(context).requestFocus(_stockFocusNode),
                ),
                const SizedBox(height: 10),
                StockInput(
                  focusNode: _stockFocusNode,
                  onSubmitted: (_) => FocusScope.of(context).requestFocus(_descriptionFocusNode),
                ),
                const SizedBox(height: 10),
                const CategoryDropdownInput(),
                const SizedBox(height: 10),
                DescriptionInput(
                  focusNode: _descriptionFocusNode,
                  onSubmitted: (_) => FocusScope.of(context).unfocus(),
                ),
                const SizedBox(height: 10),
                ImageInput(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: ButtonCustom(title: 'save_change'.tr(), onPressed: () => controller.submit()),
          ),
        ),
      ),
    );
  }
}
