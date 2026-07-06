import 'package:dartz/dartz.dart';
import 'package:employee_support_system/core/error/failure.dart';

abstract class AuthRepo {
  Future<Either<AppFailure, void>> login(String email, String password);
  Future<Either<AppFailure, void>> register(
    String name,
    String role,
    String email,
    String password,
  );
  Future<Either<AppFailure, void>> logout();
}
