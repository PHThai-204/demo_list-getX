class CreateProductRequest {
  final String name;
  final String code;
  final double price;
  final int stock;
  final int? categoryId;
  final String? description;
  final String? image;

  CreateProductRequest({
    required this.name,
    required this.code,
    required this.price,
    required this.stock,
    this.categoryId,
    this.description,
    this.image,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'code': code,
    'price': price,
    'stock': stock,
    if (categoryId != null) 'category_id': categoryId,
    if (description != null) 'description': description,
    if (image != null) 'image': image,
  };
}
