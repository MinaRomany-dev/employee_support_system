import 'package:employee_support_system/core/error/exception_handler.dart';
import 'package:employee_support_system/features/auth/data/datasource/auth_datasource.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: AuthDatasource)
class SupabaseAuth implements AuthDatasource {
  final SupabaseClient client;
  const SupabaseAuth(this.client);

  @override
  Future<void> login(String email, String password) async {
    try {
      await client.auth.signInWithPassword(email: email, password: password);
    } catch (e) {
      throw handleException(e);
    }
  }

  @override
  Future<void> register(
    String name,
    String role,
    String email,
    String password,
  ) async {
    try {
      final res = await client.auth.signUp(
        data: {'name': name, 'role': role},
        email: email,
        password: password,
      );
      await client.from("users").insert({
        "id": res.user!.id,
        "name": name,
        "email": email,
        "role": role,
      });
    } catch (e) {
      throw handleException(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await client.auth.signOut();
    } catch (e) {
      throw handleException(e);
    }
  }
}
