import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/network/result_api.dart';

import 'package:shopping_app/feature/category/domain/use_case/products_by_search_use_case.dart';
import 'package:shopping_app/feature/category/view_model/products_search_state.dart';


@injectable

class ProductSearchCubit extends Cubit<ProductsSearchState> {
  ProductSearchCubit(this._searchUseCase) : super(SearchInitialState());

  final ProductsBySearchUseCase _searchUseCase;

  Future<void> intent(ProductsSearchIntent intent) async {
    switch (intent) {
      case SearchProductsIntent():
        _searchProducts(search: intent.search);
    }
  }

  Future<void> _searchProducts({
    required String search,
  }) async {
    emit(SearchLoadingState());
    var result = await _searchUseCase.call( search: search);
    switch (result) {
      case Success<List<ProductItemEntity>>():
        emit(SearchSuccessState(data: result.data!));
      case Error<List<ProductItemEntity>>():
        emit(SearchErrorState(messageError: result.messageError));
    }
  }
}

sealed class ProductsSearchIntent {}

class SearchProductsIntent extends ProductsSearchIntent {
  final String search;
  SearchProductsIntent({required this.search});
}
