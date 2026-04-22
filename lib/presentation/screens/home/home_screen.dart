import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../data/enums/status_enum.dart';
import 'components/filter_layout.dart';
import 'components/product_item.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('products'.tr()),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed('/create-product')?.then((val) =>
            val == true ? controller.getProduct() : null),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const FilterLayout(),
          Expanded(
            child: Obx(() {
              if (controller.status.value.isProcessing && controller.products.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.status.value.isFailure && controller.products.isEmpty) {
                return Center(child: Text(controller.errorMessage.value));
              }

              if (controller.products.isEmpty) {
                return Center(child: Text('not_product'.tr()));
              }

              return RefreshIndicator(
                onRefresh: controller.getProduct,
                child: ListView.separated(
                  itemCount: controller.products.length + (controller.hasMore.value ? 1 : 0),
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    if (index >= controller.products.length) {
                      controller.loadMoreProduct();
                      return const Center(child: CircularProgressIndicator());
                    }

                    final product = controller.products[index];
                    return ProductItem(
                      product: product,
                      onTap: () => Get.toNamed('/product-detail', arguments: product),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}