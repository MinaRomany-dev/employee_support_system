import 'package:employee_support_system/core/appobserver.dart';
import 'package:employee_support_system/core/di/di.dart';
import 'package:employee_support_system/core/routes/generate_route.dart';
import 'package:employee_support_system/core/routes/routes.dart';
import 'package:employee_support_system/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:employee_support_system/features/employees/presentation/bloc/ticket_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();
  final apikey = dotenv.get('API_KEY');
  final url = dotenv.get('URLSupabase');
  await Supabase.initialize(url: url, publishableKey: apikey);
  Bloc.observer = AppBlocObserver();
  configureDependencies();
  runApp(const HelpDesk());
}

class HelpDesk extends StatelessWidget {
  SupabaseClient get client => Supabase.instance.client;
  const HelpDesk({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,

      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<AuthBloc>()),
          BlocProvider(create: (context) => getIt<TicketBloc>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: generateRoute,
          initialRoute: Routes.home,
        ),
      ),
    );
  }
}
