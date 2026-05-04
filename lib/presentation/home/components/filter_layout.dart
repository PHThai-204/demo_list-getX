import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../data/enums/home_sort_enum.dart';
import '../../../../generated/assets.gen.dart';
import '../home_controller.dart';

class FilterLayout extends StatefulWidget {
  const FilterLayout({super.key});

  @override
  State<StatefulWidget> createState() => _FilterLayoutState();
}

class _FilterLayoutState extends State<FilterLayout> {
  Timer? _searchDebounce;
  late final TextEditingController _searchController;
  late final FocusNode _categoryFocusNode;
  late final FocusNode _sortFocusNode;

  final HomeController controller = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _categoryFocusNode = FocusNode()..addListener(_onFocusChanged);
    _sortFocusNode = FocusNode()..addListener(_onFocusChanged);
  }

  void _onFocusChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _searchController.dispose();
    _categoryFocusNode.dispose();
    _sortFocusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 300), () {
      controller.onKeywordChanged(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.lightGrey),
    );
    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.darkOrange),
    );

    return Obx(() => Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            onChanged: _onSearchChanged,
            cursorColor: AppColors.darkOrange,
            decoration: InputDecoration(
              hintText: 'search_product_name'.tr(),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Assets.svgs.icSearch.svg(
                  colorFilter: const ColorFilter.mode(AppColors.black, BlendMode.srcIn),
                ),
              ),
              prefixIconConstraints: const BoxConstraints(minWidth: 40, maxHeight: 40),
              isDense: true,
              border: defaultBorder,
              enabledBorder: defaultBorder,
              focusedBorder: focusedBorder,
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<int?>(
            isExpanded: true,
            focusNode: _categoryFocusNode,
            initialValue: controller.categoryId.value,
            decoration: InputDecoration(
              labelText: 'category'.tr(),
              isDense: true,
              labelStyle: const TextStyle(color: AppColors.black),
              floatingLabelStyle: TextStyle(
                color: _categoryFocusNode.hasFocus ? AppColors.darkOrange : AppColors.black,
              ),
              border: defaultBorder,
              enabledBorder: defaultBorder,
              focusedBorder: focusedBorder,
            ),
            items: [
              DropdownMenuItem<int?>(value: null, child: Text('all_category'.tr())),
              ...controller.categories.map(
                    (category) => DropdownMenuItem<int?>(value: category.id, child: Text(category.name)),
              ),
            ],
            onChanged: controller.onCategoryFilterChanged,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<HomeSortEnum>(
            isExpanded: true,
            focusNode: _sortFocusNode,
            initialValue: controller.sortOption.value,
            decoration: InputDecoration(
              labelText: 'sort'.tr(),
              isDense: true,
              labelStyle: const TextStyle(color: AppColors.black),
              floatingLabelStyle: TextStyle(
                color: _sortFocusNode.hasFocus ? AppColors.darkOrange : AppColors.black,
              ),
              border: defaultBorder,
              enabledBorder: defaultBorder,
              focusedBorder: focusedBorder,
            ),
            items: HomeSortEnum.values
                .map((option) => DropdownMenuItem<HomeSortEnum>(value: option, child: Text(option.label)))
                .toList(),
            onChanged: (value) {
              if (value != null) controller.onSortChanged(value);
            },
          ),
        ],
      ),
    ));
  }
}