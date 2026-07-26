import 'package:employee_support_system/features/auth/domain/entities/uset_entity.dart';
import 'package:employee_support_system/features/auth/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetUserUsecase {
  final AuthRepo authRepo;
  GetUserUsecase(this.authRepo);

  Future<UserEntity?> call() async {
    return await authRepo.getCachedUser();
  }
}
