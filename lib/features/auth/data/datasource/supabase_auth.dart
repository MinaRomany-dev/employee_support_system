import 'package:employee_support_system/core/error/exception_handler.dart';
import 'package:employee_support_system/features/auth/data/datasource/auth_datasource.dart';
import 'package:employee_support_system/features/auth/data/models/user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: AuthDatasource)
class SupabaseAuth implements AuthDatasource {
  final SupabaseClient client;
  const SupabaseAuth(this.client);

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;

      if (user == null) {
        throw Exception("User not found");
      }

      final data = await client
          .from('users')
          .select()
          .eq('id', user.id)
          .single();

      return UserModel.fromJson(data);
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
      final user = await client.auth.signUp(
        data: {'name': name, 'role': role},
        email: email,
        password: password,
      );
      await client.from("users").insert({
        "id": user.user!.id,
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

  @override
  Future<void> signInWithGoogle() async {
    try {
      await client.auth.signInWithOAuth(OAuthProvider.google);
    } catch (e) {
      throw handleException(e);
    }
  }
}

  // Future<AuthResponse> _googleSignIn() async {
  //   const webClientId = 'my-web.apps.googleusercontent.com';

  //   const iosClientId = 'my-ios.apps.googleusercontent.com';

  //   final GoogleSignIn googleSignIn = GoogleSignIn(
  //     scopes: <String>['email'],
  //     clientId: webClientId,
  //     iosClientId: iosClientId,
  //   );
  //   await GoogleSignIn.instance.initialize(clientId: webClientId);
  //   final googleAuth = await googleUser!.authentication;
  //   final accessToken = googleAuth.accessToken;
  //   final idToken = googleAuth.idToken;

  //   if (accessToken == null) {
  //     throw 'No Access Token found.';
  //   }
  //   if (idToken == null) {
  //     throw 'No ID Token found.';
  //   }

  //   return client.auth.signInWithIdToken(
  //     provider: OAuthProvider.google,
  //     idToken: idToken,
  //     accessToken: accessToken,
  //   );
  // }

