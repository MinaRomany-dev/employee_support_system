import 'package:employee_support_system/features/auth/data/models/user_model.dart';

abstract class AuthDatasource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(
    String name,
    String role,
    String email,
    String password,
  );
  Future<void> logout();
  Future<void> signInWithGoogle();
}
