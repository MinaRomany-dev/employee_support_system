abstract class AuthDatasource {
  Future<void> login(String email, String password);
  Future<void> register(
    String name,
    String role,
    String email,
    String password,
  );
  Future<void> logout();
}
