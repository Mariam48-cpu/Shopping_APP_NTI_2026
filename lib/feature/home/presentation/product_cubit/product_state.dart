import 'package:shopping_app/core/model/item/product_item_entity.dart';

sealed class ProductState {}

final class  ProductInitial extends  ProductState {}

final class  ProductLoading extends  ProductState {}

final class  ProductSuccess extends  ProductState {
  final  ProductEntity products;

   ProductSuccess({required this.products});
}

final class  ProductError extends  ProductState {
  final String messageError;

   ProductError({required this.messageError});
}