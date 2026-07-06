import 'package:employee_support_system/core/theme/color_manager.dart';
import 'package:employee_support_system/features/auth/presentation/screens/widgets/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {

            bool desktop = constraints.maxWidth >= 900;

            if (desktop) {
              return const _DesktopRegister();
            }

            return const _MobileRegister();
          },
        ),
      ),
    );
  }
}

class _DesktopRegister extends StatelessWidget {
  const _DesktopRegister();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Expanded(
          flex: 5,
          child: Container(
            color: ColorManager.primaryLight,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Icon(
                    Icons.support_agent,
                    size: 120.sp,
                    color: ColorManager.primary,
                  ),

                  SizedBox(height: 25.h),

                  Text(
                    "Employee Support",
                    style: TextStyle(
                      fontSize: 34.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.textPrimary,
                    ),
                  ),

                  SizedBox(height: 10.h),

                  Text(
                    "Manage tickets faster and smarter",
                    style: TextStyle(
                      fontSize: 17.sp,
                      color: ColorManager.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        Expanded(
          flex: 6,
          child: Center(
            child: SizedBox(
              width: 450.w,
              child: const RegisterForm(),
            ),
          ),
        ),
      ],
    );
  }
}

class _MobileRegister extends StatelessWidget {
  const _MobileRegister();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SizedBox(
          width: 420.w,
          child: const RegisterForm(),
        ),
      ),
    );
  }
}