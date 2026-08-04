import 'package:employee_support_system/core/resources/styles_manager.dart';
import 'package:employee_support_system/core/theme/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TicketMetaItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const TicketMetaItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: ColorManager.info, size: 15.sp),
         SizedBox(width: MediaQuery.of(context).size.width * 0.015),
        Text(
          text,
          style: getRegularStyle(fontSize: 13.5.sp, color: ColorManager.info),
        ),
      ],
    );
  }
}
