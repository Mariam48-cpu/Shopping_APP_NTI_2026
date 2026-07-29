import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/favorite/domain/entities/favorite_entity.dart';
import 'package:shopping_app/feature/favorite/domain/use_case/add_favorite_use_case.dart';
import 'package:shopping_app/feature/favorite/domain/use_case/delete_favorite_use_case.dart';
import 'package:shopping_app/feature/favorite/domain/use_case/get_favorite_use_case.dart';
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_state.dart';
 //todo edit the names of variables
@injectable
class FavoriteCubit extends Cubit<FavoriteStates> {
  FavoriteCubit(
    this._getFavoriteUseCase,
    this._addFavoriteUseCase,
    this._deleteFavoriteUseCase,
  ) : super(FavoriteIntialState());

  final GetFavoriteUseCase _getFavoriteUseCase;
  final AddFavoriteUseCase _addFavoriteUseCase;
  final DeleteFavoriteUseCase _deleteFavoriteUseCase;

  Future<void> getFavorite() async {
    emit(FavoriteLoadingState());
    await _fetchAndEmit();
  }

Future<void> _fetchAndEmit() async {
  final result = await _getFavoriteUseCase.invoke();

  switch (result) {
    case Success<FavoriteEntity>():
      print("Products after fetch:");
      print(result.data?.productList.map((e) => e.id).toList());

      emit(FavoriteSuccessState(result.data));
      break;

    case Error<FavoriteEntity>():
      emit(FavoriteErrorState(result.messageError));
      break;
  }
}
  Future<ResultApi<String>> addFavorite(int productId) async {
    final result = await _addFavoriteUseCase.invoke(productId);

    if (result is Success<String>) {
      await _fetchAndEmit();
    }
    return result;
  }
  Future<ResultApi<String>> deleteFavorite(int productId) async {
    final result = await _deleteFavoriteUseCase.invoke(productId);
    if (result is Success<String>) {
      await _fetchAndEmit();
    }
    return result;
  }
  bool isFavorite(int productId) {
    final s = state;
    if (s is FavoriteSuccessState) {
      return s.favorites!.productList.any((p) => p.id == productId);
    }
    return false;
  }
  Future<ResultApi<String>> toggleFavorite(int productId) async {
    final currentlyFavorite = isFavorite(productId);

    final result = currentlyFavorite
        ? await _deleteFavoriteUseCase.invoke(productId)
        : await _addFavoriteUseCase.invoke(productId);
    if (result is Success<String>) {
      await _fetchAndEmit();
    }

    return result;
  }
}
