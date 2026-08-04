import 'package:bloc/bloc.dart';
import 'package:employee_support_system/features/auth/domain/entities/uset_entity.dart';
import 'package:employee_support_system/features/auth/domain/use_cases/get_user_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  final GetUserUsecase getUserUsecase;

  SplashCubit(this.getUserUsecase) : super(SplashInitial());

  Future<void> checkAuthStatus() async {
    final session = Supabase.instance.client.auth.currentSession;

    if (session != null) {
      final user = await getUserUsecase();
      emit(Authenticated(user!));
    } else {
      emit(Unauthenticated());
    }
  }
}
