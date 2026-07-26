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
import 'package:shopping_app/feature/category/data/repo/data_source/category_remote_data_source_imp.dart'
    as _i334;
import 'package:shopping_app/feature/category/data/repo/data_source/category_remote_data_source_interface.dart'
    as _i721;
import 'package:shopping_app/feature/category/data/repo/repo/category_repo_imp.dart'
    as _i79;
import 'package:shopping_app/feature/category/data/repo/repo/category_repo_interface.dart'
    as _i726;
import 'package:shopping_app/feature/category/view_model/category_products_cubit.dart'
    as _i409;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i721.CategoryRemoteDataSourceInterface>(
      () => _i334.CategoryRemoteDataSourceImpl(),
    );
    gh.factory<_i726.CategoryRepoInterface>(
      () => _i79.CategoryRepoImp(gh<_i721.CategoryRemoteDataSourceInterface>()),
    );
    gh.factory<_i409.ProductsByCategoryCubit>(
      () => _i409.ProductsByCategoryCubit(gh<_i726.CategoryRepoInterface>()),
    );
    return this;
  }
}
