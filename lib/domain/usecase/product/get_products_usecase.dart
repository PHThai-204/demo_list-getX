import 'package:injectable/injectable.dart';

import '../../../data/sources/remote/request/get_product_request.dart';
import '../../entities/product_entity.dart';
import '../../repositories/general_repository.dart';

@injectable
class GetProductsUseCase {
  final GeneralRepository _repository;

  GetProductsUseCase(this._repository);

  Future<List<ProductEntity>> execute(GetProductRequest request) {
    return _repository.fetchProducts(request);
  }
}
