sealed class ProductState<T> {}

class ProductInitialState<T> extends ProductState<T> {}

class ProductLoadingState<T> extends ProductState<T> {}

class ProductSuccessState<T> extends ProductState<T> {
  final T products;
  ProductSuccessState({required this.products});
}

class ProductErrorState<T> extends ProductState<T> {
  final String messageError;
  ProductErrorState({this.messageError = "Something went wrong"});
}
