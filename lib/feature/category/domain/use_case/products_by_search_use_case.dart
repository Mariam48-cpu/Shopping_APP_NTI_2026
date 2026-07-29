import 'package:injectable/injectable.dart';
import 'package:shopping_app/feature/category/domain/repo/category_repo_interface.dart';

import '../../../../core/model/item/product_item_entity.dart';
import '../../../../core/network/result_api.dart';
import '../entities/search_request_entity.dart';

@injectable
class ProductsBySearchUseCase {
  final CategoryRepoInterface _repo;
  ProductsBySearchUseCase(this._repo);
  Future<ResultApi<List<ProductItemEntity>>> call({
    required String search,
    int skip = 0,
    int limit = 5,
  })async =>
     await _repo.productsBySearch(search: search);
}
