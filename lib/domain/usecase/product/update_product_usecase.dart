import 'package:demo_list_getx/domain/repositories/general_repository.dart';

import '../../../data/sources/remote/request/update_product_request.dart';

class UpdateProductUseCase {
  final GeneralRepository _repository;

  UpdateProductUseCase(this._repository);

  Future<void> execute(int id, UpdateProductRequest request) async {
    await _repository.updateProduct(id, request);
  }
}
