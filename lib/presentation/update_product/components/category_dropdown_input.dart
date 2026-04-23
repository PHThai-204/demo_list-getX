import 'package:demo_list_getx/domain/entities/category_entity.dart';
import 'package:demo_list_getx/presentation/update_product/update_product_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../core/styles/app_text_styles.dart';

class CategoryDropdownInput extends GetView<UpdateProductController> {
  const CategoryDropdownInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final uniqueCategories = <int, CategoryEntity>{
        for (final category in controller.categories) category.id: category,
      }.values.toList();

      final matchedCount = uniqueCategories
          .where((category) => category.id == controller.categoryId.value)
          .length;
      final safeSelectedCategoryId = matchedCount == 1 ? controller.categoryId.value : null;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('category'.tr(), style: AppTextStyles.style.w700.s16.darkGrayColor),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<int>(
              isExpanded: true,
              underline: SizedBox(),
              value: safeSelectedCategoryId,
              onChanged: (value) => controller.onCategoryIdChanged(value),
              items: [
                DropdownMenuItem<int>(value: null, child: Text('choose_category'.tr())),
                ...uniqueCategories.map(
                  (category) =>
                      DropdownMenuItem<int>(value: category.id, child: Text(category.name)),
                ),
              ],
            ),
          ),
          if (controller.showValidationErrors.value && controller.categoryIdError.value.isNotEmpty) ...[
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                controller.categoryIdError.value,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
          ],
        ],
      );
    });
  }
}
