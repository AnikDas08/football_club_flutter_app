import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_club/component/text/common_text.dart';
import 'package:football_club/features/deployment/domain/entity/deployment_entity.dart';

class CoreDevelopmentAreasCard extends StatelessWidget {
  final List<DevelopmentAreaItem> areas;

  const CoreDevelopmentAreasCard({
    super.key,
    required this.areas,
  });

  @override
  Widget build(BuildContext context) {
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
          const CommonText(
            text: "Core Development Areas",
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          SizedBox(height: 16.h),
          Column(
            children: areas.map((item) {
              final double progress = item.progress;
              final double score = item.score;
              final String scoreText =
                  score % 1 == 0 ? score.toInt().toString() : score.toString();

              return Padding(
                padding: EdgeInsets.only(bottom: 14.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              item.icon,
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            SizedBox(width: 8.w),
                            CommonText(
                              text: item.name,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFFCBD5E1),
                            ),
                          ],
                        ),
                        CommonText(
                          text: scoreText,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF8E9BAE),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      height: 5.h,
                      width: double.infinity,
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
                              color: const Color(0xFF165DFF),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
