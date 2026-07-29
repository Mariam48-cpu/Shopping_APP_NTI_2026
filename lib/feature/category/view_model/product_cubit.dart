import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/category/domain/use_case/get_product_details_use_case.dart';
import 'package:shopping_app/feature/category/view_model/product_state.dart';

@injectable
class ProductCubit extends Cubit<ProductState<ProductItemEntity>> {
  ProductCubit(this._useCase) : super(ProductInitialState<ProductItemEntity>());

  final GetProductDetailsUseCase _useCase;

  Future<void> intent(ProductDetailsIntent intent) async {
    if (intent case GetProductDetailsIntent(:final id)) {
      await _getProductDetails(id);
    }
  }

  Future<void> _getProductDetails(int id) async {
    emit(ProductLoadingState<ProductItemEntity>());
    try {
      var result = await _useCase.call(id);
      switch (result) {
        case Success<ProductItemEntity>(:final data):
          if (data != null) {
            emit(ProductSuccessState<ProductItemEntity>(products: data));
          } else {
            emit(ProductErrorState<ProductItemEntity>(messageError: "No product data found"));
          }
        case Error<ProductItemEntity>(:final messageError):
          emit(
            ProductErrorState<ProductItemEntity>(
              messageError: messageError ?? "Something went wrong",
            ),
          );
      }
    } catch (e) {
      emit(ProductErrorState<ProductItemEntity>(messageError: e.toString()));
    }
  }
}

sealed class ProductDetailsIntent {}

class GetProductDetailsIntent extends ProductDetailsIntent {
  final int id;
  GetProductDetailsIntent({required this.id});
}