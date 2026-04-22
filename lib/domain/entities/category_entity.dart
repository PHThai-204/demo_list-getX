class CategoryEntity {
  int id;
  int status;
  DateTime createdAt;
  DateTime? updatedAt;
  String name;

  CategoryEntity({
    required this.id,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    required this.name,
  });
}
