import 'package:dartz/dartz.dart';
import 'package:employee_support_system/core/error/failure.dart';
import 'package:employee_support_system/features/auth/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';
@singleton
class LogoutUsecase {
  final AuthRepo authRepo;
  LogoutUsecase(this.authRepo);

  Future<Either<AppFailure, void>> call() async {
    return await authRepo.logout();
  }
}
