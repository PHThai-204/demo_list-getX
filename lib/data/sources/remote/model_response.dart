class ModelResponse<T> {
  final T data;

  ModelResponse({required this.data});

  factory ModelResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    return ModelResponse<T>(data: fromJsonT(json['data']));
  }
}
