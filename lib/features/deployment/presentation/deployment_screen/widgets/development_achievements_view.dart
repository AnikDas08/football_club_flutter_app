import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_club/component/text/common_text.dart';
import 'package:football_club/features/deployment/presentation/deployment_screen/container/deployment_controller.dart';
import 'package:get/get.dart';

class DevelopmentAchievementsView extends StatelessWidget {
  const DevelopmentAchievementsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DeploymentController>();

    return Obx(() {
      if (controller.isAchievementsLoading.value) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 40.h),
          child: const Center(
            child: CircularProgressIndicator(color: Color(0xFF2563EB)),
          ),
        );
      }

      final achievementData = controller.achievementData.value;
      if (achievementData == null || achievementData.grid.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 40.h),
          child: const Center(
            child: CommonText(
              text: "No achievements available",
              fontSize: 14,
              color: Color(0xFF8E9BAE),
            ),
          ),
        );
      }

      final gridItems = achievementData.grid;
      final recordItems = achievementData.achievements;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Grid of Achievement Badges
          GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 1.15,
            ),
            itemCount: gridItems.length,
            itemBuilder: (context, index) {
              final item = gridItems[index];

              final String statusText = item.hasEarned
                  ? (item.value.isNotEmpty ? item.value : '✔')
                  : (item.value.isNotEmpty ? item.value : '🔒');

              final Color statusColor = item.hasEarned
                  ? const Color(0xFF10B981)
                  : const Color(0xFF64748B);

              return Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF0C1427).withOpacity(item.hasEarned ? 0.85 : 0.45),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: item.hasEarned
                        ? const Color(0xFF2563EB).withOpacity(0.4)
                        : Colors.white.withOpacity(0.06),
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.icon,
                      style: TextStyle(fontSize: 26.sp),
                    ),
                    SizedBox(height: 8.h),
                    CommonText(
                      text: item.title,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: item.hasEarned ? Colors.white : const Color(0xFF8E9BAE),
                      maxLines: 1,
                    ),
                    SizedBox(height: 2.h),
                    CommonText(
                      text: item.subtitle,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF8E9BAE),
                    ),
                    SizedBox(height: 6.h),
                    CommonText(
                      text: statusText,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: statusColor,
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 24.h),

          // 2. Earned Achievement Details Records List
          if (recordItems.isNotEmpty) ...[
            const CommonText(
              text: "EARNED ACHIEVEMENTS",
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 1.0,
            ),
            SizedBox(height: 12.h),
            ...recordItems.map((record) {
              return Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 12.h),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF0C1427).withOpacity(0.85),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.08),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CommonText(
                            text: record.matchEvent.isNotEmpty
                                ? record.matchEvent
                                : record.awardType,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF052E16),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: const Color(0xFF15803D),
                              width: 1,
                            ),
                          ),
                          child: CommonText(
                            text: record.awardType,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF22C55E),
                          ),
                        ),
                      ],
                    ),
                    if (record.description.isNotEmpty) ...[
                      SizedBox(height: 6.h),
                      CommonText(
                        text: record.description,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF8E9BAE),
                        textAlign: TextAlign.start,
                        maxLines: 4,
                      ),
                    ],
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (record.coachName.isNotEmpty)
                          CommonText(
                            text: "Coach: ${record.coachName}",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFCBD5E1),
                          ),
                        if (record.formattedDate.isNotEmpty)
                          CommonText(
                            text: record.formattedDate,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF8E9BAE),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ],
          SizedBox(height: 24.h),
        ],
      );
    });
  }
}
