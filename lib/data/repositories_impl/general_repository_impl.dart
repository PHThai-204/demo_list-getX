import 'package:demo_list_getx/data/sources/remote/request/create_product_request.dart';
import 'package:demo_list_getx/data/sources/remote/request/get_product_request.dart';
import 'package:demo_list_getx/data/sources/remote/request/update_product_request.dart';
import 'package:demo_list_getx/domain/entities/category_entity.dart';
import 'package:demo_list_getx/domain/entities/product_entity.dart';

import '../../domain/repositories/general_repository.dart';
import '../sources/remote/network/api_exception.dart';
import '../sources/remote/services/general_service.dart';

class GeneralRepositoryImpl implements GeneralRepository {
  final GeneralService _generalService;

  GeneralRepositoryImpl(this._generalService);

  @override
  Future<List<ProductEntity>> fetchProducts(GetProductRequest request) async {
    try {
      final result = await _generalService.fetchProducts(request);
      return result;
    } catch (e) {
      throw ApiException.from(e);
    }
  }

  @override
  Future<List<CategoryEntity>> fetchCategories() async {
    try {
      final result = await _generalService.fetchCategories();
      return result;
    } catch (e) {
      throw ApiException.from(e);
    }
  }

  @override
  Future<void> removeProduct(int id) async {
    try {
      await _generalService.removeProduct(id);
    } catch (e) {
      throw ApiException.from(e);
    }
  }

  @override
  Future<void> createProduct(CreateProductRequest request) async {
    try {
      await _generalService.createProduct(request);
    } catch (e) {
      throw ApiException.from(e);
    }
  }

  @override
  Future<void> updateProduct(int id, UpdateProductRequest request) async {
    try {
      await _generalService.updateProduct(id, request);
    } catch (e) {
      throw ApiException.from(e);
    }
  }
}
