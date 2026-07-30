// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shopping_app/feature/auth/data/repo/auth_data_source_imp.dart'
    as _i733;
import 'package:shopping_app/feature/auth/data/repo/auth_repo_imp.dart'
    as _i1033;
import 'package:shopping_app/feature/auth/domain/repo/auth_data_source_interface.dart'
    as _i680;
import 'package:shopping_app/feature/auth/domain/repo/auth_repo_interface.dart'
    as _i157;
import 'package:shopping_app/feature/auth/domain/use_case/register_use_case.dart'
    as _i921;
import 'package:shopping_app/feature/auth/presentation/view_model/register_cubit.dart'
    as _i320;
import 'package:shopping_app/feature/cart/data/repo/cart_data_source_impl.dart'
    as _i398;
import 'package:shopping_app/feature/cart/data/repo/cart_repo_imp.dart'
    as _i360;
import 'package:shopping_app/feature/cart/domain/repo/cart_data_source_interface.dart'
    as _i108;
import 'package:shopping_app/feature/cart/domain/repo/cart_repo_interface.dart'
    as _i313;
import 'package:shopping_app/feature/cart/domain/use_case/add_to_cart_use_case.dart'
    as _i439;
import 'package:shopping_app/feature/cart/domain/use_case/delete_cart_use_case.dart'
    as _i778;
import 'package:shopping_app/feature/cart/domain/use_case/get_cart_use_case.dart'
    as _i949;
import 'package:shopping_app/feature/cart/presentation/view_model/cubit/cart_cubit.dart'
    as _i706;
import 'package:shopping_app/feature/category/data/data_sources/category_data_source_imp.dart'
    as _i572;
import 'package:shopping_app/feature/category/data/data_sources/category_data_source_interface.dart'
    as _i824;
import 'package:shopping_app/feature/category/data/data_sources/product_details_remote_data_source_imp.dart'
    as _i828;
import 'package:shopping_app/feature/category/data/data_sources/product_details_remote_data_source_interface.dart'
    as _i907;
import 'package:shopping_app/feature/category/data/repo/category_repo_imp.dart'
    as _i59;
import 'package:shopping_app/feature/category/data/repo/product_details_repo_imp.dart'
    as _i358;
import 'package:shopping_app/feature/category/domain/repo/category_repo_interface.dart'
    as _i125;
import 'package:shopping_app/feature/category/domain/repo/product_details_repo_interface.dart'
    as _i167;
import 'package:shopping_app/feature/category/domain/use_case/get_all_products_by_category_use_case.dart'
    as _i577;
import 'package:shopping_app/feature/category/domain/use_case/get_product_details_use_case.dart'
    as _i905;
import 'package:shopping_app/feature/category/domain/use_case/products_by_search_use_case.dart'
    as _i313;
import 'package:shopping_app/feature/category/view_model/category_products_cubit.dart'
    as _i409;
import 'package:shopping_app/feature/category/view_model/product_cubit.dart'
    as _i440;
import 'package:shopping_app/feature/category/view_model/products_search_cubit.dart'
    as _i131;
import 'package:shopping_app/feature/favorite/data/repo/favorite_data_source_imp.dart'
    as _i231;
import 'package:shopping_app/feature/favorite/data/repo/favorite_repo_imp.dart'
    as _i893;
import 'package:shopping_app/feature/favorite/domain/repo/favorite_data_source_interface.dart'
    as _i55;
import 'package:shopping_app/feature/favorite/domain/repo/favorite_repo_interface.dart'
    as _i871;
import 'package:shopping_app/feature/favorite/domain/use_case/add_favorite_use_case.dart'
    as _i188;
import 'package:shopping_app/feature/favorite/domain/use_case/delete_favorite_use_case.dart'
    as _i852;
import 'package:shopping_app/feature/favorite/domain/use_case/get_favorite_use_case.dart'
    as _i208;
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_cubit.dart'
    as _i417;
import 'package:shopping_app/feature/home/data/repo/home_data_source_imp.dart'
    as _i196;
import 'package:shopping_app/feature/home/data/repo/home_repo_imp.dart'
    as _i507;
import 'package:shopping_app/feature/home/domain/repo/home_remote_data_source_interface.dart'
    as _i756;
import 'package:shopping_app/feature/home/domain/repo/home_repository_interface.dart'
    as _i355;
import 'package:shopping_app/feature/home/domain/use_case/get_categories_use_case.dart'
    as _i644;
import 'package:shopping_app/feature/home/domain/use_case/get_categories_usecase.dart'
    as _i1067;
import 'package:shopping_app/feature/home/domain/use_case/get_products_use_case.dart'
    as _i988;
import 'package:shopping_app/feature/home/domain/use_case/get_products_usecase.dart'
    as _i1056;
import 'package:shopping_app/feature/home/presentation/view_model/category_cubit/category_cubit.dart'
    as _i833;
import 'package:shopping_app/feature/home/presentation/view_model/product_cubit/product_cubit.dart'
    as _i925;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i108.CartDataSourceInterface>(
      () => _i398.CartRemoteDataSourceImpl(),
    );
    gh.factory<_i680.AuthDataSourceInterface>(() => _i733.AuthDataSourceImp());
    gh.factory<_i907.ProductDetailsRemoteDataSourceInterface>(
      () => _i828.ProductDetailsRemoteDataSourceImp(),
    );
    gh.factory<_i157.AuthRepoInterface>(
      () => _i1033.AuthRepoImp(gh<_i680.AuthDataSourceInterface>()),
    );
    gh.factory<_i824.CategoryRemoteDataSourceInterface>(
      () => _i572.CategoryRemoteDataSourceImpl(),
    );
    gh.factory<_i55.FavoriteDataSourceInterface>(
      () => _i231.FavoriteDataSourceImp(),
    );
    gh.lazySingleton<_i313.CartRepositoryInterface>(
      () => _i360.CartRepositoryImpl(gh<_i108.CartDataSourceInterface>()),
    );
    gh.factory<_i921.RegisterUseCase>(
      () => _i921.RegisterUseCase(gh<_i157.AuthRepoInterface>()),
    );
    gh.factory<_i756.HomeRemoteDataSourceInterface>(
      () => _i196.HomeRemoteDataSourceImpl(),
    );
    gh.factory<_i125.CategoryRepoInterface>(
      () => _i59.CategoryRepoImp(gh<_i824.CategoryRemoteDataSourceInterface>()),
    );
    gh.factory<_i167.ProductDetailsRepoInterface>(
      () => _i358.ProductDetailsRepoImp(
        gh<_i907.ProductDetailsRemoteDataSourceInterface>(),
      ),
    );
    gh.factory<_i439.AddToCartUseCase>(
      () => _i439.AddToCartUseCase(gh<_i313.CartRepositoryInterface>()),
    );
    gh.factory<_i778.DeleteCartUseCase>(
      () => _i778.DeleteCartUseCase(gh<_i313.CartRepositoryInterface>()),
    );
    gh.factory<_i949.GetCartUseCase>(
      () => _i949.GetCartUseCase(gh<_i313.CartRepositoryInterface>()),
    );
    gh.factory<_i320.RegisterCubit>(
      () => _i320.RegisterCubit(gh<_i921.RegisterUseCase>()),
    );
    gh.factory<_i706.CartCubit>(
      () => _i706.CartCubit(
        getCartUseCase: gh<_i949.GetCartUseCase>(),
        addToCartUseCase: gh<_i439.AddToCartUseCase>(),
        deleteCartUseCase: gh<_i778.DeleteCartUseCase>(),
      ),
    );
    gh.factory<_i905.GetProductDetailsUseCase>(
      () => _i905.GetProductDetailsUseCase(
        gh<_i167.ProductDetailsRepoInterface>(),
      ),
    );
    gh.factory<_i440.ProductCubit>(
      () => _i440.ProductCubit(gh<_i905.GetProductDetailsUseCase>()),
    );
    gh.factory<_i577.GetAllProductsByCategoryUseCase>(
      () => _i577.GetAllProductsByCategoryUseCase(
        gh<_i125.CategoryRepoInterface>(),
      ),
    );
    gh.factory<_i313.ProductsBySearchUseCase>(
      () => _i313.ProductsBySearchUseCase(gh<_i125.CategoryRepoInterface>()),
    );
    gh.factory<_i355.HomeRepository>(
      () => _i507.HomeRepositoryImpl(
        remoteDataSource: gh<_i756.HomeRemoteDataSourceInterface>(),
      ),
    );
    gh.factory<_i871.FavoriteRepoInterface>(
      () => _i893.FavoriteRepoImp(
        favoriteDataSource: gh<_i55.FavoriteDataSourceInterface>(),
      ),
    );
    gh.factory<_i644.GetCategoriesUseCase>(
      () => _i644.GetCategoriesUseCase(gh<_i355.HomeRepository>()),
    );
    gh.factory<_i1067.GetCategoriesUseCase>(
      () => _i1067.GetCategoriesUseCase(gh<_i355.HomeRepository>()),
    );
    gh.factory<_i988.GetProductsUseCase>(
      () => _i988.GetProductsUseCase(gh<_i355.HomeRepository>()),
    );
    gh.factory<_i1056.GetProductsUseCase>(
      () => _i1056.GetProductsUseCase(gh<_i355.HomeRepository>()),
    );
    gh.factory<_i188.AddFavoriteUseCase>(
      () => _i188.AddFavoriteUseCase(gh<_i871.FavoriteRepoInterface>()),
    );
    gh.factory<_i852.DeleteFavoriteUseCase>(
      () => _i852.DeleteFavoriteUseCase(gh<_i871.FavoriteRepoInterface>()),
    );
    gh.factory<_i208.GetFavoriteUseCase>(
      () => _i208.GetFavoriteUseCase(gh<_i871.FavoriteRepoInterface>()),
    );
    gh.factory<_i409.ProductsByCategoryCubit>(
      () => _i409.ProductsByCategoryCubit(
        gh<_i577.GetAllProductsByCategoryUseCase>(),
      ),
    );
    gh.factory<_i417.FavoriteCubit>(
      () => _i417.FavoriteCubit(
        gh<_i208.GetFavoriteUseCase>(),
        gh<_i188.AddFavoriteUseCase>(),
        gh<_i852.DeleteFavoriteUseCase>(),
      ),
    );
    gh.factory<_i131.ProductSearchCubit>(
      () => _i131.ProductSearchCubit(gh<_i313.ProductsBySearchUseCase>()),
    );
    gh.factory<_i833.CategoryCubit>(
      () => _i833.CategoryCubit(gh<_i644.GetCategoriesUseCase>()),
    );
    gh.factory<_i925.ProductCubit>(
      () => _i925.ProductCubit(gh<_i988.GetProductsUseCase>()),
    );
    return this;
  }
}
