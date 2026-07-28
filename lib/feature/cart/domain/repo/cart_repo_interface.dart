import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/cart/domain/entities/cart_entity.dart';

abstract class CartRepositoryInterface {
  Future<ResultApi<CartEntity>> getCart();

  Future<ResultApi<String>> addToCart({
    required int productId,
  });

  Future<ResultApi<String>> deleteCart({
    required int productId,
  });
}