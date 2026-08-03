import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/cart/domain/repo/cart_data_source_interface.dart';
import 'package:shopping_app/feature/cart/data/dto/cart_dto.dart';
import 'package:shopping_app/feature/cart/domain/entities/cart_entity.dart';
import 'package:shopping_app/feature/cart/domain/repo/cart_repo_interface.dart';

@LazySingleton(as: CartRepositoryInterface)
class CartRepositoryImpl implements CartRepositoryInterface {
  CartRepositoryImpl(this.DataSource);

  final CartDataSourceInterface DataSource;

  @override
  Future<ResultApi<CartEntity>> getCart() async {
    final result = await DataSource.getCart();
    switch (result) {
      case Success<CartDto>():
        return Success(data: result.data?.toEntity());
      case Error<CartDto>():
        return Error(messageError: result.messageError);
    }
  }
  @override
  Future<ResultApi<String>> addToCart({required int productId}) async {
    return DataSource.addToCart(productId: productId);
  }

  @override
  Future<ResultApi<String>> deleteCart({required int productId}) async {
    return DataSource.deleteCart(productId: productId);
  }
}
