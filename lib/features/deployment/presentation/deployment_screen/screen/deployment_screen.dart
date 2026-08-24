import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_club/component/text/common_text.dart';
import 'package:football_club/config/route/app_routes.dart';
import 'package:football_club/features/deployment/domain/entity/deployment_entity.dart';
import 'package:football_club/features/deployment/presentation/deployment_screen/container/deployment_controller.dart';
import 'package:football_club/features/deployment/presentation/deployment_screen/widgets/core_development_areas_card.dart';
import 'package:football_club/features/deployment/presentation/deployment_screen/widgets/development_achievements_view.dart';
import 'package:football_club/features/deployment/presentation/deployment_screen/widgets/development_growth_card.dart';
import 'package:football_club/features/deployment/presentation/deployment_screen/widgets/development_notes_view.dart';
import 'package:football_club/features/deployment/presentation/deployment_screen/widgets/development_targets_view.dart';
import 'package:football_club/features/deployment/presentation/deployment_screen/widgets/development_timeline_view.dart';
import 'package:football_club/features/deployment/presentation/deployment_screen/widgets/football_skills_card.dart';
import 'package:football_club/features/deployment/presentation/deployment_screen/widgets/overall_score_card.dart';
import 'package:football_club/utils/constants/app_images.dart';
import 'package:get/get.dart';

class DeploymentScreen extends StatefulWidget {
  const DeploymentScreen({super.key});

  @override
  State<DeploymentScreen> createState() => _DeploymentScreenState();
}

class _DeploymentScreenState extends State<DeploymentScreen> {
  int _selectedTabIndex = 0;

  final List<String> _tabs = [
    "Assessments",
    "Targets",
    "Notes",
    "Timeline",
    "Achievements",
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DeploymentController());

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      body: Obx(() {
        if (controller.isLoading.value &&
            controller.deploymentEntity.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final deploymentData = controller.deploymentEntity.value;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Top Header with Background Image & Gradient
              SizedBox(
                width: double.infinity,
                child: Stack(
                  children: [
                    // Background Image Layer with Smooth Transition
                    Positioned.fill(
                      child: controller.bannerUrl.value.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: controller.bannerUrl.value,
                              fit: BoxFit.fill,
                              fadeInDuration: const Duration(milliseconds: 500),
                              placeholder: (context, url) => Image.asset(
                                AppImages.development_image,
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                AppImages.development_image,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Image.asset(
                              AppImages.development_image,
                              fit: BoxFit.cover,
                            ),
                    ),

                    // Gradient Overlay Layer
                    Positioned.fill(
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
                      ),
                    ),

                    // Content Layer
                    SafeArea(
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
                          // TFP Academy Header & Notification bell
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
                                    color: const Color(
                                      0xFF0C1322,
                                    ).withOpacity(0.6),
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

                          // Page Title
                          const CommonText(
                            text: "Development",
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 16.h),

                          // Scrollable Tab Filter Bar
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(_tabs.length, (index) {
                                final isSelected = _selectedTabIndex == index;

                                return Padding(
                                  padding: EdgeInsets.only(right: 8.w),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedTabIndex = index;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 18.w,
                                        vertical: 8.h,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: isSelected
                                            ? const LinearGradient(
                                                colors: [
                                                  Color(0xFF081A4A),
                                                  Color(0xFF1239D4),
                                                ],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                              )
                                            : null,
                                        color: isSelected
                                            ? null
                                            : const Color(
                                                0xFF0C1427,
                                              ).withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                        border: Border.all(
                                          color: isSelected
                                              ? const Color(0xFF1239D4)
                                              : Colors.white.withOpacity(0.08),
                                          width: 1,
                                        ),
                                      ),
                                      child: CommonText(
                                        text: _tabs[index],
                                        fontSize: 13,
                                        fontWeight: isSelected
                                            ? FontWeight.w600
                                            : FontWeight.w400,
                                        color: isSelected
                                            ? Colors.white
                                            : const Color(0xFF8E9BAE),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

              // 2. Tab Content View
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12.h),

                    // Display selected tab view dynamically
                    _buildSelectedTabView(deploymentData),
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

  Widget _buildSelectedTabView(DeploymentEntity? deploymentData) {
    if (deploymentData == null) return const SizedBox.shrink();

    switch (_selectedTabIndex) {
      case 0:
        return Column(
          children: [
            OverallScoreCard(
              score: deploymentData.overallScore,
              maxScore: deploymentData.maxScore,
              improvement: deploymentData.improvement,
              status: deploymentData.status,
            ),
            const SizedBox(height: 20),
            CoreDevelopmentAreasCard(areas: deploymentData.developmentAreas),
            const SizedBox(height: 20),
            FootballSkillsCard(skills: deploymentData.footballSkills),
            const SizedBox(height: 20),
            DevelopmentGrowthCard(
              months: deploymentData.growthMonths,
              values: deploymentData.growthValues,
            ),
          ],
        );
      case 1:
        return const DevelopmentTargetsView();
      case 2:
        return const DevelopmentNotesView();
      case 3:
        return const DevelopmentTimelineView();
      case 4:
        return const DevelopmentAchievementsView();
      default:
        return const SizedBox.shrink();
    }
  }
}
