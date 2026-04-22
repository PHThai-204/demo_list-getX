import 'package:demo_list_getx/domain/entities/category_entity.dart';

class ProductEntity {
  int id;
  int status;
  DateTime createdAt;
  DateTime? updatedAt;
  String name;
  String code;
  double price;
  int stock;
  CategoryEntity? category;
  String? description;
  String? image;

  ProductEntity({
    required this.id,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    required this.name,
    required this.code,
    required this.price,
    required this.stock,
    this.category,
    this.description,
    this.image,
  });
}
