import 'package:dartz/dartz.dart';
import 'package:employee_support_system/core/error/exception.dart';
import 'package:employee_support_system/core/error/failure.dart';
import 'package:employee_support_system/core/error/failure_handler.dart';
import 'package:employee_support_system/features/auth/data/datasource/auth_datasource.dart';
import 'package:employee_support_system/features/auth/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepo)
class AuthRepositoryImpl extends AuthRepo {
  final AuthDatasource authDatasource;

  AuthRepositoryImpl(this.authDatasource);

  @override
  Future<Either<AppFailure, void>> login(String email, String password) async {
    try {
      await authDatasource.login(email, password);
      return Right(null);
    } on AppException catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<AppFailure, void>> logout() async {
    try {
      await authDatasource.logout();
      return Right(null);
    } on AppException catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<AppFailure, void>> register(
    String name,
    String role,
    String email,
    String password,
  ) async {
    try {
      await authDatasource.register(name, role, email, password);
      return Right(null);
    } on AppException catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
