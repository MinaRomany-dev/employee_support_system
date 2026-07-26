

import 'package:employee_support_system/features/auth/data/models/user_model.dart';

abstract class AuthLocalDatasource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> clearUser();
}