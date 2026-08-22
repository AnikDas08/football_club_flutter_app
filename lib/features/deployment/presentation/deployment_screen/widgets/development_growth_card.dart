import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_club/component/text/common_text.dart';

class DevelopmentGrowthCard extends StatelessWidget {
  final List<String> months;
  final List<double> values;

  const DevelopmentGrowthCard({
    super.key,
    required this.months,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> yAxisLabels = ["9", "8.25", "7.5", "6.75", "6"];

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
            text: "Development Growth",
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 140.h,
            child: Row(
              children: [
                // Y-Axis Labels
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: yAxisLabels.map((label) {
                    return CommonText(
                      text: label,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF8E9BAE),
                    );
                  }).toList(),
                ),
                SizedBox(width: 12.w),

                // Chart Area
                Expanded(
                  child: CustomPaint(
                    size: Size.infinite,
                    painter: GrowthChartPainter(
                      values: values,
                      minY: 0.0,
                      maxY: values.isNotEmpty && values.reduce((a, b) => a > b ? a : b) > 10
                          ? values.reduce((a, b) => a > b ? a : b)
                          : 10.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),

          // X-Axis Month Labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 24.w), // offset for Y-axis width
              ...months.map((month) {
                return Expanded(
                  child: Center(
                    child: CommonText(
                      text: month,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF8E9BAE),
                    ),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}

class GrowthChartPainter extends CustomPainter {
  final List<double> values;
  final double minY;
  final double maxY;

  GrowthChartPainter({
    required this.values,
    required this.minY,
    required this.maxY,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;

    final linePaint = Paint()
      ..color = const Color(0xFF2563EB)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final dotPaint = Paint()
      ..color = const Color(0xFF2563EB)
      ..style = PaintingStyle.fill;

    final dotOutlinePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final double widthStep = values.length > 1 ? size.width / (values.length - 1) : size.width;
    final List<Offset> points = [];

    final double range = maxY - minY;
    for (int i = 0; i < values.length; i++) {
      final double x = values.length > 1 ? i * widthStep : size.width / 2;
      final double normalizedY = range > 0 ? (values[i] - minY) / range : 0.0;
      final double y = size.height - (normalizedY * size.height);
      points.add(Offset(x, y));
    }

    // Draw smooth curve using cubic bezier path
    final path = Path();
    path.moveTo(points[0].dx, points[0].dy);

    for (int i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];
      final controlPoint1 = Offset(p0.dx + widthStep / 2, p0.dy);
      final controlPoint2 = Offset(p1.dx - widthStep / 2, p1.dy);
      path.cubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        p1.dx,
        p1.dy,
      );
    }

    canvas.drawPath(path, linePaint);

    // Draw data point dots
    for (final point in points) {
      canvas.drawCircle(point, 4.0, dotPaint);
      canvas.drawCircle(point, 4.0, dotOutlinePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
