import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';

import 'package:shopping_app/feature/favorite/domain/repo/favorite_repo_interface.dart';

@injectable
class DeleteFavoriteUseCase {
  final FavoriteRepoInterface _repo;
  DeleteFavoriteUseCase(this._repo);

  Future<ResultApi<String>> invoke(int productId) async =>
      await _repo.deleteFavorite(productId: productId.toString());
}
