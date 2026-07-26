import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/category/data/data_sources/category_remote_data_source_interface.dart';
import 'package:shopping_app/feature/category/domain/repo/category_repo_interface.dart';

import '../../../home/data/dto/product_dto.dart';
import '../../../home/domain/entities/product_entity.dart';

@Injectable(as: CategoryRepoInterface)
class CategoryRepoImp implements CategoryRepoInterface {
  final CategoryRemoteDataSourceInterface _repo;
  CategoryRepoImp(this._repo);
  @override
  Future<ResultApi<List<ProductItemEntity>>> getAllProductsByCategory(
    String slug,
  ) async {
    final result = await _repo.getProductsByCategory(slug: slug);
    try {
      switch (result) {
        case Success<List<ProductItemDto>>():
          final data = result.data;
          final List<ProductItemEntity> listOfProducts = data!
              .map((e) => e.toEntity())
              .toList();
          return Success<List<ProductItemEntity>>(data: listOfProducts);
        case Error<List<ProductItemDto>>():
          return Error<List<ProductItemEntity>>(
            messageError: result.messageError ?? 'Something went wrong',
          );
      }
    } catch (e) {
      return Error(messageError: e.toString());
    }
  }
}
