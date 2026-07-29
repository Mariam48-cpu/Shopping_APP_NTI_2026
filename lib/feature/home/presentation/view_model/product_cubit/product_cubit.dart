import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/home/domain/use_case/get_products_use_case.dart';
import 'package:shopping_app/feature/home/presentation/view_model/product_cubit/product_state.dart';
import '../../../../../core/model/item/product_item_entity.dart';
@injectable
class ProductCubit extends Cubit<ProductState> {
  final GetProductsUseCase getProductsUseCase;

  ProductCubit(this.getProductsUseCase) : super(ProductInitial());

  ProductEntity products =  ProductEntity();

  Future<void> getProducts() async {
    emit(ProductLoading());

    final result = await getProductsUseCase();

    if (result is Success<ProductEntity>) {
      products = result.data!;
      emit(ProductSuccess(products: products));
    } else if (result is Error<ProductEntity>) {
      emit(ProductError(messageError: result.messageError ?? ''));
    }
  }
}
