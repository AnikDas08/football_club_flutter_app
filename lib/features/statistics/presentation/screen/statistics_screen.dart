import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../config/route/app_routes.dart';
import '../../../../utils/constants/app_images.dart';
import '../../../../component/text/common_text.dart';
import '../widget/goals_by_month_card.dart';
import '../widget/attendance_analytics_card.dart';
import '../widget/match_involvement_card.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Top Header with Background Image & Gradient
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.statistics_image),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF0A0E1A).withOpacity(0.1),
                      const Color(0xFF0A0E1A).withOpacity(0.85),
                      const Color(0xFF0A0E1A),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: EdgeInsets.only(right: 16.w, top: 12.h, left: 16.w, bottom: 12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Logo & Notification Bell
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 22.w,
                                  height: 22.h,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF2563EB),
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.sports_soccer,
                                    color: Colors.white,
                                    size: 14.sp,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                const CommonText(
                                  text: "TFP Academy",
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF2563EB),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () => Get.toNamed(AppRoutes.notifications),
                              child: Container(
                                padding: EdgeInsets.all(10.r),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0C1322).withOpacity(0.6),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.08),
                                    width: 1,
                                  ),
                                ),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Icon(
                                      Icons.notifications_none_outlined,
                                      color: Colors.white,
                                      size: 22.sp,
                                    ),
                                    Positioned(
                                      right: 2.w,
                                      top: 2.h,
                                      child: Container(
                                        width: 8.w,
                                        height: 8.h,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF2563EB),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),

                        // Title
                        const CommonText(
                          text: "Statistics",
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // 2. Statistics Cards Content Area
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4.h),

                  // Goals by Month Card
                  const GoalsByMonthCard(),
                  SizedBox(height: 16.h),

                  // Attendance Analytics Card
                  const AttendanceAnalyticsCard(),
                  SizedBox(height: 16.h),

                  // Match Involvement Card
                  const MatchInvolvementCard(),
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
