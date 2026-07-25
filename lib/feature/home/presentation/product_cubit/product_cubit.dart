import 'package:bloc/bloc.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/home/domain/entities/product_entity.dart';
import 'package:shopping_app/feature/home/domain/usecases/get_products_usecase.dart';
import 'package:shopping_app/feature/home/presentation/product_cubit/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductsUseCase getProductsUseCase;

  ProductCubit(this.getProductsUseCase) : super(ProductInitial());

  ProductEntity products = const ProductEntity();

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
