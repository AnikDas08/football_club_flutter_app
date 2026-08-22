import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_club/component/image/common_image.dart';
import 'package:football_club/component/text/common_text.dart';
import 'package:football_club/features/deployment/presentation/deployment_screen/container/deployment_controller.dart';
import 'package:football_club/utils/constants/app_images.dart';
import 'package:get/get.dart';

class DevelopmentTargetsView extends StatelessWidget {
  const DevelopmentTargetsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DeploymentController>();

    return Obx(() {
      if (controller.isTargetsLoading.value) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 40.h),
          child: const Center(
            child: CircularProgressIndicator(color: Color(0xFF2563EB)),
          ),
        );
      }

      final allTargets = controller.targetsList;
      if (allTargets.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 40.h),
          child: const Center(
            child: CommonText(
              text: "No targets available",
              fontSize: 14,
              color: Color(0xFF8E9BAE),
            ),
          ),
        );
      }

      final activeTargets = allTargets
          .where((t) => t.status.toLowerCase() != 'completed')
          .toList();
      final completedTargets = allTargets
          .where((t) => t.status.toLowerCase() == 'completed')
          .toList();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Active Targets List
          if (activeTargets.isNotEmpty)
            ...activeTargets.map((target) {
              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: _buildActiveTargetCard(
                  title: target.title,
                  description: target.description,
                  coachName: target.coachName.isNotEmpty
                      ? target.coachName
                      : "Coach",
                  coachAvatar: target.coachImage,
                  progress: (target.progress / 100.0).clamp(0.0, 1.0),
                  dueDate: target.dueFormatted.isNotEmpty
                      ? target.dueFormatted
                      : target.dueDate,
                  statusText: target.status,
                ),
              );
            }),

          // Completed Section
          if (completedTargets.isNotEmpty) ...[
            SizedBox(height: 8.h),
            const CommonText(
              text: "COMPLETED",
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 1.0,
            ),
            SizedBox(height: 12.h),
            ...completedTargets.map((target) {
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: _buildCompletedTargetItem(
                  title: target.title,
                  dateText: target.dueFormatted.isNotEmpty
                      ? target.dueFormatted
                      : target.dueDate,
                ),
              );
            }),
          ],
          SizedBox(height: 24.h),
        ],
      );
    });
  }

  Widget _buildActiveTargetCard({
    required String title,
    required String description,
    required String coachName,
    required String coachAvatar,
    required double progress,
    required String dueDate,
    required String statusText,
  }) {
    final percentageText = '${(progress * 100).toInt()}%';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
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
          // Header with Title & Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CommonText(
                  text: title,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF091C4A),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: const Color(0xFF1D4ED8).withOpacity(0.4),
                    width: 1,
                  ),
                ),
                child: CommonText(
                  text: statusText,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF2563EB),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),

          // Description
          CommonText(
            text: description,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF8E9BAE),
            textAlign: TextAlign.start,
            maxLines: 2,
          ),
          SizedBox(height: 12.h),

          // Coach Avatar & Name
          Row(
            children: [
              Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.2),
                ),
                child: ClipOval(
                  child: CommonImage(
                    imageSrc: coachAvatar,
                    fill: BoxFit.cover,
                    defaultImage: AppImages.coach_image,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              CommonText(
                text: coachName,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(0.85),
              ),
            ],
          ),
          SizedBox(height: 14.h),

          // Progress Label & percentage
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CommonText(
                text: "Progress",
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color(0xFF8E9BAE),
              ),
              CommonText(
                text: percentageText,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2563EB),
              ),
            ],
          ),
          SizedBox(height: 6.h),

          // Progress Bar Track
          Container(
            height: 6.h,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: progress.clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF2563EB),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),

          // Due Date
          CommonText(
            text: dueDate,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF8E9BAE),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedTargetItem({
    required String title,
    required String dateText,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: const Color(0xFF0C1427).withOpacity(0.85),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 32.w,
                  height: 32.h,
                  decoration: const BoxDecoration(
                    color: Color(0xFF064E3B),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.check,
                    color: const Color(0xFF10B981),
                    size: 18.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: CommonText(
                    text: title,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          CommonText(
            text: dateText,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF8E9BAE),
          ),
        ],
      ),
    );
  }
}
