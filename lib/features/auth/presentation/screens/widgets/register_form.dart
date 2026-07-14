import 'package:employee_support_system/core/routes/routes.dart';
import 'package:employee_support_system/core/theme/color_manager.dart';
import 'package:employee_support_system/core/utils/toast.dart';
import 'package:employee_support_system/core/validator/validator.dart';
import 'package:employee_support_system/features/auth/data/models/user_model.dart';
import 'package:employee_support_system/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscure = true;

  UserRole? role = UserRole.employee;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          AppToast.showToast(
            context: context,
            description: "Please check your email for verification.",
            type: ToastificationType.success,
            title: "Account created successfully",
          );
          Navigator.of(context).pushNamed(Routes.login);
        }

        if (state is RegisterFailure) {
          AppToast.showToast(
            context: context,
            description: state.message,
            type: ToastificationType.error,
            title: "Account creation failed",
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(
                radius: 42.r,
                backgroundColor: ColorManager.primaryLight,
                child: Icon(
                  Icons.person_add_alt_1,
                  size: 40.sp,
                  color: ColorManager.primary,
                ),
              ),

              SizedBox(height: 24.h),

              Text(
                "Create Account",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.textPrimary,
                ),
              ),

              SizedBox(height: 8.h),

              Text(
                "Create your helpdesk account",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: ColorManager.textSecondary,
                ),
              ),

              SizedBox(height: 40.h),

              Text(
                "Full Name",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),

              SizedBox(height: 8.h),

              TextFormField(
                validator: Validators.username,
                keyboardType: TextInputType.name,
                controller: nameController,
                textInputAction: TextInputAction.next,
                decoration: decoration(
                  hint: "Enter your full name",
                  icon: Icons.person_outline,
                ),
              ),

              SizedBox(height: 18.h),

              Text(
                "Email",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),

              SizedBox(height: 8.h),

              TextFormField(
                validator: Validators.email,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: decoration(
                  hint: "Enter your email",
                  icon: Icons.email_outlined,
                ),
              ),

              SizedBox(height: 18.h),

              Text(
                "Password",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),

              SizedBox(height: 8.h),

              TextFormField(
                validator: Validators.password,
                controller: passwordController,
                obscureText: obscure,
                textInputAction: TextInputAction.done,
                decoration:
                    decoration(
                      hint: "Enter your password",
                      icon: Icons.lock_outline,
                    ).copyWith(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                        icon: Icon(
                          obscure ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                    ),
              ),

              SizedBox(height: 18.h),

              Text(
                "Role",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),

              SizedBox(height: 8.h),

              DropdownButtonFormField<UserRole>(
                validator: Validators.role,
                initialValue: null,
                decoration: decoration(
                  hint: "Selected role",
                  icon: Icons.admin_panel_settings_outlined,
                ),
                borderRadius: BorderRadius.circular(14.r),
                items: UserRole.values.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e.name[0].toUpperCase() + e.name.substring(1)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    role = value!;
                    print("Selected role: ${role!.name}");
                  });
                },
              ),

              SizedBox(height: 32.h),

              SizedBox(
                height: 55.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(
                        RegisterEvent(
                          nameController.text.trim(),
                          emailController.text.trim(),
                          passwordController.text.trim(),
                          role!.name,
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 22.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(color: ColorManager.textSecondary),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Login"),
                  ),
                ],
              ),

              SizedBox(height: 25.h),
            ],
          ),
        );
      },
    );
  }

  InputDecoration decoration({required String hint, required IconData icon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: ColorManager.textMuted),
      prefixIcon: Icon(icon, color: ColorManager.primary),
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(vertical: 18.h),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(color: ColorManager.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(color: ColorManager.primary, width: 1.4),
      ),
    );
  }
}
