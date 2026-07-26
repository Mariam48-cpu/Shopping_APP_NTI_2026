import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/domain/entities/product_item_entity.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/category/view_model/category_products_state.dart';
import '../data/repo/repo/category_repo_interface.dart';
@injectable
class ProductsByCategoryCubit extends Cubit<CategoryProductsState<List<ProductEntity>>> {
  ProductsByCategoryCubit(this._repo) : super(CategoryInitialState());
  final CategoryRepoInterface _repo;

  Future<void> intent(CategoryProductsIntent intent) async {
    switch (intent) {
      case GetAllProductsByCategoryIntent(:final slug):
        await _getProductsByCategory(slug);
    }
  }

  Future<void> _getProductsByCategory(String slug) async {
    emit(CategoryLoadingState());
    try {
      var result = await _repo.getAllProductsByCategory(slug);
      switch (result) {
        case Success<List<ProductEntity>>():
          emit(CategorySuccessState(products: result.data));
        case Error<List<ProductEntity>>():
          emit(CategoryErrorState(messageError: result.messageError));
      }
    } catch (e) {
      emit(CategoryErrorState(messageError: e.toString()));
    }
  }
}

sealed class CategoryProductsIntent {}

class GetAllProductsByCategoryIntent extends CategoryProductsIntent {
  String slug;
  GetAllProductsByCategoryIntent({required this.slug});
}
