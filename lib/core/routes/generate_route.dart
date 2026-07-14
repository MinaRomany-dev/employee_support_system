import 'package:employee_support_system/core/routes/routes.dart';
import 'package:employee_support_system/features/auth/presentation/screens/login.dart';
import 'package:employee_support_system/features/auth/presentation/screens/register.dart';
import 'package:employee_support_system/features/employees/presentation/screen/home.dart';
import 'package:employee_support_system/features/employees/presentation/screen/manager.dart';
import 'package:employee_support_system/features/employees/presentation/screen/ticket_details_screen.dart';
import 'package:flutter/material.dart';

Route? generateRoute(RouteSettings settings) {
  //SupabaseClient client = Supabase.instance.client;

  switch (settings.name) {
    case Routes.manager:
      return MaterialPageRoute(builder: (_) => const Manager());
    case Routes.ticketscreen:
      return MaterialPageRoute(builder: (_) => const CreateTicketScreen());
    case Routes.home:
      return MaterialPageRoute(builder: (_) => Home());
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
