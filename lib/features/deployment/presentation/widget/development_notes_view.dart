import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_images.dart';

class DevelopmentNotesView extends StatelessWidget {
  const DevelopmentNotesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildNoteCard(
          coachName: "Mike Davies",
          timestamp: "14 Feb 2025 · 6:30 PM",
          badgeText: "Positive",
          badgeColor: const Color(0xFF22C55E),
          badgeBgColor: const Color(0xFF052E16),
          bodyText:
              "Outstanding positioning in the second half. James read the game brilliantly and created three goal-scoring opportunities through intelligent runs.",
        ),
        SizedBox(height: 14.h),
        _buildNoteCard(
          coachName: "Mike Davies",
          timestamp: "10 Feb 2025 · 6:45 PM",
          badgeText: "Improvement",
          badgeColor: const Color(0xFFF59E0B),
          badgeBgColor: const Color(0xFF451A03),
          bodyText:
              "Work on weak foot finishing. Left-foot shots need more accuracy under pressure. Set extra reps at end of session next week.",
        ),
        SizedBox(height: 14.h),
        _buildNoteCard(
          coachName: "Mike Davies",
          timestamp: "10 Feb 2025 · 6:45 PM",
          badgeText: "Positive",
          badgeColor: const Color(0xFF22C55E),
          badgeBgColor: const Color(0xFF052E16),
          bodyText:
              "James showed excellent leadership qualities, organising teammates and communicating clearly throughout small-sided games.",
        ),
        SizedBox(height: 24.h),
      ],
    );
  }

  Widget _buildNoteCard({
    required String coachName,
    required String timestamp,
    required String badgeText,
    required Color badgeColor,
    required Color badgeBgColor,
    required String bodyText,
  }) {
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
          // Header Row: Avatar + Name + Timestamp & Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 36.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.2),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        AppImages.coach_image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: coachName,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      CommonText(
                        text: timestamp,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF8E9BAE),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: badgeBgColor,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: CommonText(
                  text: badgeText,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: badgeColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),

          // Body text note
          CommonText(
            text: bodyText,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: const Color(0xFFCBD5E1),
            textAlign: TextAlign.start,
            maxLines: 4,
            height: 1.4,
          ),
        ],
      ),
    );
  }
}
