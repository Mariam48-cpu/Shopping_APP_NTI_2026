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
import 'package:shopping_app/feature/category/data/data_sources/category_data_source_imp.dart'
    as _i572;
import 'package:shopping_app/feature/category/data/data_sources/category_data_source_interface.dart'
    as _i824;
import 'package:shopping_app/feature/category/data/repo/category_repo_imp.dart'
    as _i59;
import 'package:shopping_app/feature/category/domain/repo/category_repo_interface.dart'
    as _i125;
import 'package:shopping_app/feature/category/domain/use_case/get_all_products_by_category_use_case.dart'
    as _i577;
import 'package:shopping_app/feature/category/domain/use_case/products_by_search_use_case.dart'
    as _i313;
import 'package:shopping_app/feature/category/view_model/category_products_cubit.dart'
    as _i409;
import 'package:shopping_app/feature/category/view_model/products_search_cubit.dart'
    as _i131;
import 'package:shopping_app/feature/home/data/data_sources/home_remote_data_source_impl.dart'
    as _i525;
import 'package:shopping_app/feature/home/data/repositories/home_repository_impl.dart'
    as _i302;
import 'package:shopping_app/feature/home/domain/repositories/home_remote_data_source_interface.dart'
    as _i394;
import 'package:shopping_app/feature/home/domain/repositories/home_repository_interface.dart'
    as _i863;
import 'package:shopping_app/feature/home/domain/use_cases/get_categories_use_case.dart'
    as _i116;
import 'package:shopping_app/feature/home/domain/use_cases/get_products_use_case.dart'
    as _i740;
import 'package:shopping_app/feature/home/presentation/category_cubit/category_cubit.dart'
    as _i513;
import 'package:shopping_app/feature/home/presentation/product_cubit/product_cubit.dart'
    as _i93;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i394.HomeRemoteDataSourceInterface>(
      () => _i525.HomeRemoteDataSourceImpl(),
    );
    gh.factory<_i824.CategoryRemoteDataSourceInterface>(
      () => _i572.CategoryRemoteDataSourceImpl(),
    );
    gh.factory<_i125.CategoryRepoInterface>(
      () => _i59.CategoryRepoImp(gh<_i824.CategoryRemoteDataSourceInterface>()),
    );
    gh.lazySingleton<_i863.HomeRepository>(
      () => _i302.HomeRepositoryImpl(
        remoteDataSource: gh<_i394.HomeRemoteDataSourceInterface>(),
      ),
    );
    gh.factory<_i116.GetCategoriesUseCase>(
      () => _i116.GetCategoriesUseCase(gh<_i863.HomeRepository>()),
    );
    gh.factory<_i740.GetProductsUseCase>(
      () => _i740.GetProductsUseCase(gh<_i863.HomeRepository>()),
    );
    gh.factory<_i577.GetAllProductsByCategoryUseCase>(
      () => _i577.GetAllProductsByCategoryUseCase(
        gh<_i125.CategoryRepoInterface>(),
      ),
    );
    gh.factory<_i313.ProductsBySearchUseCase>(
      () => _i313.ProductsBySearchUseCase(gh<_i125.CategoryRepoInterface>()),
    );
    gh.factory<_i93.ProductCubit>(
      () => _i93.ProductCubit(gh<_i740.GetProductsUseCase>()),
    );
    gh.factory<_i409.ProductsByCategoryCubit>(
      () => _i409.ProductsByCategoryCubit(
        gh<_i577.GetAllProductsByCategoryUseCase>(),
      ),
    );
    gh.factory<_i131.ProductSearchCubit>(
      () => _i131.ProductSearchCubit(gh<_i313.ProductsBySearchUseCase>()),
    );
    gh.factory<_i513.CategoryCubit>(
      () => _i513.CategoryCubit(gh<_i116.GetCategoriesUseCase>()),
    );
    return this;
  }
}
