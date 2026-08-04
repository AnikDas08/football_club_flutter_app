import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_club/component/image/common_image.dart';
import 'package:football_club/component/text/common_text.dart';

class PlayerProgressCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String level;
  final String subtitle;
  final double progress;
  final String? progressText;
  final List<Color> progressGradientColors;

  const PlayerProgressCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.level,
    required this.subtitle,
    required this.progress,
    this.progressText,
    this.progressGradientColors = const [Color(0xFF081A4A), Color(0xFF1239D4)],
  });

  @override
  Widget build(BuildContext context) {
    final displayPercentage = progressText ?? '${(progress * 100).toInt()}%';
    final accentBlue = progressGradientColors.last;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0C1427).withOpacity(0.85),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withOpacity(0.08), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Profile image with clean white border frame
          Container(
            width: 64.w,
            height: 64.h,
            padding: EdgeInsets.all(2.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(color: Colors.white, width: 1.5),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: CommonImage(
                imageSrc: imagePath,
                fill: BoxFit.cover,
                width: 60.w,
                height: 60.h,
              ),
            ),
          ),
          SizedBox(width: 14.w),

          // 2. Center info details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Name
                CommonText(
                  text: name,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                SizedBox(height: 5.h),

                // Level Badge Pill
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 3.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFAE00),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: CommonText(
                    text: level,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 6.h),

                // Subtitle
                CommonText(
                  text: subtitle,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF8E9BAE),
                ),
                SizedBox(height: 10.h),

                // Linear Progress Bar + percentage text
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 7.h,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FractionallySizedBox(
                            widthFactor: progress.clamp(0.0, 1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: progressGradientColors,
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    CommonText(
                      text: displayPercentage,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: accentBlue,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 14.w),

          // 3. Circular segmented gauge on the right with gradient painter
          SizedBox(
            width: 52.w,
            height: 52.h,
            child: CustomPaint(
              painter: SegmentedCircularProgressPainter(
                progress: progress,
                gradientColors: progressGradientColors,
                inactiveColor: const Color(0xFF0F265C),
                strokeWidth: 3.5.w,
                totalSegments: 4,
                gapAngleDegree: 14.0,
              ),
              child: Center(
                child: CommonText(
                  text: displayPercentage,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: accentBlue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter to draw a segmented circular progress indicator with linear gradient.
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

      canvas.drawArc(rect, startAngle, segmentSweepAngle, false, inactivePaint);

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
