// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:employee_support_system/core/di/register_module.dart' as _i611;
import 'package:employee_support_system/features/auth/data/datasource/auth_datasource.dart'
    as _i1018;
import 'package:employee_support_system/features/auth/data/datasource/supabase_auth.dart'
    as _i897;
import 'package:employee_support_system/features/auth/data/repositories/auth_repository_impl.dart'
    as _i16;
import 'package:employee_support_system/features/auth/domain/repo/auth_repo.dart'
    as _i885;
import 'package:employee_support_system/features/auth/domain/use_cases/login_usecase.dart'
    as _i150;
import 'package:employee_support_system/features/auth/domain/use_cases/logout_usecase.dart'
    as _i495;
import 'package:employee_support_system/features/auth/domain/use_cases/register_usecase.dart'
    as _i700;
import 'package:employee_support_system/features/auth/presentation/bloc/auth_bloc.dart'
    as _i313;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i454.SupabaseClient>(() => registerModule.client);
    gh.lazySingleton<_i1018.AuthDatasource>(
      () => _i897.SupabaseAuth(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i885.AuthRepo>(
      () => _i16.AuthRepositoryImpl(gh<_i1018.AuthDatasource>()),
    );
    gh.singleton<_i150.LoginUsecase>(
      () => _i150.LoginUsecase(gh<_i885.AuthRepo>()),
    );
    gh.singleton<_i495.LogoutUsecase>(
      () => _i495.LogoutUsecase(gh<_i885.AuthRepo>()),
    );
    gh.singleton<_i700.RegisterUsecase>(
      () => _i700.RegisterUsecase(gh<_i885.AuthRepo>()),
    );
    gh.factory<_i313.AuthBloc>(
      () => _i313.AuthBloc(
        gh<_i150.LoginUsecase>(),
        gh<_i700.RegisterUsecase>(),
        gh<_i495.LogoutUsecase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i611.RegisterModule {}
