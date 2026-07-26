import 'package:employee_support_system/core/routes/routes.dart';
import 'package:employee_support_system/features/auth/presentation/screens/login.dart';
import 'package:employee_support_system/features/auth/presentation/screens/register.dart';
import 'package:employee_support_system/features/employees/domain/entity/ticket_entity.dart';
import 'package:employee_support_system/features/employees/presentation/screen/create_ticket_screen.dart';
import 'package:employee_support_system/features/employees/presentation/screen/employee_home.dart';
import 'package:employee_support_system/features/employees/presentation/screen/manager.dart';
import 'package:employee_support_system/features/employees/presentation/screen/ticket_details_screen.dart';
import 'package:employee_support_system/features/splash/splash_screen.dart';
import 'package:employee_support_system/features/support/presentation/screens/home_support.dart';
import 'package:flutter/material.dart';

Route? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.ticketDetailsScreen:
      return MaterialPageRoute(
        builder: (_) =>
            TicketDetailsScreen(ticket: settings.arguments as TicketEntity),
      );
    case Routes.manager:
      return MaterialPageRoute(builder: (_) => const Manager());
    case Routes.support:
      return MaterialPageRoute(builder: (_) => const HomeSupport());
    case Routes.ticketscreen:
      return MaterialPageRoute(builder: (_) => const CreateTicketScreen());
    case Routes.splashScreen:
      return MaterialPageRoute(builder: (_) => SplashScreen());
    case Routes.home:
      return MaterialPageRoute(builder: (context) => HelpDeskScreen());
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
