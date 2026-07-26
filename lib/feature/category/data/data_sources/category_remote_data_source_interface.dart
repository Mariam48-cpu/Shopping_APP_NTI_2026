import 'package:shopping_app/core/network/result_api.dart';

import '../../../home/data/dto/product_dto.dart';

abstract class CategoryRemoteDataSourceInterface {
  Future<ResultApi<List<ProductItemDto>>> getProductsByCategory({
    required String slug,
    int skip = 0,
    int limit = 5,
  });
}
