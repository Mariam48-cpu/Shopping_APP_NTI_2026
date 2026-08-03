import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/favorite/domain/entities/favorite_entity.dart';

abstract class FavoriteRepoInterface {
  Future<ResultApi<FavoriteEntity>> getFavorite();

  Future<ResultApi<String>> addFavorite({required String productId});

  Future<ResultApi<String>> deleteFavorite({required String productId});
}
