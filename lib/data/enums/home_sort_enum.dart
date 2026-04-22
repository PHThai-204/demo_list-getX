import 'package:easy_localization/easy_localization.dart';

enum HomeSortEnum {
  defaultOrder,
  updatedNewest,
  nameAsc,
  nameDesc,
  priceAsc,
  priceDesc,
  stockAsc,
  stockDesc,
}

extension HomeSortEnumX on HomeSortEnum {
  String get label {
    switch (this) {
      case HomeSortEnum.defaultOrder:
        return 'sort_default'.tr();
      case HomeSortEnum.nameAsc:
        return 'sort_name_asc'.tr();
      case HomeSortEnum.nameDesc:
        return 'sort_name_desc'.tr();
      case HomeSortEnum.priceAsc:
        return 'sort_price_asc'.tr();
      case HomeSortEnum.priceDesc:
        return 'sort_price_desc'.tr();
      case HomeSortEnum.stockAsc:
        return 'sort_stock_asc'.tr();
      case HomeSortEnum.stockDesc:
        return 'sort_stock_desc'.tr();
      case HomeSortEnum.updatedNewest:
        return 'sort_updated_newest'.tr();
    }
  }
}
