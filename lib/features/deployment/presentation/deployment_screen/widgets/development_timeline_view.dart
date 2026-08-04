import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../component/text/common_text.dart';

class DevelopmentTimelineView extends StatelessWidget {
  const DevelopmentTimelineView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        "icon": Icons.chat_bubble_outline_rounded,
        "title": "Coach Feedback Added",
        "subtitle": "Strong positioning noted by Coach Davies",
        "date": "14 Feb",
      },
      {
        "icon": Icons.bar_chart_outlined,
        "title": "Assessment Updated",
        "subtitle": "Overall score improved from 7.8 → 8.2",
        "date": "10 Feb",
      },
      {
        "icon": Icons.emoji_events_outlined,
        "title": "Player of the Match",
        "subtitle": "U14 League vs Riverside FC",
        "date": "5 Feb",
      },
      {
        "icon": Icons.check_circle_outline,
        "title": "Target Completed",
        "subtitle": "Ball Retention Under Pressure",
        "date": "28 Jan",
      },
      {
        "icon": Icons.bolt_outlined,
        "title": "Skill Improvement",
        "subtitle": "Football IQ +0.5 stars recorded",
        "date": "20 Jan",
      },
    ];

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final isLast = index == items.length - 1;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left timeline vertical line & circular node
              SizedBox(
                width: 48.w,
                child: Column(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF091C4A),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF1D4ED8),
                          width: 1.5,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        item["icon"] as IconData,
                        color: const Color(0xFF2563EB),
                        size: 18.sp,
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2.w,
                          color: const Color(0xFF1D4ED8).withOpacity(0.4),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),

              // Right Card
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: 14.h),
                  padding: EdgeInsets.all(16.w),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              text: item["title"] as String,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 4.h),
                            CommonText(
                              text: item["subtitle"] as String,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF8E9BAE),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),
                      CommonText(
                        text: item["date"] as String,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF8E9BAE),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
