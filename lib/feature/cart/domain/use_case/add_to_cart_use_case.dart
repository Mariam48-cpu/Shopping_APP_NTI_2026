import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/cart/domain/repo/cart_repo_interface.dart';
@injectable
class AddToCartUseCase {
  final CartRepositoryInterface repository;
  AddToCartUseCase(this.repository);
  Future<ResultApi<String>> call({
    required int productId,
  }) async {
    return await repository.addToCart(
      productId: productId,
    );
  }
}