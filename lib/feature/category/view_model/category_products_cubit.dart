import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/category/view_model/category_products_state.dart';
import '../../home/domain/entities/product_entity.dart';
import '../domain/use_case/get_all_products_by_category_use_case.dart';

@injectable
class ProductsByCategoryCubit
    extends Cubit<CategoryProductsState<List<ProductItemEntity>>> {
  ProductsByCategoryCubit(this._useCase) : super(CategoryInitialState());
  final GetAllProductsByCategoryUseCase _useCase;
  Future<void> intent(CategoryProductsIntent intent) async {
    if (intent case GetAllProductsByCategoryIntent(:final slug)) {
      await _getProductsByCategory(slug);
    }
  }

  Future<void> _getProductsByCategory(String slug) async {
    emit(CategoryLoadingState());

    try {
      var result = await _useCase(slug);
      switch (result) {
        case Success<List<ProductItemEntity>>():
          emit(
            CategorySuccessState<List<ProductItemEntity>>(
              products: result.data!,
            ),
          );
        case Error<List<ProductItemEntity>>():
          emit(
            CategoryErrorState<List<ProductItemEntity>>(
              messageError: result.messageError,
            ),
          );
      }
    } catch (e) {
      emit(
        CategoryErrorState<List<ProductItemEntity>>(messageError: e.toString()),
      );
    }
  }
}

sealed class CategoryProductsIntent {}

class GetAllProductsByCategoryIntent extends CategoryProductsIntent {
  String slug;
  GetAllProductsByCategoryIntent({required this.slug});
}
