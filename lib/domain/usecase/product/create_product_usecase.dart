import 'package:demo_list_getx/domain/repositories/general_repository.dart';

import '../../../data/sources/remote/request/create_product_request.dart';

class CreateProductUseCase {
  final GeneralRepository _generalRepository;

  CreateProductUseCase(this._generalRepository);

  Future<void> execute(CreateProductRequest request) {
    return _generalRepository.createProduct(request);
  }
}