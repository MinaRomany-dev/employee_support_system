import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class TicketCardShimmer extends StatelessWidget {
  const TicketCardShimmer({super.key});

  Widget _box({
    required double width,
    required double height,
    double radius = 8,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius.r),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(18.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: const Color(0xFFEEF2F7)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// نفس الـ Wrap بتاع الـ Badges
            Wrap(
              spacing: 20.w,
              runSpacing: 6.h,
              children: [
                _box(width: 70.w, height: 28.h, radius: 20),
                _box(width: 80.w, height: 28.h, radius: 20),
                _box(width: 90.w, height: 28.h, radius: 20),
              ],
            ),

            SizedBox(height: height * .015),

            /// Title
            _box(width: 220.w, height: 22.h),

            SizedBox(height: height * .01),

            /// Description
            _box(width: double.infinity, height: 14.h),
            SizedBox(height: 8.h),
            _box(width: 240.w, height: 14.h),

            SizedBox(height: height * .017),

            const Divider(height: 1, color: Color(0xFFEEF2F7)),

            SizedBox(height: height * .015),

            /// Bottom Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _box(width: 18.w, height: 18.h, radius: 20),
                    SizedBox(width: 8.w),
                    _box(width: 110.w, height: 14.h),
                  ],
                ),

                Row(
                  children: [
                    _box(width: 18.w, height: 18.h, radius: 20),
                    SizedBox(width: 8.w),
                    _box(width: 90.w, height: 14.h),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
