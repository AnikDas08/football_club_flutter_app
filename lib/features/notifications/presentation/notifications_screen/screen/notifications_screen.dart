import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_club/component/text/common_text.dart';
import 'package:football_club/features/notifications/domain/entity/notification_entity.dart';
import 'package:football_club/features/notifications/presentation/notifications_screen/controller/notifications_controller.dart';
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
    controller = Get.isRegistered<NotificationsController>()
        ? Get.find<NotificationsController>()
        : Get.put(NotificationsController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      body: RefreshIndicator(
        color: const Color(0xFF3B82F6),
        backgroundColor: const Color(0xFF0C1427),
        onRefresh: () => controller.refresh(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Top Header with Notification Image background & Gradient
              Container(
                width: double.infinity,
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
                        const Color(0xFF0A0E1A).withValues(alpha: 0.2),
                        const Color(0xFF0A0E1A).withValues(alpha: 0.85),
                        const Color(0xFF0A0E1A),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 12.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
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
                          SizedBox(height: 10.h),

                          // "X unread" badge pill
                          Obx(() {
                            final unreadCount = controller.totalUnreadCount;
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: CommonText(
                                text: "$unreadCount unread",
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withValues(alpha: 0.85),
                              ),
                            );
                          }),
                          SizedBox(height: 6.h),

                          // Main Title
                          const CommonText(
                            text: "Notifications",
                            fontSize: 30,
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
              SizedBox(height: 6.h),

              // 2. Notification Items List Area
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Obx(() {
                  if (controller.isLoading.value &&
                      controller.notifications.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 60),
                      child: Center(
                        child: CupertinoActivityIndicator(
                          color: Colors.white,
                          radius: 14,
                        ),
                      ),
                    );
                  }

                  final items = controller.notifications;

                  if (items.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 60.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.notifications_off_outlined,
                              size: 48.sp,
                              color: const Color(0xFF8E9BAE).withValues(alpha: 0.5),
                            ),
                            SizedBox(height: 12.h),
                            const CommonText(
                              text: "No notifications available",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF8E9BAE),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
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
      ),
    );
  }
}
