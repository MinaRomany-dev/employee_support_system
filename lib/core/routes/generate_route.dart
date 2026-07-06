import 'package:employee_support_system/core/routes/routes.dart';
import 'package:employee_support_system/features/auth/presentation/screens/login.dart';
import 'package:employee_support_system/features/auth/presentation/screens/register.dart';
import 'package:flutter/material.dart';

Route? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.login:
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    case Routes.register:
      return MaterialPageRoute(builder: (_) => const RegisterScreen());
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: const Text('No route defined')),
          body: Center(child: Text('No route defined')),
        ),
      );
  }
}
