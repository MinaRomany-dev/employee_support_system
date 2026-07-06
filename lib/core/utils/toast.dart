import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

abstract class AppToast {
  static void showToast({
    required BuildContext context,
    required String title,
    required String description,
    required ToastificationType type,
  }) {
    toastification.show(
      context: context,
      alignment: Alignment.bottomLeft,
      type: type,
      title: Text(
        title,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      ),
      description: Text(
        description,
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
      ),
      primaryColor: Colors.white,
      autoCloseDuration: type == ToastificationType.success
          ? const Duration(seconds: 2)
          : const Duration(seconds: 4),
      progressBarTheme: ProgressIndicatorThemeData(
        color: type == ToastificationType.success
            ? Colors.green
            : type == ToastificationType.info
            ? Colors.blue
            : type == ToastificationType.warning
            ? Colors.orange
            : Colors.red,
      ),
      showProgressBar: true,
      backgroundColor: type == ToastificationType.success
          ? Colors.green
          : type == ToastificationType.info
          ? Colors.blue
          : type == ToastificationType.warning
          ? Colors.orange
          : Colors.red,
      foregroundColor: Colors.white,
    );
  }
}
