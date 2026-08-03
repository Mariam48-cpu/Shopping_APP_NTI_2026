import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/home/domain/repo/home_repository_interface.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductsUseCase {
  final HomeRepository repository;

  GetProductsUseCase(this.repository);

  Future<ResultApi<ProductEntity>> call() {
    return repository.getProducts();
  }
}
