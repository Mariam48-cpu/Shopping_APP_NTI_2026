import 'package:injectable/injectable.dart';
import 'package:shopping_app/feature/favorite/domain/entities/favorite_entity.dart';
import 'package:shopping_app/feature/favorite/domain/repo/favorite_data_source_interface.dart';
import 'package:shopping_app/feature/favorite/domain/repo/favorite_repo_interface.dart';
import '../../../../core/network/result_api.dart';

@Injectable(as: FavoriteRepoInterface)
class FavoriteRepoImp implements FavoriteRepoInterface {
  final FavoriteDataSourceInterface favoriteDataSource;

  FavoriteRepoImp({required this.favoriteDataSource});

  @override
  Future<ResultApi<FavoriteEntity>> getFavorite() async {
    return await favoriteDataSource.getFavorite();
  }

  @override
  Future<ResultApi<String>> addFavorite({required String productId}) async {
    return await favoriteDataSource.addFavorite(productId: productId);
  }

  @override
  Future<ResultApi<String>> deleteFavorite({required String productId}) async {
    return await favoriteDataSource.deleteFavorite(productId: productId);
  }
}
