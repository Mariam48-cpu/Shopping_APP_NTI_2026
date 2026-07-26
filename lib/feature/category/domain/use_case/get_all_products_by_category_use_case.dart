import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/home/domain/entities/product_entity.dart';
import '../repo/category_repo_interface.dart';

@injectable
class GetAllProductsByCategoryUseCase {
  final CategoryRepoInterface _repo;

  GetAllProductsByCategoryUseCase(this._repo);

  Future<ResultApi<List<ProductItemEntity>>> call(String slug) async {
    return await _repo.getAllProductsByCategory(slug);
  }
}
