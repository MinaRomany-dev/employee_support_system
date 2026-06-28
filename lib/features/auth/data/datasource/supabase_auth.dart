import 'package:employee_support_system/features/auth/data/datasource/auth_datasource.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@lazySingleton
class SupabaseAuth implements AuthDatasource {
  final SupabaseClient client;
  SupabaseAuth(this.client);

  @override
  Future<void> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> register(String email, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
