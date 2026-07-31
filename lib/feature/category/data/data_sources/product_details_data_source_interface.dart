import '../../../../core/network/result_api.dart';
import '../models/product_details_dto.dart';

abstract interface class ProductDetailsRemoteDataSourceInterface {
  Future<ResultApi<ProductDetailsDto>> getProductDetails(int id);
}
