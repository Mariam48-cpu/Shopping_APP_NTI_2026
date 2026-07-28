import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/cart/domain/repo/cart_data_source_interface.dart';
import 'package:shopping_app/feature/cart/data/dto/cart_dto.dart';
import 'package:shopping_app/feature/cart/domain/entities/cart_entity.dart';
import 'package:shopping_app/feature/cart/domain/repo/cart_repo_interface.dart';

@LazySingleton(as: CartRepositoryInterface)
class CartRepositoryImpl implements CartRepositoryInterface {
  final CartDataSourceInterface remoteDataSource;

  CartRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ResultApi<CartEntity>> getCart() async {
    final result = await remoteDataSource.getCart();

    if (result is Success<CartDto>) {
      return Success(data: result.data?.toEntity());
    }

    return Error(messageError: (result as Error).messageError);
  }

  @override
  Future<ResultApi<String>> addToCart({required int productId}) async {
    return await remoteDataSource.addToCart(productId: productId);
  }

  @override
  Future<ResultApi<String>> deleteCart({required int productId}) async {
    return await remoteDataSource.deleteCart(productId: productId);
  }
}
