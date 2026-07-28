import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/cart/domain/entities/cart_entity.dart';
import 'package:shopping_app/feature/cart/domain/use_case/add_to_cart_use_case.dart';
import 'package:shopping_app/feature/cart/domain/use_case/delete_cart_use_case.dart';
import 'package:shopping_app/feature/cart/domain/use_case/get_cart_use_case.dart';

part 'cart_state.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  final GetCartUseCase getCartUseCase;
  final AddToCartUseCase addToCartUseCase;
  final DeleteCartUseCase deleteCartUseCase;

  CartCubit({
    required this.getCartUseCase,
    required this.addToCartUseCase,
    required this.deleteCartUseCase,
  }) : super(CartInitial());

  CartEntity? cartEntity;

  Future<void> getCart() async {
    emit(CartLoading());

    final result = await getCartUseCase();

    switch (result) {
      case Success<CartEntity>():
        print(result.data?.list.length);

        for (final item in result.data!.list) {
          print(item.title);
          print(item.price);
          print(item.thumbnail);
        }

        cartEntity = result.data;
        emit(CartSuccess(cart: result.data));

      case Error<CartEntity>():
        emit(CartError(message: result.messageError));
    }
  }

  Future<String?> addToCart({required int productId}) async {
    final result = await addToCartUseCase(productId: productId);

    switch (result) {
      case Success<String>():
        await getCart();
        return result.data;

      case Error<String>():
        return result.messageError;
    }
  }

  Future<String?> deleteCart({required int productId}) async {
    final result = await deleteCartUseCase(productId: productId);

    switch (result) {
      case Success<String>():
        await getCart();
        return result.data;

      case Error<String>():
        return result.messageError;
    }
  }

  double calculateTotalPrice() {
    double total = 0;

    if (cartEntity == null) return total;

    for (final product in cartEntity!.list) {
      total += product.price;
    }

    return total;
  }
}
