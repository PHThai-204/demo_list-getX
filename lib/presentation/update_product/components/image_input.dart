import 'dart:io';

import 'package:demo_list_getx/presentation/custom/dialog_custom.dart';
import 'package:demo_list_getx/presentation/update_product/update_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../core/app_utils/image_picker_util.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/styles/app_text_styles.dart';
import '../../../generated/assets.gen.dart';
import '../../custom/button_custom.dart';
import '../../custom/image_custom.dart';

class ImageInput extends GetView<UpdateProductController> {
  final ImagePickerUtil _imagePickerUtil = ImagePickerUtil();

  ImageInput({super.key});

  Future<void> _pickImage() async {
    try {
      final File? file = await _imagePickerUtil.pickImageFromGallery();
      if (file == null) {
        return;
      }

      controller.onImageLocalPathChanged(file.path);
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
    return Obx(() {
      final hasLocalImage = controller.imageLocalPath.value.trim().isNotEmpty;
      final hasRemoteImage = controller.image.value.trim().isNotEmpty;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasLocalImage) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(controller.imageLocalPath.value),
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
          ] else if (hasRemoteImage) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ImageCustom(
                imageUrl: controller.image.value,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorWidget: Container(
                  height: 180,
                  width: double.infinity,
                  color: AppColors.darkGrey,
                  child: Center(child: Assets.svgs.icPicture.svg()),
                ),
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
                    colorFilter: const ColorFilter.mode(AppColors.darkOrange, BlendMode.srcIn),
                    width: 14,
                    height: 14,
                  ),
                  buttonStyle: BoxDecoration(
                    color: AppColors.transparent,
                    border: Border.all(color: AppColors.darkOrange),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  textStyle: AppTextStyles.style.s16.w500.darkOrangeColor,
                  title: !hasLocalImage && !hasRemoteImage
                      ? 'choose_image_from_device'.tr()
                      : 'change_image'.tr(),
                ),
              ),
              const SizedBox(width: 8),
              if (hasLocalImage || hasRemoteImage)
                IconButton(
                  onPressed: () {
                    if (hasLocalImage) {
                      controller.onImageLocalPathChanged('');
                      return;
                    }
                    controller.onImageChanged('');
                  },
                  icon: const Icon(Icons.close),
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
      );
    });
  }
}
