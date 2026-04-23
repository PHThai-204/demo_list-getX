import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../core/styles/app_colors.dart';
import '../../../core/styles/app_text_styles.dart';
import '../create_product_controller.dart';

class CategoryDropdownInput extends StatefulWidget {
  const CategoryDropdownInput({super.key});

  @override
  State<CategoryDropdownInput> createState() => _CategoryDropdownInputState();
}

class _CategoryDropdownInputState extends State<CategoryDropdownInput>
    with SingleTickerProviderStateMixin {
  late AnimationController _animation;
  late Animation<double> _offsetAnimation;

  final controller = Get.find<CreateProductController>();

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(duration: const Duration(milliseconds: 360), vsync: this);
    _offsetAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: -8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _animation, curve: Curves.easeOut));

    ever(controller.submitAttempt, (_) {
    });
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  void _trigger() {
    _animation.stop();
    _animation.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selectedValue = controller.categoryId.value;

      if (controller.showValidationErrors.value && controller.categoryIdError.value.isNotEmpty) {
        _trigger();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('category'.tr(), style: AppTextStyles.style.w700.s16.darkGrayColor),
          const SizedBox(height: 8),
          AnimatedBuilder(
            animation: _offsetAnimation,
            builder: (context, child) {
              return Transform.translate(offset: Offset(_offsetAnimation.value, 0), child: child);
            },
            child: InputDecorator(
              decoration: InputDecoration(
                hintText: 'choose_category'.tr(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: AppColors.lightGrey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: AppColors.lightGrey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: AppColors.darkOrange),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                fillColor: AppColors.white,
                filled: true,
              ),
              child: controller.isCategoryLoading.value
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    )
                  : DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        isExpanded: true,
                        value: controller.categories.any((item) => item.id == selectedValue)
                            ? selectedValue
                            : null,
                        hint: Text(
                          'choose_category'.tr(),
                          style: AppTextStyles.style.s16.w600.orchalColor,
                        ),
                        items: controller.categories
                            .map(
                              (category) => DropdownMenuItem<int>(
                                value: category.id,
                                child: Text(category.name),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          controller.onCategoryIdChanged(value);
                        },
                      ),
                    ),
            ),
          ),
          if (controller.categoryErrorMessage.value.isNotEmpty) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'load_categories_failed'.tr(),
                    style: AppTextStyles.style.s12.w400.redColor,
                  ),
                ),
                TextButton(
                  onPressed: () => controller.fetchCategories(),
                  child: Text('try_again'.tr()),
                ),
              ],
            ),
          ],
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              controller.showValidationErrors.value ? controller.categoryIdError.value : '',
              style: AppTextStyles.style.s12.w400.redColor,
            ),
          ),
        ],
      );
    });
  }
}
