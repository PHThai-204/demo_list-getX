import 'package:dio/dio.dart';

import '../../../models/category_model.dart';
import '../../../models/product_model.dart';
import '../model_response.dart';
import '../network/api_exception.dart';
import '../request/create_product_request.dart';
import '../request/get_product_request.dart';
import '../request/update_product_request.dart';

class GeneralService {
  final Dio _dio;

  GeneralService(this._dio);

  final productPath = 'products';
  final categoryPath = 'categories';


  Future<List<ProductModel>> fetchProducts(GetProductRequest request) async {
    try {
      final response = await _dio.get(productPath, queryParameters: request.toJson());
      if (response.data['data'] == null) return [];
      final result = ModelResponse.fromJson(
        response.data,
        (json) =>
            (json as List).map((e) => ProductModel.fromJson(e as Map<String, dynamic>)).toList(),
      );
      return result.data;
    } on ApiException {
      rethrow;
    }
  }

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await _dio.get(categoryPath);
      final result = ModelResponse.fromJson(
        response.data,
        (json) =>
            (json as List).map((e) => CategoryModel.fromJson(e as Map<String, dynamic>)).toList(),
      );
      return result.data;
    } on ApiException {
      rethrow;
    }
  }

  Future<void> createProduct(CreateProductRequest request) async {
    try {
      await _dio.post(productPath, data: request.toJson());
    } on ApiException {
      rethrow;
    }
  }

  Future<void> updateProduct(int id, UpdateProductRequest request) async {
    try {
      await _dio.put('$productPath/$id', data: request.toJson());
    } on ApiException {
      rethrow;
    }
  }

  Future<void> removeProduct(int id) async {
    try {
      await _dio.delete('$productPath/$id');
    } on ApiException {
      rethrow;
    }
  }
}
