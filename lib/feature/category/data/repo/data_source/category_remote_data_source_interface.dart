import 'package:shopping_app/core/network/result_api.dart';

import '../../../../../core/data/models/product_item_dto.dart';
abstract class CategoryRemoteDataSourceInterface {
  Future<ResultApi<List<ProductDto>>> getProductsByCategory({
    required String slug,
    int skip = 0,
    int limit = 5,
  });
}