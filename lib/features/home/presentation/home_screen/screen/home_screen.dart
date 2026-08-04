import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_club/component/text/common_text.dart';
import 'package:football_club/config/route/app_routes.dart';
import 'package:football_club/features/home/presentation/home_screen/container/home_controller.dart';
import 'package:football_club/features/home/presentation/home_screen/widgets/coach_feedback_card.dart';
import 'package:football_club/features/home/presentation/home_screen/widgets/player_progress_card.dart';
import 'package:football_club/features/home/presentation/home_screen/widgets/recent_achievement_card.dart';
import 'package:football_club/features/home/presentation/home_screen/widgets/stat_card.dart';
import 'package:football_club/features/home/presentation/home_screen/widgets/target_goal_card.dart';
import 'package:football_club/features/home/presentation/home_screen/widgets/upcoming_training_card.dart';
import 'package:football_club/utils/constants/app_images.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      body: Obx(() {
        if (controller.isLoading.value && controller.homeEntity.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final homeData = controller.homeEntity.value;
        if (homeData == null) {
          return const SizedBox();
        }

        return SingleChildScrollView(
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
                      padding: const EdgeInsets.only(right: 16, top: 16, left: 16, bottom: 16),
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
                    // 1. Dynamic Stats row from HomeRemoteDataSource
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StatCard(
                          icon: Icons.insights,
                          value: "${homeData.sessionsCount}",
                          label: "Sessions",
                        ),
                        StatCard(
                          icon: Icons.track_changes,
                          value: "${homeData.goalsCount}",
                          label: "Goals",
                        ),
                        StatCard(
                          icon: Icons.bolt,
                          value: "${homeData.assistsCount}",
                          label: "Assists",
                        ),
                        StatCard(
                          icon: Icons.workspace_premium_outlined,
                          value: "${homeData.potmCount}",
                          label: "POTM",
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    // 2. Dynamic Player progress card from HomeRemoteDataSource
                    PlayerProgressCard(
                      name: homeData.playerName,
                      level: homeData.playerLevel,
                      subtitle: homeData.playerSubtitle,
                      progress: homeData.playerProgress,
                      imagePath: homeData.playerImagePath,
                    ),
                    SizedBox(height: 20.h),

                    // 3. Dynamic Upcoming Training Card from HomeRemoteDataSource
                    UpcomingTrainingCard(
                      title: homeData.trainingTitle,
                      daysLeftText: homeData.daysLeftText,
                      dateText: homeData.trainingDateText,
                      locationText: homeData.trainingLocationText,
                      coachName: homeData.trainingCoachName,
                      coachAvatar: homeData.trainingCoachAvatar,
                    ),
                    SizedBox(height: 20.h),

                    // 4. Dynamic Target Goals Card from HomeRemoteDataSource
                    TargetGoalCard(
                      categoryTitle: homeData.goalCategoryTitle,
                      statusText: homeData.goalStatusText,
                      goalTitle: homeData.goalTitle,
                      description: homeData.goalDescription,
                      progress: homeData.goalProgress,
                      dueDate: homeData.goalDueDate,
                    ),
                    SizedBox(height: 20.h),

                    // 5. Dynamic Coach Feedback Card from HomeRemoteDataSource
                    CoachFeedbackCard(
                      title: homeData.feedbackTitle,
                      coachName: homeData.feedbackCoachName,
                      date: homeData.feedbackDate,
                      feedback: homeData.feedbackContent,
                      avatarPath: homeData.feedbackAvatarPath,
                      onViewAllTap: () => Get.toNamed(AppRoutes.allCoachFeedback),
                    ),
                    SizedBox(height: 20.h),

                    // 6. Dynamic Recent Achievement Card from HomeRemoteDataSource
                    RecentAchievementCard(
                      category: homeData.achievementCategory,
                      achievementTitle: homeData.achievementTitle,
                      matchInfo: homeData.matchInfo,
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
