import 'package:shopping_app/core/model/item/product_item_entity.dart';
import '../../../../core/network/result_api.dart';

abstract interface class ProductDetailsRepoInterface {
  Future<ResultApi<ProductItemEntity>> getProductDetails(int id);
}