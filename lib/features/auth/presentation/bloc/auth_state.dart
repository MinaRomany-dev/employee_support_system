part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

final class LoginLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

final class LoginSuccess extends AuthState {
  final UserEntity user;
  LoginSuccess(this.user);
  @override
  List<Object?> get props => [user];
}

final class LoginFailure extends AuthState {
  final String message;
  const LoginFailure(this.message);

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
  const RegisterFailure(this.message);

  @override
  List<Object?> get props => [message];
}

final class LogoutSuccess extends AuthState {
  @override
  List<Object?> get props => [];
}

final class LogoutFailure extends AuthState {
  final String message;
  const LogoutFailure(this.message);
  @override
  List<Object?> get props => [];
}

final class SignInWithGoogleSuccess extends AuthState {
  @override
  List<Object?> get props => [];
}

final class SignInWithGoogleFailure extends AuthState {
  final String message;
  SignInWithGoogleFailure(this.message);

  @override
  List<Object?> get props => [message];
}
