class GetProductRequest {
  final int? categoryId;
  final String? keyword;
  final int page;
  final int limit;

  GetProductRequest({this.categoryId, this.keyword, this.page = 1, this.limit = 10});

  Map<String, dynamic> toJson() => {
    if (categoryId != null) 'category_id': categoryId,
    if (keyword != null && keyword!.isNotEmpty) 'keyword': keyword,
    'page': page,
    'limit': limit,
  };
}
