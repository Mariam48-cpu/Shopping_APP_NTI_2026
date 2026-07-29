import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/favorite/domain/entities/favorite_entity.dart';
import 'package:shopping_app/feature/favorite/domain/repo/favorite_repo_interface.dart';

@injectable
class GetFavoriteUseCase {
  FavoriteRepoInterface favoriteRepoInterface;
  GetFavoriteUseCase(this.favoriteRepoInterface);
  Future<ResultApi<FavoriteEntity>> invoke() async =>
      await favoriteRepoInterface.getFavorite();
}
