import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/favorite/domain/entities/favorite_entity.dart';
import 'package:shopping_app/feature/favorite/domain/use_case/add_favorite_use_case.dart';
import 'package:shopping_app/feature/favorite/domain/use_case/delete_favorite_use_case.dart';
import 'package:shopping_app/feature/favorite/domain/use_case/get_favorite_use_case.dart';
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_state.dart';

@injectable
class FavoriteCubit extends Cubit<FavoriteStates> {
  FavoriteCubit(
    this.getFavoriteUseCase,
    this.addFavoriteUseCase,
    this.deleteFavoriteUseCase,
  ) : super(FavoriteIntialState());

  final GetFavoriteUseCase getFavoriteUseCase;
  final AddFavoriteUseCase addFavoriteUseCase;
  final DeleteFavoriteUseCase deleteFavoriteUseCase;

  Future<void> getFavorite() async {
    emit(FavoriteLoadingState());
    await fetchAndEmitProduct();
  }

  Future<void> fetchAndEmitProduct() async {
    final result = await getFavoriteUseCase.call();
    switch (result) {
      case Success<FavoriteEntity>():
        if (!isClosed) {
          emit(FavoriteSuccessState(result.data));
        }
        break;
      case Error<FavoriteEntity>():
        emit(FavoriteErrorState(result.messageError));
        break;
    }
  }

  Future<ResultApi<String>> addFavorite(int productId) async {
    final result = await addFavoriteUseCase.call(productId);
    if (result is Success<String>) {
      await fetchAndEmitProduct();
    }
    return result;
  }

  Future<ResultApi<String>> deleteFavorite(int productId) async {
    final result = await deleteFavoriteUseCase.call(productId);
    if (result is Success<String>) {
      await fetchAndEmitProduct();
    }
    return result;
  }

  bool isFavorite(int productId) {
    final favoriteState = state;
    if (favoriteState is FavoriteSuccessState) {
      return favoriteState.favorites!.productList.any(
        (product) => product.id == productId,
      );
    }
    return false;
  }

  Future<ResultApi<String>> toggleFavorite(int productId) async {
    final favorite = isFavorite(productId);
    final result = favorite
        ? await deleteFavoriteUseCase.call(productId)
        : await addFavoriteUseCase.call(productId);
    if (result is Success<String>) {
      await fetchAndEmitProduct();
    }
    return result;
  }
}
