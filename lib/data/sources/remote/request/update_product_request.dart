class UpdateProductRequest {
  final String name;
  final double price;
  final int stock;
  final int? categoryId;
  final String? description;
  final String? image;

  UpdateProductRequest({
    required this.name,
    required this.price,
    required this.stock,
    this.categoryId,
    this.description,
    this.image,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'price': price,
    'stock': stock,
    if (categoryId != null) 'category_id': categoryId,
    if (description != null) 'description': description,
    if (image != null) 'image': image,
  };
}

