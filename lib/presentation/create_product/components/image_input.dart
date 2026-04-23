import 'dart:io';

import 'package:demo_list_getx/core/styles/app_colors.dart';
import 'package:demo_list_getx/core/styles/app_text_styles.dart';
import 'package:demo_list_getx/presentation/custom/button_custom.dart';
import 'package:demo_list_getx/presentation/custom/dialog_custom.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../core/app_utils/image_picker_util.dart';
import '../../../generated/assets.gen.dart';
import '../create_product_controller.dart';

class ImageInput extends GetView<CreateProductController> {
  final ImagePickerUtil _imagePickerUtil = ImagePickerUtil();

  ImageInput({super.key});

  Future<void> _pickImage() async {
    try {
      final File? file = await _imagePickerUtil.pickImageFromGallery();
      if (file == null) {
        return;
      }
      controller.onImageChanged(file.path);
    } catch (e) {
      Get.dialog(
        DialogCustom(
          title: 'notification'.tr(),
          content: 'choose_image_failed',
          onConfirm: () => Get.back(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (controller.imageLocalPath.value.isNotEmpty) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              File(controller.imageLocalPath.value),
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
        ],
        Row(
          children: [
            Expanded(
              child: ButtonCustom(
                onPressed: _pickImage,
                icon: Assets.svgs.icPicture.svg(
                  width: 14,
                  height: 14,
                  colorFilter: const ColorFilter.mode(AppColors.darkOrange, BlendMode.srcIn),
                ),
                buttonStyle: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.darkOrange),
                ),
                textStyle: AppTextStyles.style.s14.w400.darkOrangeColor,
                title: controller.imageLocalPath.value.isEmpty
                    ? 'choose_image_from_device'.tr()
                    : 'change_image'.tr(),
              ),
            ),
            const SizedBox(width: 8),
            if (controller.imageLocalPath.value.isNotEmpty || controller.image.value.isNotEmpty)
              IconButton(
                onPressed: () {
                  controller.onImageChanged('');
                },
                icon: Assets.svgs.icCloseCircle.svg(),
              ),
          ],
        ),
        if (controller.showValidationErrors.value && controller.imageError.value.isNotEmpty) ...[
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              controller.imageError.value,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        ],
      ],
    ));
  }
}
