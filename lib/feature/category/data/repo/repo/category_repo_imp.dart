import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/data/models/product_item_dto.dart';
import 'package:shopping_app/core/domain/entities/product_item_entity.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/category/data/repo/data_source/category_remote_data_source_interface.dart';
import 'package:shopping_app/feature/category/data/repo/repo/category_repo_interface.dart';
@Injectable(as : CategoryRepoInterface)
class CategoryRepoImp implements CategoryRepoInterface {
  final CategoryRemoteDataSourceInterface _repo;
  CategoryRepoImp(this._repo);
  @override
  Future<ResultApi<List<ProductEntity>>> getAllProductsByCategory(String slug) async{
    final result = await _repo.getProductsByCategory(slug: slug);
    switch(result){

      case Success<List<ProductDto>>():
        final data = result.data;
        final listOfProducts = data!.map((e) => e.toEntity()).toList();
        final newList = listOfProducts.where((e) => e.images.isNotEmpty).toList();
        return Success <List<ProductEntity>>(data: newList);
      case Error<List<ProductDto>>():
        return Error<List<ProductEntity>>(messageError: result.messageError);
    }

  }
}