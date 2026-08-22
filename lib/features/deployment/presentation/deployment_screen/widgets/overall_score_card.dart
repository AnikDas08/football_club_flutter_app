import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../component/text/common_text.dart';

class OverallScoreCard extends StatelessWidget {
  final double score;
  final double maxScore;
  final String improvement;
  final String status;

  const OverallScoreCard({
    super.key,
    this.score = 8.2,
    this.maxScore = 10.0,
    this.improvement = '+6.1%',
    this.status = 'Excellent',
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
            text: "Overall Score",
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              // Segmented circular score gauge
              SizedBox(
                width: 72.w,
                height: 72.h,
                child: CustomPaint(
                  painter: SegmentedCircularProgressPainter(
                    progress: maxScore > 0 ? (score / maxScore).clamp(0.0, 1.0) : 0.0,
                    gradientColors: const [Color(0xFF1D4ED8), Color(0xFF2563EB)],
                    inactiveColor: const Color(0xFF0F265C),
                    strokeWidth: 4.w,
                    totalSegments: 4,
                    gapAngleDegree: 14.0,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonText(
                          text: score % 1 == 0 ? score.toInt().toString() : score.toStringAsFixed(1),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        CommonText(
                          text: "/${maxScore.toInt()}",
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF8E9BAE),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),

              // Improvement details and badge
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CommonText(
                          text: "Monthly improvement",
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF8E9BAE),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF052E16),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: const Color(0xFF15803D),
                              width: 1,
                            ),
                          ),
                          child: CommonText(
                            text: status,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF22C55E),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    CommonText(
                      text: improvement,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF10B981),
                    ),
                    SizedBox(height: 2.h),
                    const CommonText(
                      text: "vs last month",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF8E9BAE),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Custom painter to draw segmented circular progress indicator matching design
class SegmentedCircularProgressPainter extends CustomPainter {
  final double progress;
  final List<Color> gradientColors;
  final Color inactiveColor;
  final double strokeWidth;
  final int totalSegments;
  final double gapAngleDegree;

  SegmentedCircularProgressPainter({
    required this.progress,
    required this.gradientColors,
    required this.inactiveColor,
    required this.strokeWidth,
    this.totalSegments = 4,
    this.gapAngleDegree = 14.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final gapAngle = gapAngleDegree * (pi / 180.0);
    final totalGapAngle = gapAngle * totalSegments;
    final segmentSweepAngle = (2 * pi - totalGapAngle) / totalSegments;

    // Start angle at top (-pi / 2), shifted by half a gap so segments are centered symmetrically
    double startAngle = -pi / 2 + (gapAngle / 2);

    final activePaint = Paint()
      ..shader = LinearGradient(
        colors: gradientColors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final inactivePaint = Paint()
      ..color = inactiveColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < totalSegments; i++) {
      final segmentStartProgress = i / totalSegments;
      final segmentEndProgress = (i + 1) / totalSegments;

      // Draw background inactive arc
      canvas.drawArc(rect, startAngle, segmentSweepAngle, false, inactivePaint);

      // Draw active arc over background if progress reaches segment
      if (progress > segmentStartProgress) {
        double activeSweep = segmentSweepAngle;
        if (progress < segmentEndProgress) {
          final fraction =
              (progress - segmentStartProgress) /
              (segmentEndProgress - segmentStartProgress);
          activeSweep = segmentSweepAngle * fraction;
        }

        canvas.drawArc(rect, startAngle, activeSweep, false, activePaint);
      }

      startAngle += segmentSweepAngle + gapAngle;
    }
  }

  @override
  bool shouldRepaint(covariant SegmentedCircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.gradientColors != gradientColors ||
        oldDelegate.inactiveColor != inactiveColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
