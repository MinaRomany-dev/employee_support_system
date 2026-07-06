import 'package:employee_support_system/core/theme/color_manager.dart';
import 'package:employee_support_system/core/utils/toast.dart';
import 'package:employee_support_system/core/validator/validator.dart';
import 'package:employee_support_system/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:employee_support_system/features/auth/presentation/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    final heightscreen = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is LoginFailure) {
                  AppToast.showToast(
                    context: context,
                    title: "Login Failed",
                    description: state.message,
                    type: ToastificationType.error,
                  );
                } else if (state is LoginSuccess) {
                  AppToast.showToast(
                    context: context,
                    title: "Login Successful",
                    description: "You have been logged in successfully!",
                    type: ToastificationType.success,
                  );
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                    (route) => false,
                  );
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(height: 40.h),

                            CircleAvatar(
                              radius: 42.r,
                              backgroundColor: ColorManager.primaryLight,
                              child: Icon(
                                Icons.support_agent,
                                size: 42.sp,
                                color: ColorManager.primary,
                              ),
                            ),

                            SizedBox(height: 24.h),

                            Text(
                              "Welcome Back",
                              style: TextStyle(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.bold,
                                color: ColorManager.textPrimary,
                              ),
                            ),

                            SizedBox(height: 8.h),

                            Text(
                              "Sign in to continue",
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: ColorManager.textSecondary,
                              ),
                            ),

                            SizedBox(height: 40.h),

                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Email",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            SizedBox(height: heightscreen * 0.01),

                            TextFormField(
                              validator: Validators.email,
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: decoration(
                                hint: "Enter your email",
                                icon: Icons.email_outlined,
                              ),
                            ),

                            SizedBox(height: heightscreen * 0.03),

                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Password",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            SizedBox(height: heightscreen * 0.001),

                            TextFormField(
                              validator: Validators.password,
                              controller: passwordController,
                              obscureText: obscure,
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
                                        obscure
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                    ),
                                  ),
                            ),

                            SizedBox(height: heightscreen * 0.02),

                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    color: ColorManager.primary,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: heightscreen * 0.01),

                            SizedBox(
                              width: double.infinity,
                              height: 55.h,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: ColorManager.primary,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14.r),
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthBloc>().add(
                                      LoginEvent(
                                        emailController.text.trim(),
                                        passwordController.text.trim(),
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ), 

                            const Spacer(),
                            Padding(
                              padding: EdgeInsets.only(bottom: 25.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account?",
                                    style: TextStyle(
                                      color: ColorManager.textSecondary,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              const RegisterScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Register",
                                      style: TextStyle(
                                        color: ColorManager.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
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

// ملاحظة: تأكد من ضبط ColorManager الخاص بك أو استبدله بالألوان المناسبة

// import 'package:employee_support_system/core/theme/color_manager.dart';
// import 'package:flutter/material.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool obscure = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5), // لون خلفية هادئ للويندوز
//       body: Center(
//         child: SingleChildScrollView(
//           child: Container(
//             width: 450, // عرض ثابت ومثالي لنماذج تسجيل الدخول في ويندوز
//             margin: const EdgeInsets.all(20),
//             padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 20,
//                   offset: const Offset(0, 10),
//                 ),
//               ],
//             ),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   CircleAvatar(
//                     radius: 40,
//                     backgroundColor: ColorManager.primaryLight,
//                     child: Icon(
//                       Icons.support_agent,
//                       size: 40,
//                       color: ColorManager.primary,
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                   Text(
//                     "Welcome Back",
//                     style: TextStyle(
//                       fontSize: 26,
//                       fontWeight: FontWeight.bold,
//                       color: ColorManager.textPrimary,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     "Sign in to continue",
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: ColorManager.textSecondary,
//                     ),
//                   ),
//                   const SizedBox(height: 40),

//                   // حقل الإيميل
//                   _buildLabel("Email"),
//                   const SizedBox(height: 8),
//                   TextFormField(
//                     controller: emailController,
//                     decoration: _decoration(
//                       hint: "Enter your email",
//                       icon: Icons.email_outlined,
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // حقل الباسورد
//                   _buildLabel("Password"),
//                   const SizedBox(height: 8),
//                   TextFormField(
//                     controller: passwordController,
//                     obscureText: obscure,
//                     decoration:
//                         _decoration(
//                           hint: "Enter your password",
//                           icon: Icons.lock_outline,
//                         ).copyWith(
//                           suffixIcon: IconButton(
//                             onPressed: () => setState(() => obscure = !obscure),
//                             icon: Icon(
//                               obscure ? Icons.visibility_off : Icons.visibility,
//                             ),
//                           ),
//                         ),
//                   ),

//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: TextButton(
//                       onPressed: () {},
//                       child: const Text("Forgot Password?"),
//                     ),
//                   ),

//                   const SizedBox(height: 30),

//                   // زر الدخول
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: ColorManager.primary,
//                         foregroundColor: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       onPressed: () {},
//                       child: const Text(
//                         "Login",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text("Don't have an account?"),
//                       TextButton(
//                         onPressed: () {},
//                         child: const Text("Register"),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLabel(String text) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Text(
//         text,
//         style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//       ),
//     );
//   }

//   InputDecoration _decoration({required String hint, required IconData icon}) {
//     return InputDecoration(
//       hintText: hint,
//       prefixIcon: Icon(icon, color: ColorManager.primary),
//       filled: true,
//       fillColor: Colors.grey.shade50,
//       contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: BorderSide.none,
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: BorderSide(color: Colors.grey.shade300),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: BorderSide(color: ColorManager.primary, width: 2),
//       ),
//     );
//   }
// }
