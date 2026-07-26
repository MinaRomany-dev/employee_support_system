part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  LoginEvent(this.email, this.password);
}
class AppStarted extends AuthEvent {}
class RegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String role;
  RegisterEvent(this.name, this.email, this.password, this.role);
}

class LogoutEvent extends AuthEvent {}

class GoogleSignInEvent extends AuthEvent {}
class CachedUserEvent extends AuthEvent {}