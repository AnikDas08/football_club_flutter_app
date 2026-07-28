import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../config/route/app_routes.dart';
import '../../../../utils/constants/app_images.dart';
import '../../../../component/text/common_text.dart';
import '../widget/overall_score_card.dart';
import '../widget/core_development_areas_card.dart';
import '../widget/football_skills_card.dart';
import '../widget/development_growth_card.dart';
import '../widget/development_targets_view.dart';
import '../widget/development_notes_view.dart';
import '../widget/development_timeline_view.dart';
import '../widget/development_achievements_view.dart';

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
                  image: AssetImage(AppImages.development_image),
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
                                    duration: const Duration(milliseconds: 200),
                                    padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
                                    decoration: BoxDecoration(
                                      gradient: isSelected
                                          ? const LinearGradient(
                                              colors: [Color(0xFF081A4A), Color(0xFF1239D4)],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            )
                                          : null,
                                      color: isSelected ? null : const Color(0xFF0C1427).withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(20.r),
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
                                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                      color: isSelected ? Colors.white : const Color(0xFF8E9BAE),
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
              ),
            ),

            // 2. Tab Content View
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12.h),

                  // Display selected tab view
                  _buildSelectedTabView(),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedTabView() {
    switch (_selectedTabIndex) {
      case 0:
        return const Column(
          children: [
            OverallScoreCard(),
            SizedBox(height: 20),
            CoreDevelopmentAreasCard(),
            SizedBox(height: 20),
            FootballSkillsCard(),
            SizedBox(height: 20),
            DevelopmentGrowthCard(),
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
