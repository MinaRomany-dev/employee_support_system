import 'package:dartz/dartz.dart';
import 'package:employee_support_system/core/error/failure.dart';
import 'package:employee_support_system/features/auth/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@singleton
class LoginUsecase {
  final AuthRepo authRepo;

  LoginUsecase(this.authRepo);

  Future<Either<AppFailure, void>> call(String email, String password) async {
    return await authRepo.login(email, password);
  }
}
