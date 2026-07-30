import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/favorite/domain/repo/favorite_repo_interface.dart';

@injectable
class AddFavoriteUseCase {
  final FavoriteRepoInterface favoriteRepoInterface ;
  AddFavoriteUseCase(this.favoriteRepoInterface);
  Future<ResultApi<String>> call(int productId) async =>
      await favoriteRepoInterface.addFavorite(productId: productId.toString());
}
