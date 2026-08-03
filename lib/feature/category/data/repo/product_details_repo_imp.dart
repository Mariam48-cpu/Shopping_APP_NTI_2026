import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/category/data/data_sources/product_details_remote_data_source_interface.dart';
import 'package:shopping_app/feature/category/domain/repo/product_details_repo_interface.dart';

@Injectable(as: ProductDetailsRepoInterface)
class ProductDetailsRepoImp implements ProductDetailsRepoInterface {
  final ProductDetailsRemoteDataSourceInterface _remoteDataSource;

  ProductDetailsRepoImp(this._remoteDataSource);

  @override
  Future<ResultApi<ProductItemEntity>> getProductDetails(int id) async {
    final result = await _remoteDataSource.getProductDetails(id);
    try {
      switch (result) {
        case Success():
          return Success<ProductItemEntity>(data: result.data?.toEntity() ?? ProductItemEntity());
        case Error():
          return Error(messageError: result.messageError ?? 'Something went wrong');
      }
    } catch (e) {
      return Error<ProductItemEntity>(messageError: e.toString());
    }
  }
}