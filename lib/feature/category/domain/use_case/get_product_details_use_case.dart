import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/category/domain/repo/product_details_repo_interface.dart';

@injectable
class GetProductDetailsUseCase {
  final ProductDetailsRepoInterface _repo;
  GetProductDetailsUseCase(this._repo);

  Future<ResultApi<ProductItemEntity>> call(int id) async {
    return await _repo.getProductDetails(id);
  }
}