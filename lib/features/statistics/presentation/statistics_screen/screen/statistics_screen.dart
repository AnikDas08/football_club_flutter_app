import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_club/component/text/common_text.dart';
import 'package:football_club/config/route/app_routes.dart';
import 'package:football_club/features/statistics/presentation/statistics_screen/container/statistics_controller.dart';
import 'package:football_club/features/statistics/presentation/statistics_screen/widgets/attendance_analytics_card.dart';
import 'package:football_club/features/statistics/presentation/statistics_screen/widgets/goals_by_month_card.dart';
import 'package:football_club/features/statistics/presentation/statistics_screen/widgets/match_involvement_card.dart';
import 'package:football_club/utils/constants/app_images.dart';
import 'package:get/get.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StatisticsController());

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      body: Obx(() {
        if (controller.isLoading.value &&
            controller.statisticsEntity.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final statsData = controller.statisticsEntity.value;

        return SingleChildScrollView(
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
                      padding: EdgeInsets.only(
                        right: 16.w,
                        top: 12.h,
                        left: 16.w,
                        bottom: 12.h,
                      ),
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
                                 onTap: () =>
                                     Get.toNamed(AppRoutes.notifications),
                                 child: Container(
                                   width: 40.w,
                                   height: 40.h,
                                   decoration: BoxDecoration(
                                     color: const Color(0xFF0C1322)
                                         .withOpacity(0.6),
                                     shape: BoxShape.circle,
                                     border: Border.all(
                                       color: Colors.white.withOpacity(0.08),
                                       width: 1,
                                     ),
                                   ),
                                   child: Center(
                                     child: Stack(
                                       alignment: Alignment.center,
                                       clipBehavior: Clip.none,
                                       children: [
                                         Icon(
                                           Icons.notifications_none_outlined,
                                           color: Colors.white,
                                           size: 22.sp,
                                         ),
                                         Positioned(
                                           right: 0,
                                           top: 0,
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
                    if (statsData != null)
                      GoalsByMonthCard(
                        goalsByMonth: statsData.goalsByMonth,
                      ),
                    SizedBox(height: 16.h),

                    // Attendance Analytics Card
                    if (statsData != null)
                      AttendanceAnalyticsCard(
                        attendanceRate: statsData.attendanceRate,
                        attendedPercentage: statsData.attendedPercentage,
                        missedPercentage: statsData.missedPercentage,
                        latePercentage: statsData.latePercentage,
                        playerImagePath: statsData.playerImagePath,
                      ),
                    SizedBox(height: 16.h),

                    // Match Involvement Card
                    if (statsData != null)
                      MatchInvolvementCard(
                        shotsCount: "${statsData.shotsCount}",
                        onTargetCount: "${statsData.onTargetCount}",
                        chancesCreatedCount: "${statsData.chancesCreatedCount}",
                      ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
