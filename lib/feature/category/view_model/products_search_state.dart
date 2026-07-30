sealed class ProductsSearchState<T> {}

class SearchInitialState<T> extends ProductsSearchState<T> {}

class SearchLoadingState<T> extends ProductsSearchState<T> {}

class SearchSuccessState<T> extends ProductsSearchState<T> {
  final T data;
  SearchSuccessState({required this.data});
}

class SearchErrorState<T> extends ProductsSearchState<T> {
  String? messageError;
  SearchErrorState({required this.messageError});
}

class SearchEmptyState<T> extends ProductsSearchState<T> {}
