import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../domain/entities/product_entity.dart';
import '../../../../generated/assets.gen.dart';
import '../../custom/image_custom.dart';

class ProductItem extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback onTap;

  const ProductItem({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.smokeWhite,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.lightGrey),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ImageCustom(
                imageUrl: product.image,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorWidget: Container(
                  width: 100,
                  height: 100,
                  color: AppColors.lightGrey,
                  child: Center(child: Assets.svgs.icPicture.svg()),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: AppTextStyles.style.s16.w700.blackColor,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${'product_code'.tr()}: ${product.code}',
                    style: AppTextStyles.style.s13.w500.darkGrayColor,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${'price'.tr()}: ${product.price}',
                    style: AppTextStyles.style.s13.w500.darkGrayColor,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${'stock'.tr()}: ${product.stock}',
                    style: AppTextStyles.style.s13.w500.darkGrayColor,
                  ),
                  if (product.category?.name != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      '${'category'.tr()}: ${product.category?.name}',
                      style: AppTextStyles.style.s13.w500.darkGrayColor,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}