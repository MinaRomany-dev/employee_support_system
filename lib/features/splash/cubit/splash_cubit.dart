import 'package:bloc/bloc.dart';
import 'package:employee_support_system/features/auth/domain/entities/uset_entity.dart';
import 'package:employee_support_system/features/auth/domain/use_cases/get_user_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  final GetUserUsecase getUserUsecase;

  SplashCubit(this.getUserUsecase) : super(SplashInitial());

  Future<void> checkAuthStatus() async {
    final user = await getUserUsecase.call();
    if (user != null) {
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }
}
