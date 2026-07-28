import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../config/route/app_routes.dart';
import '../../../../utils/constants/app_images.dart';
import '../../../../component/text/common_text.dart';
import '../widget/stat_card.dart';
import '../widget/player_progress_card.dart';
import '../widget/upcoming_training_card.dart';
import '../widget/target_goal_card.dart';
import '../widget/coach_feedback_card.dart';
import '../widget/recent_achievement_card.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header with background image decoration
            Container(
              width: double.infinity,
              height: 290.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.home_bg),
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
                    padding: EdgeInsets.only(right: 16,top: 16,left: 16,bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top Header text & Notification bell
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonText(
                              text: "TFP PLAYER PROFILE",
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withOpacity(0.5),
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
                          text: "YOUR\nFOOTBALL\nJOURNEY",
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          height: 1.2,
                          maxLines: 3,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Content Area
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // 1. Stats row
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StatCard(
                        icon: Icons.insights,
                        value: "42",
                        label: "Sessions",
                      ),
                      StatCard(
                        icon: Icons.track_changes,
                        value: "18",
                        label: "Goals",
                      ),
                      StatCard(
                        icon: Icons.bolt,
                        value: "11",
                        label: "Assists",
                      ),
                      StatCard(
                        icon: Icons.workspace_premium_outlined,
                        value: "4",
                        label: "POTM",
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  // 2. Player progress card
                  const PlayerProgressCard(),
                  SizedBox(height: 20.h),

                  // 3. Upcoming Training Card
                  const UpcomingTrainingCard(),
                  SizedBox(height: 20.h),

                  // 4. Target Goals Card
                  const TargetGoalCard(),
                  SizedBox(height: 20.h),

                  // 5. Coach Feedback Card
                  CoachFeedbackCard(
                    onViewAllTap: () => Get.toNamed(AppRoutes.allCoachFeedback),
                  ),
                  SizedBox(height: 20.h),

                  // 6. Recent Achievement Card
                  const RecentAchievementCard(),
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
