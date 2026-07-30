import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/network/result_api.dart';
import '../../../../core/model/item/product_item_dto.dart';

abstract class CategoryRemoteDataSourceInterface {
  Future<ResultApi<List<ProductItemDto>>> getProductsByCategory({
    required String slug,
    int skip = 0,
    int limit = 5,
  });

Future<ResultApi<List<ProductItemEntity>>> productsBySearch({
  required String search,
  int skip = 0,
  int limit = 5,
});

}
