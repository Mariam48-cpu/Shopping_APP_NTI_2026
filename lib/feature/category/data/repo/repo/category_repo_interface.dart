import 'package:shopping_app/core/domain/entities/product_item_entity.dart';
import 'package:shopping_app/core/network/result_api.dart';

abstract interface class CategoryRepoInterface {
  Future<ResultApi<List<ProductEntity>>> getAllProductsByCategory(String slug);
}