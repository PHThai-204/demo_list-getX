import 'package:demo_list_getx/domain/entities/product_entity.dart';

import '../../data/sources/remote/request/create_product_request.dart';
import '../../data/sources/remote/request/get_product_request.dart';
import '../../data/sources/remote/request/update_product_request.dart';
import '../entities/category_entity.dart';

abstract class GeneralRepository {
  Future<List<ProductEntity>> fetchProducts(GetProductRequest request);

  Future<List<CategoryEntity>> fetchCategories();

  Future<void> removeProduct(int id);

  Future<void> createProduct(CreateProductRequest request);

  Future<void> updateProduct(int id, UpdateProductRequest request);
}