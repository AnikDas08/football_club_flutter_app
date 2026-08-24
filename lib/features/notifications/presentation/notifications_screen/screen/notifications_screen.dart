import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_club/component/text/common_text.dart';
import 'package:football_club/features/notifications/domain/entity/notification_entity.dart';
import 'package:football_club/features/notifications/presentation/notifications_screen/container/notifications_controller.dart';
import 'package:football_club/features/notifications/presentation/notifications_screen/widgets/notification_item.dart';
import 'package:football_club/utils/constants/app_images.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late final NotificationsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(NotificationsController());
  }

  @override
  Widget build(BuildContext context) {
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

                        // "X unread" badge pill
                        Obx(() {
                          final unreadCount = controller.notifications
                              .where((e) => e.isUnread)
                              .length;
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 5.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: CommonText(
                              text: "$unreadCount unread",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.85),
                            ),
                          );
                        }),
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
              child: Obx(() {
                final items = controller.notifications;

                if (items.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: CommonText(
                        text: "No notifications available",
                        color: Color(0xFF8E9BAE),
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final NotificationEntity item = items[index];

                    return NotificationItemCard(
                      title: item.title,
                      message: item.message,
                      time: item.time,
                      isUnread: item.isUnread,
                      icon: item.icon,
                      iconColor: item.iconColor,
                      onTap: () => controller.markAsRead(item.id),
                    );
                  },
                );
              }),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
