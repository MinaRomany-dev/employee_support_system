import 'package:employee_support_system/features/auth/data/models/user_model.dart';
import 'package:employee_support_system/features/employees/data/models/ticket_model.dart';

class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email";
    }
// 
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

  static String? ticketcategory(TicketCategory? value) {
    if (value == null) {
      return "Category is required";
    }
    return null;
  }

  static String? ticketpriority(TicketPriority? value) {
    if (value == null) {
      return "Priority is required";
    }
    return null;
  }

  static String? ticketstatus(TicketStatus? value) {
    if (value == null) {
      return "Status is required";
    }
    return null;
  }

  static String? tickettitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Title is required";
    }
    return null;
  }

  static String? ticketdescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Description is required";
    }
    return null;
  }
}
