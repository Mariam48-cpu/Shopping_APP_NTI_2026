import '../../../../core/model/item/product_item_dto.dart';
import '../../../../core/network/result_api.dart';

abstract interface class ProductDetailsRemoteDataSourceInterface {
  Future<ResultApi<ProductItemDto>> getProductDetails(int id);
}
