import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_club/component/text/common_text.dart';
import 'package:football_club/features/deployment/domain/entity/deployment_entity.dart';

class FootballSkillsCard extends StatelessWidget {
  final List<FootballSkillItem> skills;

  const FootballSkillsCard({
    super.key,
    required this.skills,
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
            text: "Football Skills",
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          SizedBox(height: 16.h),
          Column(
            children: skills.map((skill) {
              final int starCount = skill.stars;
              final String scoreText = skill.score;

              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Skill name
                    CommonText(
                      text: skill.name,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFCBD5E1),
                    ),

                    // Rating stars & Score
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            return Padding(
                              padding: EdgeInsets.only(right: 3.w),
                              child: Icon(
                                Icons.star_rounded,
                                size: 16.sp,
                                color: index < starCount
                                    ? const Color(0xFFEAB308)
                                    : const Color(0xFF334155),
                              ),
                            );
                          }),
                        ),
                        SizedBox(width: 16.w),
                        Container(
                          width: 24.w,
                          alignment: Alignment.centerRight,
                          child: CommonText(
                            text: scoreText,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF2563EB),
                          ),
                        ),
                      ],
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
