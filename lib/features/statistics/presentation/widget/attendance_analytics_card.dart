import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_images.dart';

class AttendanceAnalyticsCard extends StatelessWidget {
  const AttendanceAnalyticsCard({super.key});

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
            text: "Attendance Analytics",
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              // 1. Donut Chart
              SizedBox(
                width: 100.w,
                height: 100.h,
                child: CustomPaint(
                  painter: DonutChartPainter(
                    sections: [
                      DonutSection(percentage: 0.87, color: const Color(0xFF165DFF)),
                      DonutSection(percentage: 0.08, color: const Color(0xFFEF4444)),
                      DonutSection(percentage: 0.05, color: const Color(0xFFF59E0B)),
                    ],
                    strokeWidth: 10.w,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CommonText(
                          text: "87%",
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        CommonText(
                          text: "Attendance\nrate",
                          fontSize: 9,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF8E9BAE),
                          textAlign: TextAlign.center,
                          height: 1.1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),

              // 2. Legend Items Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLegendItem(
                      color: const Color(0xFF165DFF),
                      label: "Attended",
                      value: "87%",
                    ),
                    SizedBox(height: 8.h),
                    _buildLegendItem(
                      color: const Color(0xFFEF4444),
                      label: "Missed",
                      value: "8%",
                    ),
                    SizedBox(height: 8.h),
                    _buildLegendItem(
                      color: const Color(0xFFF59E0B),
                      label: "Late",
                      value: "5%",
                    ),
                  ],
                ),
              ),

              // 3. Player Image Right Side
              Container(
                width: 60.w,
                height: 85.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.asset(
                    "assets/images/player_image.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem({
    required Color color,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 6.w),
        CommonText(
          text: label,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF8E9BAE),
        ),
        SizedBox(width: 6.w),
        CommonText(
          text: value,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ],
    );
  }
}

class DonutSection {
  final double percentage;
  final Color color;

  DonutSection({required this.percentage, required this.color});
}

class DonutChartPainter extends CustomPainter {
  final List<DonutSection> sections;
  final double strokeWidth;

  DonutChartPainter({required this.sections, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    double startAngle = -pi / 2;
    final gapAngle = 0.06; // small gap between donut segments

    for (final section in sections) {
      final sweepAngle = (2 * pi * section.percentage) - gapAngle;

      final paint = Paint()
        ..color = section.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;

      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
      startAngle += sweepAngle + gapAngle;
    }
  }

  @override
  bool shouldRepaint(covariant DonutChartPainter oldDelegate) => false;
}
