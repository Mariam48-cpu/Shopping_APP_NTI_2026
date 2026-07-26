import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/home/domain/repositories/home_repository_interface.dart';
 import 'package:injectable/injectable.dart';
 import '../entities/product_entity.dart';

@injectable
class GetProductsUseCase {
  final HomeRepository repository;

  GetProductsUseCase(this.repository);

  Future<ResultApi<ProductEntity>> call() {
    return repository.getProducts();
  }
}