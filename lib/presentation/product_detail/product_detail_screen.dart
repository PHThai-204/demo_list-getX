import 'package:easy_localization/easy_localization.dart';
import 'package:demo_list_getx/presentation/product_detail/product_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

import '../../core/app_utils/date_time_utils.dart';
import '../../core/navigation/navigation_service.dart';
import '../../core/styles/app_colors.dart';
import '../../core/styles/app_text_styles.dart';
import '../../domain/entities/product_entity.dart';
import '../../generated/assets.gen.dart';
import '../custom/button_custom.dart';
import '../custom/dialog_custom.dart';
import '../custom/image_custom.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductDetailController controller = Get.find<ProductDetailController>();

  @override
  Widget build(BuildContext context) {
    final product = controller.product;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text('product_detail'.tr(), style: AppTextStyles.style.s18.w700.blackColor),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(icon: Assets.svgs.icArrow.svg(), onPressed: () => Get.back()),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(product.image),
              const SizedBox(height: 24),

              Text(product.name, style: AppTextStyles.style.s20.w700.blackColor),
              const SizedBox(height: 8),

              _infoText('product_code'.tr(), product.code),
              const SizedBox(height: 12),
              _infoText('price'.tr(), '${product.price}', isPrice: true),
              const SizedBox(height: 12),
              _infoText('stock'.tr(), '${product.stock}'),

              const SizedBox(height: 12),
              _infoText('category'.tr(), product.category?.name ?? 'N/A'),

              const SizedBox(height: 16),
              Container(height: 1, color: AppColors.lightGrey),
              const SizedBox(height: 16),

              if (product.description?.isNotEmpty ?? false) ...[
                Text('description'.tr(), style: AppTextStyles.style.s14.w700.blackColor),
                const SizedBox(height: 8),
                Text(product.description!, style: AppTextStyles.style.s13.w500.darkGrayColor),
                const SizedBox(height: 16),
              ],

              _buildMetaBox(product),

              const SizedBox(height: 32),

              Row(
                children: [
                  Expanded(
                    child: ButtonCustom(
                      title: 'delete_product'.tr(),
                      onPressed: () => _confirmDelete(context, controller),
                      buttonStyle: BoxDecoration(
                        color: AppColors.transparent,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.darkOrange),
                      ),
                      textStyle: AppTextStyles.style.s16.w600.darkOrangeColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ButtonCustom(
                      title: 'update_product'.tr(),
                      onPressed: () =>
                          Get.toNamed(NavigationService.updateProduct, arguments: product)?.then((
                            val,
                          ) {
                            if (val == true) {
                              Get.back(result: true);
                            }
                          }),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String? url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.smokeWhite,
          border: Border.all(color: AppColors.lightGrey),
        ),
        child: ImageCustom(
          imageUrl: url,
          width: double.infinity,
          height: 250,
          fit: BoxFit.cover,
          errorWidget: Container(
            width: double.infinity,
            height: 250,
            color: AppColors.lightGrey,
            child: Center(child: Assets.svgs.icPicture.svg()),
          ),
        ),
      ),
    );
  }

  Widget _infoText(String label, String value, {bool isPrice = false}) {
    return Row(
      children: [
        Text('$label:', style: AppTextStyles.style.s14.w600.darkGrayColor),
        const SizedBox(width: 8),
        Text(
          value,
          style: isPrice
              ? AppTextStyles.style.s14.w700.darkOrangeColor
              : AppTextStyles.style.s14.w500.blackColor,
        ),
      ],
    );
  }

  Widget _buildMetaBox(ProductEntity product) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.smokeWhite,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Column(
        children: [
          _metaRow('ID', '${product.id}'),
          const SizedBox(height: 8),
          _metaRow('created_date'.tr(), DateTimeUtils.fromDateTime(product.createdAt)),
          if (product.updatedAt != null) ...[
            const SizedBox(height: 8),
            _metaRow('updated_date'.tr(), DateTimeUtils.fromDateTime(product.updatedAt)),
          ],
        ],
      ),
    );
  }

  Widget _metaRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.style.s13.w600.darkGrayColor),
        Text(value, style: AppTextStyles.style.s13.w500.blackColor),
      ],
    );
  }

  void _confirmDelete(BuildContext context, ProductDetailController controller) {
    Get.dialog(
      DialogCustom(
        title: 'notification'.tr(),
        content: 'confirm_remove_product'.tr(),
        confirmText: 'confirm'.tr(),
        onConfirm: () {
          controller.deleteProduct();
        },
        onCancel: () => Get.back(),
      ),
    );
  }
}
