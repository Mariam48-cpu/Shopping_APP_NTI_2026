import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/category/data/data_sources/product_details_data_source_interface.dart';
import 'package:shopping_app/feature/category/domain/repo/product_details_repo_interface.dart';

import '../../domain/entities/product_details_entity.dart';
import '../models/product_details_dto.dart';

@Injectable(as: ProductDetailsRepoInterface)
class ProductDetailsRepoImp implements ProductDetailsRepoInterface {
  final ProductDetailsRemoteDataSourceInterface _remoteDataSource;

  ProductDetailsRepoImp(this._remoteDataSource);

  @override
  Future<ResultApi<ProductDetailsEntity>> getProductDetails(int id) async {
    final result = await _remoteDataSource.getProductDetails(id);
    try {
      switch (result) {
        case Success<ProductDetailsDto>():
          if (result.data != null) {
            return Success<ProductDetailsEntity>(data: result.data!.toEntity());
          } else {
            return Error<ProductDetailsEntity>(
              messageError: 'No product details found',
            );
          }
        case Error():
          return Error(
            messageError: result.messageError ?? 'Something went wrong',
          );
      }
    } catch (e) {
      return Error<ProductDetailsEntity>(messageError: e.toString());
    }
  }
}
