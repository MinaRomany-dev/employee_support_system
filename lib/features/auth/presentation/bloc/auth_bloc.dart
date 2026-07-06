import 'package:bloc/bloc.dart';
import 'package:employee_support_system/features/auth/domain/use_cases/login_usecase.dart';
import 'package:employee_support_system/features/auth/domain/use_cases/logout_usecase.dart';
import 'package:employee_support_system/features/auth/domain/use_cases/register_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final LogoutUsecase logoutUsecase;
  AuthBloc(this.loginUsecase, this.registerUsecase, this.logoutUsecase)
    : super(AuthInitial()) { 
    on<LoginEvent>((event, emit) async {
      emit(LoginLoading());
      final result = await loginUsecase(event.email, event.password);
      result.fold(
        (failure) => emit(LoginFailure(failure.message)),
        (_) => emit(LoginSuccess()),
      );
    });

    on<RegisterEvent>((event, emit) async {
      emit(RegisterLoading());
      final result = await registerUsecase(
        event.name,
        event.role,
        event.email,
        event.password,
      );
      result.fold(
        (failure) => emit(RegisterFailure(failure.message)),
        (_) => emit(RegisterSuccess()),
      );
    });

    on<LogoutEvent>((event, emit) async {
      final result = await logoutUsecase();
      result.fold(
        (failure) => emit(LoginFailure(failure.message)),
        (_) => emit(LogoutSuccess()),
      );
    });
  }
}
