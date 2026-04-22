// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:demo_list_getx/data/repositories_impl/auth_repository_impl.dart'
    as _i304;
import 'package:demo_list_getx/data/repositories_impl/general_repositoty_impl.dart'
    as _i858;
import 'package:demo_list_getx/data/sources/local/secure_storage.dart' as _i786;
import 'package:demo_list_getx/data/sources/remote/services/auth_service.dart'
    as _i1031;
import 'package:demo_list_getx/data/sources/remote/services/general_service.dart'
    as _i814;
import 'package:demo_list_getx/domain/repositories/auth_repository.dart'
    as _i185;
import 'package:demo_list_getx/domain/repositories/general_repository.dart'
    as _i443;
import 'package:demo_list_getx/domain/usecase/auth/login_usecase.dart' as _i782;
import 'package:demo_list_getx/domain/usecase/category/get_categories_usecase.dart'
    as _i719;
import 'package:demo_list_getx/domain/usecase/product/get_products_usecase.dart'
    as _i408;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i1031.AuthService>(() => _i1031.AuthService());
    gh.singleton<_i814.GeneralService>(() => _i814.GeneralService());
    gh.lazySingleton<_i786.SecureStorage>(() => _i786.SecureStorage());
    gh.lazySingleton<_i185.AuthRepository>(
      () => _i304.AuthRepositoryImpl(gh<_i1031.AuthService>()),
    );
    gh.lazySingleton<_i443.GeneralRepository>(
      () => _i858.GeneralRepositoryImpl(gh<_i814.GeneralService>()),
    );
    gh.factory<_i782.LoginUseCase>(
      () => _i782.LoginUseCase(gh<_i185.AuthRepository>()),
    );
    gh.factory<_i719.GetCategoriesUseCase>(
      () => _i719.GetCategoriesUseCase(gh<_i443.GeneralRepository>()),
    );
    gh.factory<_i408.GetProductsUseCase>(
      () => _i408.GetProductsUseCase(gh<_i443.GeneralRepository>()),
    );
    return this;
  }
}
