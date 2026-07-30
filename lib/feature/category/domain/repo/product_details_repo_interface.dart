import '../../../../core/network/result_api.dart';
import '../entities/product_details_entity.dart';

abstract interface class ProductDetailsRepoInterface {
  Future<ResultApi<ProductDetailsEntity>> getProductDetails(int id);
}
