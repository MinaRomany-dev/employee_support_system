import 'dart:convert';

import 'package:employee_support_system/features/auth/data/datasource/auth_loca_datasource.dart';
import 'package:employee_support_system/features/auth/data/models/user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: AuthLocalDatasource)
class AuthLocalDatasourceimpl implements AuthLocalDatasource {
  static const String userKey = 'cached_user';
  @override
  Future<void> cacheUser(UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(userKey, jsonEncode(user.toJson()));
  }

  @override
  Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    final json = prefs.getString(userKey);

    if (json == null) return null;
    Map<String, dynamic> result = jsonDecode(json);
    return UserModel.fromJson(result);
  }

  @override
  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(userKey);
  }
}
