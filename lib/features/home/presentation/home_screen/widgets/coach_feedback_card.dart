import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_club/component/text/common_text.dart';
import 'package:football_club/config/api/api_end_point.dart';
import 'package:football_club/utils/constants/app_images.dart';

class CoachFeedbackCard extends StatelessWidget {
  final String title;
  final String coachName;
  final String date;
  final String feedback;
  final String avatarPath;
  final VoidCallback? onViewAllTap;
  final VoidCallback? onViewFullNoteTap;

  const CoachFeedbackCard({
    super.key,
    required this.title,
    required this.coachName,
    required this.date,
    required this.feedback,
    required this.avatarPath,
    this.onViewAllTap,
    this.onViewFullNoteTap,
  });

  @override
  Widget build(BuildContext context) {
    final fullCoachUrl = ApiEndPoint.getFullImageUrl(avatarPath);
    debugPrint('📸 [HomeScreen Feedback Coach Avatar Full URL]: "$fullCoachUrl" (Raw: "$avatarPath")');
    final bool hasFeedback = feedback.trim().isNotEmpty;

    if (!hasFeedback) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: title.isNotEmpty ? title : "Latest Coach Feedback",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                if (onViewAllTap != null)
                  GestureDetector(
                    onTap: onViewAllTap,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CommonText(
                          text: 'View All',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2563EB),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.arrow_forward,
                          color: const Color(0xFF2563EB),
                          size: 16.sp,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Icon(
                  Icons.chat_bubble_outline_rounded,
                  color: const Color(0xFF8E9BAE),
                  size: 20.sp,
                ),
                SizedBox(width: 10.w),
                const Expanded(
                  child: CommonText(
                    text: "No coach feedback available yet",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            const CommonText(
              text: "Feedback and evaluation notes from coaches will appear here.",
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF8E9BAE),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Header Row: "Latest Coach Feedback" and "View All ->"
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              text: title,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            GestureDetector(
              onTap: onViewAllTap,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CommonText(
                    text: 'View All',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2563EB),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.arrow_forward,
                    color: const Color(0xFF2563EB),
                    size: 16.sp,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),

        // 2. Coach Feedback Card
        Container(
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
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Coach Profile Avatar with Blue Border Ring
                  Container(
                    width: 44.w,
                    height: 44.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF2563EB),
                        width: 2,
                      ),
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
                    padding: EdgeInsets.all(2.r),
                    child: ClipOval(
                      child: fullCoachUrl.isNotEmpty && fullCoachUrl.startsWith('http')
                          ? Image.network(
                              fullCoachUrl,
                              width: 44.w,
                              height: 44.h,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  width: 44.w,
                                  height: 44.h,
                                  color: const Color(0xFF111A2E),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.person_rounded,
                                    color: const Color(0xFF8E9BAE),
                                    size: 22.sp,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                debugPrint('❌ [Image.network Error - Feedback Coach Avatar]: $error | URL: $fullCoachUrl');
                                return Container(
                                  width: 44.w,
                                  height: 44.h,
                                  color: const Color(0xFF111A2E),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.person_rounded,
                                    color: const Color(0xFF8E9BAE),
                                    size: 22.sp,
                                  ),
                                );
                              },
                            )
                          : Container(
                              width: 44.w,
                              height: 44.h,
                              color: const Color(0xFF111A2E),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.person_rounded,
                                color: const Color(0xFF8E9BAE),
                                size: 22.sp,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(width: 12.w),

                  // Coach Name, Date and Feedback text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonText(
                              text: coachName,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            CommonText(
                              text: date,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF8E9BAE),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        CommonText(
                          text: feedback,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF8E9BAE),
                          maxLines: 3,
                          textAlign: TextAlign.start,
                          height: 1.3,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),

              // "View Full Note >" Link
              GestureDetector(
                onTap: onViewFullNoteTap ??
                    () => showCoachFeedbackNoteDialog(
                          context,
                          coachName: coachName,
                          date: date,
                          avatarPath: avatarPath,
                          feedback: feedback,
                        ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CommonText(
                      text: "View Full Note",
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2563EB),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.chevron_right,
                      color: const Color(0xFF2563EB),
                      size: 16.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void showCoachFeedbackNoteDialog(
    BuildContext context, {
    required String coachName,
    required String date,
    required String avatarPath,
    required String feedback,
  }) {
    final dialogCoachUrl = ApiEndPoint.getFullImageUrl(avatarPath);

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: const Color(0xFF0C1427),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: BorderSide(
            color: Colors.white.withOpacity(0.12),
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44.w,
                    height: 44.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF2563EB),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2563EB).withOpacity(0.35),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(2.r),
                    child: ClipOval(
                      child: dialogCoachUrl.isNotEmpty && dialogCoachUrl.startsWith('http')
                          ? Image.network(
                              dialogCoachUrl,
                              width: 50.w,
                              height: 50.h,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  width: 50.w,
                                  height: 50.h,
                                  color: const Color(0xFF111A2E),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.person_rounded,
                                    color: const Color(0xFF8E9BAE),
                                    size: 24.sp,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                debugPrint('❌ [Image.network Error - Feedback Dialog Avatar]: $error | URL: $dialogCoachUrl');
                                return Container(
                                  width: 50.w,
                                  height: 50.h,
                                  color: const Color(0xFF111A2E),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.person_rounded,
                                    color: const Color(0xFF8E9BAE),
                                    size: 24.sp,
                                  ),
                                );
                              },
                            )
                          : Container(
                              width: 50.w,
                              height: 50.h,
                              color: const Color(0xFF111A2E),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.person_rounded,
                                color: const Color(0xFF8E9BAE),
                                size: 24.sp,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: coachName,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        SizedBox(height: 2.h),
                        CommonText(
                          text: date,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF8E9BAE),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close_rounded,
                      color: const Color(0xFF8E9BAE),
                      size: 22.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Divider(
                height: 1,
                color: Colors.white.withOpacity(0.08),
              ),
              SizedBox(height: 16.h),
              const CommonText(
                text: "Full Coach Note",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              SizedBox(height: 8.h),
              Flexible(
                child: SingleChildScrollView(
                  child: CommonText(
                    text: feedback,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFCBD5E1),
                    textAlign: TextAlign.start,
                    height: 1.5,
                    maxLines: 50,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF081A4A), Color(0xFF165DFF)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  alignment: Alignment.center,
                  child: const CommonText(
                    text: "Close",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
