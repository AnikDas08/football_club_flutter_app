import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../component/text/common_text.dart';

class TargetGoalCard extends StatelessWidget {
  final String categoryTitle;
  final String statusText;
  final String goalTitle;
  final String description;
  final double progress;
  final String dueDate;
  final List<Color> progressGradientColors;

  const TargetGoalCard({
    super.key,
    this.categoryTitle = 'Current Target',
    this.statusText = 'In Progress',
    this.goalTitle = 'Improve Left-Foot Finishing',
    this.description = 'Achieve 70% accuracy on left-foot shots from inside the box.',
    this.progress = 0.62,
    this.dueDate = 'Due: 28 Feb 2025',
    this.progressGradientColors = const [
      Color(0xFF081A4A),
      Color(0xFF1239D4),
    ],
  });

  @override
  Widget build(BuildContext context) {
    final percentageText = '${(progress * 100).toInt()}%';
    final accentBlue = progressGradientColors.last;

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
          // 1. Header with Mint Target Icon, Category Title & Status Pill
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Circular light mint green badge icon container
                  Container(
                    width: 32.w,
                    height: 32.h,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD1FAE5),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.track_changes_outlined,
                      color: const Color(0xFF15803D),
                      size: 18.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  CommonText(
                    text: categoryTitle,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ],
              ),

              // "In Progress" Status Badge Pill
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF091C4A),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: const Color(0xFF1D4ED8).withOpacity(0.3),
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
          SizedBox(height: 16.h),

          // 2. Goal Title & Description
          CommonText(
            text: goalTitle,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          SizedBox(height: 6.h),
          CommonText(
            text: description,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF8E9BAE),
            maxLines: 2,
            height: 1.3,
          ),
          SizedBox(height: 16.h),

          // 3. Progress Labels & Linear Progress Bar
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
                color: accentBlue,
              ),
            ],
          ),
          SizedBox(height: 8.h),

          // Linear progress bar track with gradient fill and rounded ends
          Container(
            height: 7.h,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: progress.clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: progressGradientColors,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 14.h),

          // 4. Due Date Footer
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
}
