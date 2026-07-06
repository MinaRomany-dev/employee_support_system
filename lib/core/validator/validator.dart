import 'package:employee_support_system/features/auth/data/models/user_model.dart';

class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email";
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 6) {
      return "Password must be at least 6 chars";
    }

    return null;
  }

  static String? username(String? value) {
    if (value == null || value.isEmpty) {
      return "Username is required";
    }

    if (value.length < 4) {
      return "Too short";
    }

    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    }

    final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');

    if (!phoneRegex.hasMatch(value)) {
      return "Enter a valid phone number";
    }

    return null;
  }

  static String? confirmcode(String? value) {
    if (value == null || value.isEmpty) {
      return "Code is required";
    }
    if (value.length != 6) {
      return "Code must be 6 digits";
    }
    return null;
  }

  static String? role(UserRole? value) {
    if (value == null) {
      return "Role is required";
    }
    return null;
  }
}
