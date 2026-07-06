part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {}

final class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

final class LoginLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

final class LoginSuccess extends AuthState {
  @override
  List<Object?> get props => [];
}

final class LoginFailure extends AuthState {
  final String message;
  LoginFailure(this.message);

  @override
  List<Object?> get props => [message];
}

final class RegisterLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

final class RegisterSuccess extends AuthState {
  @override
  List<Object?> get props => [];
}

final class RegisterFailure extends AuthState {
  final String message;
  RegisterFailure(this.message);

  @override
  List<Object?> get props => [message];
}

final class LogoutSuccess extends AuthState {
  @override
  List<Object?> get props => [];
}
