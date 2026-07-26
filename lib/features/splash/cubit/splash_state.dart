part of 'splash_cubit.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

final class SplashInitial extends SplashState {}

class Authenticated extends SplashState {
  final UserEntity user;

  const Authenticated(this.user);

  @override
  List<Object> get props => [user];
}
class Unauthenticated extends SplashState {}