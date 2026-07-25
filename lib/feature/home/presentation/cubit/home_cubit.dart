import 'package:bloc/bloc.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/home/domain/entities/category_entity.dart';
import 'package:shopping_app/feature/home/domain/entities/product_entity.dart';
import 'package:shopping_app/feature/home/domain/usecases/get_categories_usecase.dart';
import 'package:shopping_app/feature/home/presentation/cubit/home_state.dart';
class HomeCubit extends Cubit<HomeState> {
  final GetCategoriesUseCase getCategoriesUseCase;

  HomeCubit(this.getCategoriesUseCase) : super(HomeInitial());

  List<CategoryEntity> categories = [];
  List<ProductEntity> products = [];

  Future<void> getCategories() async {
    emit(HomeLoading());

    final result = await getCategoriesUseCase();

    if (result is Success<List<CategoryEntity>>) {
      categories = result.data;
      emit(HomeSuccess(categories: categories, products: products));
    }
  }
}
