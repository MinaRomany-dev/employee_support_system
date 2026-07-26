import 'package:dartz/dartz.dart';
import 'package:employee_support_system/core/error/failure.dart';
import 'package:employee_support_system/features/auth/domain/entities/uset_entity.dart';
import 'package:employee_support_system/features/auth/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@singleton
class RegisterUsecase {
  final AuthRepo authRepo;
  RegisterUsecase(this.authRepo);

  Future<Either<AppFailure, UserEntity>> call(
    String name,
    String role,
    String email,
    String password,
  ) async {
    return await authRepo.register(name, role, email, password);
  }
}
