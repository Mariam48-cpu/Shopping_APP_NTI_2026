import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/cart/data/dto/cart_dto.dart';
abstract class CartDataSourceInterface {
  Future<ResultApi<CartDto>> getCart();

  Future<ResultApi<String>> addToCart({
    required int productId,
  });
 Future<ResultApi<String>> deleteCart({
    required int productId,
  });}