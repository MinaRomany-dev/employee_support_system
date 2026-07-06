class UserEntity {
  final String name;
  final String role;
  final String email;
  final String? profileImageUrl;
  const UserEntity({
    required this.name,
    required this.role,
    required this.email,
    this.profileImageUrl,
  });
}
