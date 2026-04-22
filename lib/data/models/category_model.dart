import '../../domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json['id'],
    status: json['status'],
    createdAt: DateTime.tryParse(json['created_at']) ?? DateTime.now(),
    updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    name: json['name'],
  );

  CategoryModel({
    required super.id,
    required super.status,
    required super.createdAt,
    super.updatedAt,
    required super.name,
  });
}
