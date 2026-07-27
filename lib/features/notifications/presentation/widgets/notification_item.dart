import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../component/text/common_text.dart';

class NotificationItemCard extends StatelessWidget {
  final String title;
  final String message;
  final String time;
  final bool isUnread;
  final IconData icon;
  final Color? iconColor;
  final VoidCallback? onTap;

  const NotificationItemCard({
    super.key,
    required this.title,
    required this.message,
    required this.time,
    this.isUnread = false,
    this.icon = Icons.notifications_none_outlined,
    this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardBgColor = isUnread
        ? const Color(0xFF08193E)
        : const Color(0xFF0C1427).withOpacity(0.85);

    final borderColor = isUnread
        ? const Color(0xFF1D4ED8).withOpacity(0.4)
        : Colors.white.withOpacity(0.08);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon circular container
                Container(
                  width: 42.w,
                  height: 42.h,
                  decoration: BoxDecoration(
                    color: isUnread
                        ? const Color(0xFF132B63)
                        : Colors.white.withOpacity(0.06),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    icon,
                    color: iconColor ??
                        (isUnread
                            ? const Color(0xFF3B82F6)
                            : const Color(0xFF8E9BAE)),
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 14.w),

                // Content Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row: Title & Time + Unread indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CommonText(
                              text: title,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Row(
                            children: [
                              CommonText(
                                text: time,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF8E9BAE),
                              ),
                              if (isUnread) ...[
                                SizedBox(width: 6.w),
                                Container(
                                  width: 8.w,
                                  height: 8.h,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF2563EB),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),

                      // Message details body
                      CommonText(
                        text: message,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF8E9BAE),
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        height: 1.3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
