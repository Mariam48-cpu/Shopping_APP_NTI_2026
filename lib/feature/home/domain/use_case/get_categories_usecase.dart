import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/home/domain/entities/category_entity.dart';
import 'package:shopping_app/feature/home/domain/repositories/home_repository_interface.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCategoriesUseCase {
  final HomeRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<ResultApi<CategoryEntity>> call() {
    return repository.getCategories();
  }
}