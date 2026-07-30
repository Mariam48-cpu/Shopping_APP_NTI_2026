import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/category/domain/use_case/get_product_details_use_case.dart';
import 'package:shopping_app/feature/category/view_model/product_state.dart';

import '../domain/entities/product_details_entity.dart';

@injectable
class ProductCubit extends Cubit<ProductState<ProductDetailsEntity>> {
  ProductCubit(this._useCase) : super(ProductInitialState<ProductDetailsEntity>());

  final GetProductDetailsUseCase _useCase;

  Future<void> intent(ProductDetailsIntent intent) async {
    if (intent case GetProductDetailsIntent(:final id)) {
      await _getProductDetails(id);
    }
  }

  Future<void> _getProductDetails(int id) async {
    emit(ProductLoadingState<ProductDetailsEntity>());
    try {
      var result = await _useCase.call(id);
      switch (result) {
        case Success<ProductDetailsEntity>(:final data):
          if (data != null) {
            emit(ProductSuccessState<ProductDetailsEntity>(products: data));
          } else {
            emit(ProductErrorState<ProductDetailsEntity>(messageError: "No product data found"));
          }
        case Error<ProductDetailsEntity>(:final messageError):
          /////print
          print("API ERROR DETAILS: $messageError");
          emit(
            ProductErrorState<ProductDetailsEntity>(
              messageError: messageError ?? "Something went wrong",
            ),
          );
      }
    } catch (e) {
      //////print
      print("CUBIT CATCH ERROR: $e");
      emit(ProductErrorState<ProductDetailsEntity>(messageError: e.toString()));
    }
  }
}

sealed class ProductDetailsIntent {}

class GetProductDetailsIntent extends ProductDetailsIntent {
  final int id;
  GetProductDetailsIntent({required this.id});
}