import 'package:demo_list_getx/domain/entities/product_entity.dart';

import 'category_model.dart';

class ProductModel extends ProductEntity {
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'],
    status: json['status'],
    createdAt: DateTime.parse(json['created_at']),
    updatedAt: DateTime.parse(json['updated_at']),
    name: json['name'],
    code: json['code'],
    price: (json['price'] as num).toDouble(),
    stock: json['stock'],
    category: json['category'] != null ? CategoryModel.fromJson(json['category']) : null,
    description: json['description'],
    image: json['image'],
  );

  ProductModel({
    required super.id,
    required super.status,
    required super.createdAt,
    super.updatedAt,
    required super.name,
    required super.code,
    required super.price,
    required super.stock,
    super.category,
    super.description,
    super.image,
  });
}
