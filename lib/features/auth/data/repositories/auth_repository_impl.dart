import 'package:dartz/dartz.dart';
import 'package:employee_support_system/core/error/exception.dart';
import 'package:employee_support_system/core/error/failure.dart';
import 'package:employee_support_system/core/error/failure_handler.dart';
import 'package:employee_support_system/features/auth/data/datasource/auth_datasource.dart';
import 'package:employee_support_system/features/auth/data/datasource/auth_loca_datasource.dart';
import 'package:employee_support_system/features/auth/data/mappers/user_mapper.dart';
import 'package:employee_support_system/features/auth/domain/entities/uset_entity.dart';
import 'package:employee_support_system/features/auth/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepo)
class AuthRepositoryImpl extends AuthRepo {
  final AuthDatasource authDatasource;
  final AuthLocalDatasource authLocalDatasource;
  AuthRepositoryImpl(this.authDatasource, this.authLocalDatasource);

  @override
  Future<Either<AppFailure, UserEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final user = await authDatasource.login(email, password);
      return Right(user.toEntity());
    } on AppException catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<AppFailure, void>> logout() async {
    try {
      await authDatasource.logout();
      await authLocalDatasource.clearUser();
      return Right(null);
    } on AppException catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<AppFailure, UserEntity>> register(
    String name,
    String role,
    String email,
    String password,
  ) async {
    try {
      final user = await authDatasource.register(name, role, email, password);
      await authLocalDatasource.cacheUser(user);
      return Right(user.toEntity());
    } on AppException catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<AppFailure, void>> signInWithGoogle() async {
    try {
      await authDatasource.signInWithGoogle();
      return Right(null);
    } on AppException catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<UserEntity?> getCachedUser() async {
    final user = await authLocalDatasource.getUser();
    return user?.toEntity();
  }
}
