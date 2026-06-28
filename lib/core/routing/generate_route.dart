import 'package:employee_support_system/core/routing/routes.dart';
import 'package:employee_support_system/features/auth/presentation/screens/login.dart';
import 'package:flutter/material.dart';

Route? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.login:
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: const Text('No route defined')),
          body: Center(child: Text('No route defined')),
        ),
      );
  }
}
