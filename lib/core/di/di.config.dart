// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:employee_support_system/core/di/register_module.dart' as _i93;
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
import 'package:employee_support_system/features/auth/domain/use_cases/sign_in_withgoogle.dart'
    as _i315;
import 'package:employee_support_system/features/auth/presentation/bloc/auth_bloc.dart'
    as _i313;
import 'package:employee_support_system/features/comment/data/datasource/Comment_remote_datasource_impl.dart'
    as _i654;
import 'package:employee_support_system/features/comment/data/datasource/CommentRemoteDatasource.dart'
    as _i629;
import 'package:employee_support_system/features/comment/data/repositories/comment_repository_impl.dart'
    as _i126;
import 'package:employee_support_system/features/comment/domain/repo/comment_repo.dart'
    as _i25;
import 'package:employee_support_system/features/comment/domain/usecases/add_comment_usecase.dart'
    as _i887;
import 'package:employee_support_system/features/comment/domain/usecases/get_comment_usecase.dart'
    as _i242;
import 'package:employee_support_system/features/comment/presentation/bloc/comment_bloc.dart'
    as _i939;
import 'package:employee_support_system/features/employees/data/datasource/ticket_remote_data_source_impl.dart'
    as _i826;
import 'package:employee_support_system/features/employees/data/datasource/ticket_remote_datasource.dart'
    as _i887;
import 'package:employee_support_system/features/employees/data/repositories/ticket_repository_impl.dart'
    as _i231;
import 'package:employee_support_system/features/employees/domain/repo/tickets_repo.dart'
    as _i77;
import 'package:employee_support_system/features/employees/domain/usecases/create_ticket_usecase.dart'
    as _i695;
import 'package:employee_support_system/features/employees/domain/usecases/get_user_tickets_usecase.dart'
    as _i578;
import 'package:employee_support_system/features/employees/presentation/bloc/ticket_bloc.dart'
    as _i1027;
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
    gh.lazySingleton<_i887.TicketRemoteDatasource>(
      () => _i826.TicketRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i1018.AuthDatasource>(
      () => _i897.SupabaseAuth(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i629.Commentremotedatasource>(
      () => _i654.CommentRemoteDatasourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i77.TicketRepository>(
      () => _i231.TicketRepositoryImpl(gh<_i887.TicketRemoteDatasource>()),
    );
    gh.lazySingleton<_i25.CommentRepository>(
      () => _i126.CommentRepositoryImpl(gh<_i629.Commentremotedatasource>()),
    );
    gh.lazySingleton<_i885.AuthRepo>(
      () => _i16.AuthRepositoryImpl(gh<_i1018.AuthDatasource>()),
    );
    gh.lazySingleton<_i887.AddCommentUsecase>(
      () => _i887.AddCommentUsecase(gh<_i25.CommentRepository>()),
    );
    gh.lazySingleton<_i242.GetCommentUsecase>(
      () => _i242.GetCommentUsecase(gh<_i25.CommentRepository>()),
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
    gh.singleton<_i315.SignInWithgoogle>(
      () => _i315.SignInWithgoogle(gh<_i885.AuthRepo>()),
    );
    gh.lazySingleton<_i578.GetUserTicketsUsecase>(
      () => _i578.GetUserTicketsUsecase(gh<_i77.TicketRepository>()),
    );
    gh.singleton<_i695.CreateTicketUseCase>(
      () => _i695.CreateTicketUseCase(gh<_i77.TicketRepository>()),
    );
    gh.factory<_i313.AuthBloc>(
      () => _i313.AuthBloc(
        gh<_i150.LoginUsecase>(),
        gh<_i700.RegisterUsecase>(),
        gh<_i495.LogoutUsecase>(),
        gh<_i315.SignInWithgoogle>(),
      ),
    );
    gh.factory<_i939.CommentBloc>(
      () => _i939.CommentBloc(
        gh<_i887.AddCommentUsecase>(),
        gh<_i242.GetCommentUsecase>(),
      ),
    );
    gh.factory<_i1027.TicketBloc>(
      () => _i1027.TicketBloc(
        gh<_i695.CreateTicketUseCase>(),
        gh<_i578.GetUserTicketsUsecase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i93.RegisterModule {}
