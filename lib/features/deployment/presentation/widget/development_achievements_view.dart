import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../component/text/common_text.dart';

class DevelopmentAchievementsView extends StatelessWidget {
  const DevelopmentAchievementsView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> achievements = [
      {
        "icon": "🏆",
        "title": "Player of the Match",
        "category": "Match Awards",
        "status": "x4",
        "statusColor": const Color(0xFFFACC15),
      },
      {
        "icon": "⭐",
        "title": "Player of the Week",
        "category": "Weekly",
        "status": "x2",
        "statusColor": const Color(0xFFFACC15),
      },
      {
        "icon": "🥇",
        "title": "Top Scorer - Jan",
        "category": "Tournament",
        "status": "✔",
        "statusColor": const Color(0xFF10B981),
      },
      {
        "icon": "📈",
        "title": "Most Improved",
        "category": "Academy",
        "status": "✔",
        "statusColor": const Color(0xFF10B981),
      },
      {
        "icon": "🎖",
        "title": "Team Captain",
        "category": "Team Awards",
        "status": "x3",
        "statusColor": const Color(0xFF2563EB),
      },
      {
        "icon": "🎯",
        "title": "40 Sessions Milestone",
        "category": "Season",
        "status": "✔",
        "statusColor": const Color(0xFF10B981),
      },
    ];

    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1.15,
      ),
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        final item = achievements[index];

        return Container(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: const Color(0xFF0C1427).withOpacity(0.85),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.08),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item["icon"] as String,
                style: TextStyle(fontSize: 26.sp),
              ),
              SizedBox(height: 8.h),
              CommonText(
                text: item["title"] as String,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                maxLines: 1,
              ),
              SizedBox(height: 2.h),
              CommonText(
                text: item["category"] as String,
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF8E9BAE),
              ),
              SizedBox(height: 6.h),
              CommonText(
                text: item["status"] as String,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: item["statusColor"] as Color,
              ),
            ],
          ),
        );
      },
    );
  }
}
