import 'package:demo_list_getx/domain/entities/category_entity.dart';
import 'package:demo_list_getx/domain/repositories/general_repository.dart';

class GetCategoriesUseCase {
  final GeneralRepository _repository;

  GetCategoriesUseCase(this._repository);

  Future<List<CategoryEntity>> execute() => _repository.fetchCategories();
}
