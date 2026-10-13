import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../config/route/app_routes.dart';
import '../../features/notifications/presentation/notifications_screen/controller/notifications_controller.dart';

class NotificationBellButton extends StatelessWidget {
  const NotificationBellButton({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationsController controller =
        Get.isRegistered<NotificationsController>()
            ? Get.find<NotificationsController>()
            : Get.put(NotificationsController());

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.notifications),
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: const Color(0xFF0C1322).withValues(alpha: 0.6),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
        child: Center(
          child: Obx(() {
            final hasUnread = controller.hasUnread;
            return Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.white,
                  size: 22.sp,
                ),
                if (hasUnread)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 8.w,
                      height: 8.h,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2563EB),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
