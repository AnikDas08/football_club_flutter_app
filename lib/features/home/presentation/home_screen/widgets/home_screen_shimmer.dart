import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_club/component/other_widgets/common_shimmer.dart';

class HomeScreenShimmer extends StatelessWidget {
  const HomeScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: CommonShimmer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header Shimmer
            Container(
              width: double.infinity,
              height: 220.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              color: const Color(0xFF0A0E1A),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShimmerBox(width: 140.w, height: 14.h, borderRadius: 4.r),
                        ShimmerBox(width: 40.w, height: 40.h, borderRadius: 20.r),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    ShimmerBox(width: 200.w, height: 28.h, borderRadius: 6.r),
                    SizedBox(height: 8.h),
                    ShimmerBox(width: 150.w, height: 28.h, borderRadius: 6.r),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),

                  // 1. Stats Row Shimmer (4 cards)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      4,
                      (index) => Container(
                        width: 80.w,
                        height: 75.h,
                        padding: EdgeInsets.all(10.r),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0C1427),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ShimmerBox(width: 24.w, height: 24.h, borderRadius: 6.r),
                            SizedBox(height: 6.h),
                            ShimmerBox(width: 40.w, height: 12.h, borderRadius: 4.r),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // 2. Player Progress Card Shimmer
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0C1427),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Avatar
                        ShimmerBox(width: 60.w, height: 60.h, borderRadius: 15.r),
                        SizedBox(width: 14.w),

                        // Center lines
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ShimmerBox(width: 120.w, height: 16.h, borderRadius: 4.r),
                              SizedBox(height: 8.h),
                              ShimmerBox(width: 80.w, height: 18.h, borderRadius: 10.r),
                              SizedBox(height: 8.h),
                              ShimmerBox(width: 140.w, height: 12.h, borderRadius: 4.r),
                              SizedBox(height: 10.h),
                              ShimmerBox(width: double.infinity, height: 7.h, borderRadius: 10.r),
                            ],
                          ),
                        ),
                        SizedBox(width: 14.w),

                        // Gauge
                        ShimmerBox(width: 52.w, height: 52.h, borderRadius: 26.r),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // 3. Upcoming Training Card Shimmer
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0C1427),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ShimmerBox(width: 140.w, height: 18.h, borderRadius: 4.r),
                            ShimmerBox(width: 70.w, height: 20.h, borderRadius: 12.r),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        ShimmerBox(width: 200.w, height: 14.h, borderRadius: 4.r),
                        SizedBox(height: 8.h),
                        ShimmerBox(width: 240.w, height: 13.h, borderRadius: 4.r),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            ShimmerBox(width: 36.w, height: 36.h, borderRadius: 18.r),
                            SizedBox(width: 10.w),
                            ShimmerBox(width: 120.w, height: 14.h, borderRadius: 4.r),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // 4. Target Goal Card Shimmer
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(18.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0C1427),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ShimmerBox(width: 32.w, height: 32.h, borderRadius: 16.r),
                                SizedBox(width: 12.w),
                                ShimmerBox(width: 120.w, height: 16.h, borderRadius: 4.r),
                              ],
                            ),
                            ShimmerBox(width: 80.w, height: 22.h, borderRadius: 16.r),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        ShimmerBox(width: 220.w, height: 16.h, borderRadius: 4.r),
                        SizedBox(height: 8.h),
                        ShimmerBox(width: double.infinity, height: 12.h, borderRadius: 4.r),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ShimmerBox(width: 60.w, height: 13.h, borderRadius: 4.r),
                            ShimmerBox(width: 30.w, height: 13.h, borderRadius: 4.r),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        ShimmerBox(width: double.infinity, height: 7.h, borderRadius: 10.r),
                        SizedBox(height: 14.h),
                        ShimmerBox(width: 100.w, height: 12.h, borderRadius: 4.r),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
