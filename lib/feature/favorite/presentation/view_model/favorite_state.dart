import 'package:shopping_app/feature/favorite/domain/entities/favorite_entity.dart';

sealed class FavoriteStates {}

class FavoriteIntialState extends FavoriteStates {}

class FavoriteLoadingState extends FavoriteStates {}

class FavoriteSuccessState extends FavoriteStates {
  final FavoriteEntity? favorites;

  FavoriteSuccessState(this.favorites);
}

class FavoriteErrorState extends FavoriteStates {
  final String? error;

  FavoriteErrorState(this.error);
}
