import 'package:shopping_app/core/model/item/product_item_entity.dart';

sealed class ProductState<T> {}

final class ProductInitial<T> extends ProductState<T> {}

final class ProductLoading<T> extends ProductState<T> {}

final class ProductSuccess<T> extends ProductState<T> {
  final ProductEntity products;

  ProductSuccess({required this.products});
}

final class ProductError<T> extends ProductState<T> {
  final String messageError;

  ProductError({required this.messageError});
}
