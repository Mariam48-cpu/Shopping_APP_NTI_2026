import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/favorite/domain/repo/favorite_repo_interface.dart';

@injectable
class AddFavoriteUseCase {
  final FavoriteRepoInterface _repo;
  AddFavoriteUseCase(this._repo);

  Future<ResultApi<String>> invoke(int productId) async =>
      await _repo.addFavorite(productId: productId.toString());
}
