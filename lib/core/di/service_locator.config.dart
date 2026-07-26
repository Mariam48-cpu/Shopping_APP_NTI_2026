import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shopping_app/feature/home/data/data_sources/home_remote_data_source_impl.dart'
    as _i8;
import 'package:shopping_app/feature/home/data/repositories/home_repository_impl.dart'
    as _i302;
import 'package:shopping_app/feature/home/domain/repositories/home_remote_data_source_interface.dart'
    as _i394;
import 'package:shopping_app/feature/home/domain/repositories/home_repository_interface.dart'
    as _i863;
import 'package:shopping_app/feature/home/domain/usecases/get_categories_usecase.dart'
    as _i10;
import 'package:shopping_app/feature/home/domain/usecases/get_products_usecase.dart'
    as _i153;
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
    gh.lazySingleton<_i394.HomeRemoteDataSourceInterface>(
      () => _i8.HomeRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i863.HomeRepository>(
      () => _i302.HomeRepositoryImpl(
        remoteDataSource: gh<_i394.HomeRemoteDataSourceInterface>(),
      ),
    );
    gh.factory<_i10.GetCategoriesUseCase>(
      () => _i10.GetCategoriesUseCase(gh<_i863.HomeRepository>()),
    );
    gh.factory<_i153.GetProductsUseCase>(
      () => _i153.GetProductsUseCase(gh<_i863.HomeRepository>()),
    );
    gh.factory<_i93.ProductCubit>(
      () => _i93.ProductCubit(gh<_i153.GetProductsUseCase>()),
    );
    gh.factory<_i513.CategoryCubit>(
      () => _i513.CategoryCubit(gh<_i10.GetCategoriesUseCase>()),
    );
    return this;
  }
}
