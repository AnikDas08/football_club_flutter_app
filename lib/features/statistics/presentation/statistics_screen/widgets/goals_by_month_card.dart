import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_club/component/text/common_text.dart';
import 'package:football_club/features/statistics/domain/entity/statistics_entity.dart';

class GoalsByMonthCard extends StatelessWidget {
  final List<GoalMonthItem> goalsByMonth;

  const GoalsByMonthCard({
    super.key,
    required this.goalsByMonth,
  });

  @override
  Widget build(BuildContext context) {
    int maxValue = 4;
    if (goalsByMonth.isNotEmpty) {
      final highest = goalsByMonth.map((e) => e.value).reduce((a, b) => a > b ? a : b);
      if (highest > maxValue) maxValue = highest;
    }

    final List<String> yAxisLabels = [
      maxValue.toString(),
      (maxValue * 0.75).round().toString(),
      (maxValue * 0.5).round().toString(),
      (maxValue * 0.25).round().toString(),
      "0"
    ];

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
            text: "Goals by Month",
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 140.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Y-Axis Labels
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: yAxisLabels.map((label) {
                    return CommonText(
                      text: label,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF8E9BAE),
                    );
                  }).toList(),
                ),
                SizedBox(width: 16.w),

                // Bar Chart Area
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: goalsByMonth.map((item) {
                      final int val = item.value;
                      final double heightFactor = val / maxValue;

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: FractionallySizedBox(
                                heightFactor: heightFactor.clamp(0.05, 1.0),
                                child: Container(
                                  width: 20.w,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF081A4A),
                                        Color(0xFF165DFF),
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          CommonText(
                            text: item.month,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF8E9BAE),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
