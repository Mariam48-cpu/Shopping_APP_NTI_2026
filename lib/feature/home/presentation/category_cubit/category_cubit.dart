import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/home/domain/entities/category_entity.dart';
import 'package:shopping_app/feature/home/presentation/category_cubit/category_state.dart';
import '../../domain/use_cases/get_categories_use_case.dart';
@injectable
class CategoryCubit extends Cubit<CategoryState> {
  final GetCategoriesUseCase getCategoriesUseCase;

  CategoryCubit(this.getCategoriesUseCase)
      : super(CategoryInitial());

  CategoryEntity categories = const CategoryEntity();

  Future<void> getCategories() async {
    emit(CategoryLoading());

    final result = await getCategoriesUseCase();

    if (result is Success<CategoryEntity>) {
      categories = result.data!;
      emit(CategorySuccess(categories: categories));
    } else if (result is Error<CategoryEntity>) {
      emit(
        CategoryError(
          message: result.messageError ?? 'Something went wrong',
        ),
      );
    }
  }
}
