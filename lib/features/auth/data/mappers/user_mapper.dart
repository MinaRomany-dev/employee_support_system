import 'package:employee_support_system/features/auth/data/models/user_model.dart';
import 'package:employee_support_system/features/auth/domain/entities/uset_entity.dart';

extension UserMapper on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      name: name,
      email: email,
      role: role.name,
      profileImageUrl: profileImageUrl,
    );
  }
}
