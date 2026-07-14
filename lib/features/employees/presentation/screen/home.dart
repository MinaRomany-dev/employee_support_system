import 'package:employee_support_system/core/resources/styles_manager.dart';
import 'package:employee_support_system/core/routes/routes.dart';
import 'package:employee_support_system/core/theme/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final items = List.generate(10, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: ColorManager.surface),
      backgroundColor: ColorManager.background,
      floatingActionButton: Container(
        height: MediaQuery.of(context).size.height * .09,
        width: MediaQuery.of(context).size.width * .3,
        child: FloatingActionButton(
          backgroundColor: ColorManager.primary,
          child: Text(
            "Create Ticket",
            style: getRegularStyle(
              color: ColorManager.primaryLight,
              fontSize: 15,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.ticketscreen);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
              // padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: ColorManager.border, width: 1.4.w),
              ),
              height: MediaQuery.of(context).size.height * .77,
            ),
          ],
        ),
      ),
    );
  }
}
