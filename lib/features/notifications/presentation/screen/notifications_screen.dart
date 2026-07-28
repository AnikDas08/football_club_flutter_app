import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_images.dart';
import '../../../../utils/extensions/extension.dart';
import '../controller/notifications_controller.dart';
import '../../data/model/notification_model.dart';
import '../widgets/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationsController());

    final List<Map<String, dynamic>> defaultNotifications = [
      {
        "title": "New Coach Note",
        "message": "Coach Davies added feedback from your Tuesday session.",
        "time": "2h ago",
        "isUnread": true,
        "icon": Icons.chat_bubble_outline_rounded,
        "iconColor": const Color(0xFF3B82F6),
      },
      {
        "title": "Achievement Unlocked! 🏆",
        "message": "You earned Player of the Match vs Riverside FC.",
        "time": "1d ago",
        "isUnread": true,
        "icon": Icons.emoji_events_outlined,
        "iconColor": const Color(0xFFF59E0B),
      },
      {
        "title": "Upcoming Training",
        "message": "Training session tomorrow at 6:00 PM — TFP Academy.",
        "time": "2d ago",
        "isUnread": false,
        "icon": Icons.show_chart_rounded,
        "iconColor": const Color(0xFF10B981),
      },
      {
        "title": "Target Updated",
        "message": "Coach updated your Pressing Intensity target to 50%.",
        "time": "3d ago",
        "isUnread": false,
        "icon": Icons.track_changes,
        "iconColor": const Color(0xFFA855F7),
      },
      {
        "title": "Assessment Due",
        "message": "Your monthly assessment is due in 3 days.",
        "time": "4d ago",
        "isUnread": false,
        "icon": Icons.bar_chart_rounded,
        "iconColor": const Color(0xFFF97316),
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Top Header with Notification Image background & Gradient
            Container(
              width: double.infinity,
              height: 250.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.notification_image),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF0A0E1A).withOpacity(0.2),
                      const Color(0xFF0A0E1A).withOpacity(0.85),
                      const Color(0xFF0A0E1A),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 12.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Back button header
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.adaptive.arrow_back,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                              SizedBox(width: 6.w),
                              const CommonText(
                                text: "Back",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),

                        // "2 unread" badge pill
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 5.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: CommonText(
                            text: "2 unread",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.85),
                          ),
                        ),
                        SizedBox(height: 8.h),

                        // Main Title
                        const CommonText(
                          text: "Notifications",
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // 2. Notification Items List Area
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: GetBuilder<NotificationsController>(
                builder: (controller) {
                  if (controller.notifications.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.notifications.length,
                      itemBuilder: (context, index) {
                        final NotificationModel item =
                            controller.notifications[index];
                        return NotificationItemCard(
                          title: item.type.isNotEmpty
                              ? item.type
                              : "Notification",
                          message: item.message,
                          time: item.createdAt.checkTime,
                          isUnread: index < 2,
                        );
                      },
                    );
                  }

                  // Default matching list from design screenshot
                  return Column(
                    children: defaultNotifications.map((data) {
                      return NotificationItemCard(
                        title: data["title"] as String,
                        message: data["message"] as String,
                        time: data["time"] as String,
                        isUnread: data["isUnread"] as bool,
                        icon: data["icon"] as IconData,
                        iconColor: data["iconColor"] as Color?,
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
