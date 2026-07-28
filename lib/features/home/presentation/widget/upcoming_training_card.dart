import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_images.dart';

class UpcomingTrainingCard extends StatelessWidget {
  final String title;
  final String daysLeftText;
  final String dateText;
  final String locationText;
  final String coachName;
  final String coachAvatar;

  const UpcomingTrainingCard({
    super.key,
    this.title = 'Upcoming Training',
    this.daysLeftText = '2 days',
    this.dateText = 'Tuesday, 18 Feb · 6:00 PM',
    this.locationText = 'TFP Academy, Manchester',
    this.coachName = 'Coach Jay Railton',
    this.coachAvatar = AppImages.coach_image,
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
          image: AssetImage(AppImages.upcomming_image),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xDE000000), // #000000 with 87% opacity
              Color(0x8C1239D4), // #1239D4 with 55% opacity
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Top Header Row: Icon + Title & Days Left Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 28.w,
                      height: 28.h,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.white,
                        size: 14.sp,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    CommonText(
                      text: title,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: CommonText(
                    text: daysLeftText,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // 2. Training Date Details
            Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.white.withOpacity(0.7),
                  size: 16.sp,
                ),
                SizedBox(width: 8.w),
                CommonText(
                  text: dateText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ],
            ),
            SizedBox(height: 8.h),

            // 3. Location Details
            Row(
              children: [
                Icon(
                  Icons.location_on_rounded,
                  color: const Color(0xFFEF4444),
                  size: 16.sp,
                ),
                SizedBox(width: 8.w),
                CommonText(
                  text: locationText,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.85),
                ),
              ],
            ),
            SizedBox(height: 18.h),

            // 4. Coach Avatar & Name Footer
            Row(
              children: [
                Container(
                  width: 36.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 8,
                        spreadRadius: 1,
                        offset: const Offset(0, 2),
                      ),
                      BoxShadow(
                        color: const Color(0xFF2563EB).withOpacity(0.35),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      coachAvatar,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                CommonText(
                  text: coachName,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
