import 'package:shopping_app/core/network/result_api.dart';
import '../../../../core/model/item/product_item_entity.dart';

abstract interface class CategoryRepoInterface {
  Future<ResultApi<List<ProductItemEntity>>> getAllProductsByCategory(
    String slug,
  );
  Future<ResultApi<List<ProductItemEntity>>> productsBySearch(
      {
        required String search,
        int skip = 0,
        int limit = 5,
      }
  );
}
