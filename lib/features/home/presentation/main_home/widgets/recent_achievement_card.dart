import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_club/component/text/common_text.dart';
import 'package:football_club/utils/constants/app_images.dart';

class RecentAchievementCard extends StatelessWidget {
  final String category;
  final String achievementTitle;
  final String matchInfo;

  const RecentAchievementCard({
    super.key,
    this.category = 'RECENT ACHIEVEMENT',
    this.achievementTitle = 'Player of the Match',
    this.matchInfo = 'U14 League vs Riverside FC · 5 Feb 2025',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
          width: 1,
        ),
        image: const DecorationImage(
          image: AssetImage(AppImages.acheivement_image),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          gradient: const LinearGradient(
            colors: [
              Color(0xE0081A4A), // #081A4AE0 (88% opacity)
              Color(0x66F59E0B), // #F59E0B66 (40% opacity)
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Row(
          children: [
            // Golden Trophy Icon
            Container(
              padding: EdgeInsets.all(8.r),
              child: Icon(
                Icons.emoji_events_rounded,
                color: const Color(0xFFF59E0B),
                size: 38.sp,
              ),
            ),
            SizedBox(width: 14.w),

            // Achievement Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonText(
                    text: category,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFF59E0B),
                    letterSpacing: 1.0,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 4.h),
                  CommonText(
                    text: achievementTitle,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 4.h),
                  CommonText(
                    text: matchInfo,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withOpacity(0.75),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
