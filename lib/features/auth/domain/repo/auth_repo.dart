import 'package:dartz/dartz.dart';
import 'package:employee_support_system/core/error/failure.dart';
import 'package:employee_support_system/features/auth/domain/entities/uset_entity.dart';

abstract class AuthRepo {
  Future<Either<AppFailure, UserEntity>> login(String email, String password);
  Future<Either<AppFailure, void>> register(
    String name,
    String role,
    String email,
    String password,
  );
  Future<Either<AppFailure, void>> logout();
  Future<Either<AppFailure, void>> signInWithGoogle();
}
