

sealed class CategoryProductsState<T> {}

class CategoryInitialState<T> extends CategoryProductsState<T> {}

class CategoryLoadingState<T> extends CategoryProductsState<T> {}

class CategorySuccessState<T> extends CategoryProductsState<T> {
  T products;
  CategorySuccessState({required this.products});
}

class CategoryErrorState<T> extends CategoryProductsState<T> {
  String messageError;
  CategoryErrorState({required this.messageError});
}
class CategoryEmptyState<T> extends CategoryProductsState<T> {}
