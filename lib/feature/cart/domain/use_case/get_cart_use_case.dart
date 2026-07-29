import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/cart/domain/entities/cart_entity.dart';
import 'package:shopping_app/feature/cart/domain/repo/cart_repo_interface.dart';
@injectable
class GetCartUseCase {
  final CartRepositoryInterface repository;
  GetCartUseCase(this.repository);
  Future<ResultApi<CartEntity>> call() async {
    return await repository.getCart();
  }
}