import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_club/component/text/common_text.dart';
import 'package:football_club/features/deployment/presentation/deployment_screen/container/deployment_controller.dart';
import 'package:get/get.dart';

class DevelopmentTimelineView extends StatelessWidget {
  const DevelopmentTimelineView({super.key});

  IconData _getIconForType(String type) {
    switch (type.toUpperCase()) {
      case 'TARGET':
        return Icons.check_circle_outline;
      case 'FEEDBACK':
        return Icons.chat_bubble_outline_rounded;
      case 'ACHIEVEMENT':
        return Icons.emoji_events_outlined;
      case 'ASSESSMENT':
        return Icons.bar_chart_outlined;
      case 'SKILL':
        return Icons.bolt_outlined;
      default:
        return Icons.circle_notifications_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DeploymentController>();

    return Obx(() {
      if (controller.isTimelineLoading.value) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 40.h),
          child: const Center(
            child: CircularProgressIndicator(color: Color(0xFF2563EB)),
          ),
        );
      }

      final items = controller.timelineList;
      if (items.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 40.h),
          child: const Center(
            child: CommonText(
              text: "No timeline records available",
              fontSize: 14,
              color: Color(0xFF8E9BAE),
            ),
          ),
        );
      }

      return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final isLast = index == items.length - 1;
          final iconData = _getIconForType(item.type);

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
                          iconData,
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
                                text: item.title,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(height: 4.h),
                              CommonText(
                                text: item.description,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF8E9BAE),
                                textAlign: TextAlign.start,
                                maxLines: 4,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        CommonText(
                          text: item.date,
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
    });
  }
}
