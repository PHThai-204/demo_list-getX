import 'package:get/get.dart';
import 'package:demo_list_getx/data/sources/remote/request/get_product_request.dart';
import 'package:demo_list_getx/domain/usecase/product/get_products_usecase.dart';
import 'package:demo_list_getx/domain/usecase/category/get_categories_usecase.dart';
import '../../../data/enums/home_sort_enum.dart';
import '../../../data/enums/status_enum.dart';
import '../../../domain/entities/category_entity.dart';
import '../../../domain/entities/product_entity.dart';

class HomeController extends GetxController {
  final GetProductsUseCase getProductsUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;

  var status = StatusEnum.initial.obs;
  var errorMessage = ''.obs;
  var products = <ProductEntity>[].obs;
  var allProducts = <ProductEntity>[].obs;
  var categories = <CategoryEntity>[].obs;

  var keyword = ''.obs;
  var categoryId = RxnInt();
  var sortOption = HomeSortEnum.defaultOrder.obs;
  var page = 1.obs;
  var hasMore = true.obs;
  var isLoadingMore = false.obs;
  var isRefreshing = false.obs;

  HomeController(this.getProductsUseCase, this.getCategoriesUseCase);

  @override
  void onInit() {
    super.onInit();
    getProduct();
    getCategories();
  }

  Future<void> getProduct() async {
    if (status.value.isProcessing) return;

    status.value = StatusEnum.processing;
    errorMessage.value = '';

    try {
      final result = await _fetchProducts(page: 1);

      allProducts.assignAll(result);
      products.assignAll(_applySort(result, sortOption.value));

      page.value = 1;
      hasMore.value = result.length >= 10;
      status.value = StatusEnum.success;
    } catch (e) {
      status.value = StatusEnum.failure;
      errorMessage.value = e.toString();
    }
  }

  Future<void> refreshProduct() async {
    if (isRefreshing.value) return;

    isRefreshing.value = true;
    try {
      final result = await _fetchProducts(page: 1);
      allProducts.assignAll(result);
      products.assignAll(_applySort(result, sortOption.value));

      page.value = 1;
      hasMore.value = result.length >= 10;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isRefreshing.value = false;
    }
  }

  Future<void> loadMoreProduct() async {
    if (isLoadingMore.value || !hasMore.value) return;

    isLoadingMore.value = true;
    final nextPage = page.value + 1;

    try {
      final result = await _fetchProducts(page: nextPage);

      allProducts.addAll(result);
      products.assignAll(_applySort(allProducts, sortOption.value));

      page.value = nextPage;
      hasMore.value = result.length >= 10;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoadingMore.value = false;
    }
  }

  void onKeywordChanged(String value) {
    final cleanKeyword = value.trim();
    if (keyword.value == cleanKeyword) return;

    keyword.value = cleanKeyword;
    getProduct();
  }

  void onCategoryFilterChanged(int? id) {
    if (categoryId.value == id) return;

    categoryId.value = id;
    getProduct();
  }

  void onSortChanged(HomeSortEnum option) {
    sortOption.value = option;
    products.assignAll(_applySort(allProducts, option));
  }

  void getCategories() async {
    try {
      final result = await getCategoriesUseCase.execute();
      categories.assignAll(result);
    } catch (_) {}
  }

  Future<List<ProductEntity>> _fetchProducts({required int page}) async {
    final request = GetProductRequest(
      page: page,
      limit: 10,
      keyword: keyword.value,
      categoryId: categoryId.value,
    );
    return await getProductsUseCase.execute(request);
  }

  List<ProductEntity> _applySort(List<ProductEntity> source, HomeSortEnum option) {
    final sorted = List<ProductEntity>.from(source);
    switch (option) {
      case HomeSortEnum.defaultOrder:
        break;
      case HomeSortEnum.updatedNewest:
        sorted.sort((a, b) {
          final aDate = a.updatedAt ?? a.createdAt;
          final bDate = b.updatedAt ?? b.createdAt;
          return bDate.compareTo(aDate);
        });
        break;
      case HomeSortEnum.nameAsc:
        sorted.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        break;
      case HomeSortEnum.nameDesc:
        sorted.sort((a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
        break;
      case HomeSortEnum.priceAsc:
        sorted.sort((a, b) => a.price.compareTo(b.price));
        break;
      case HomeSortEnum.priceDesc:
        sorted.sort((a, b) => b.price.compareTo(a.price));
        break;
      case HomeSortEnum.stockAsc:
        sorted.sort((a, b) => a.stock.compareTo(b.stock));
        break;
      case HomeSortEnum.stockDesc:
        sorted.sort((a, b) => b.stock.compareTo(a.stock));
        break;
    }
    return sorted;
  }
}
