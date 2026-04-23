import 'package:demo_list_getx/domain/repositories/general_repository.dart';

class RemoveProductUseCase {
  final GeneralRepository _repository;

  RemoveProductUseCase(this._repository);

  Future<void> execute(int id) => _repository.removeProduct(id);
}