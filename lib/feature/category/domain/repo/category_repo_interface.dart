import 'package:shopping_app/core/network/result_api.dart';
import '../../../home/domain/entities/product_entity.dart';

abstract interface class CategoryRepoInterface {
  Future<ResultApi<List<ProductItemEntity>>> getAllProductsByCategory(
    String slug,
  );
}
