import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_club/component/text/common_text.dart';
import 'package:football_club/config/api/api_end_point.dart';
import 'package:football_club/features/deployment/presentation/deployment_screen/controller/deployment_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DevelopmentNotesView extends StatelessWidget {
  const DevelopmentNotesView({super.key});

  Widget _buildCoachAvatar(String path) {
    final clean = path.trim();
    if (clean.isEmpty) {
      return Container(
        width: 36.w,
        height: 36.h,
        color: const Color(0xFF111A2E),
        alignment: Alignment.center,
        child: Icon(Icons.person_rounded, color: const Color(0xFF8E9BAE), size: 18.sp),
      );
    }

    if (File(clean).existsSync()) {
      return Image.file(
        File(clean),
        fit: BoxFit.cover,
        width: 36.w,
        height: 36.h,
        errorBuilder: (context, error, stackTrace) => Container(
          width: 36.w,
          height: 36.h,
          color: const Color(0xFF111A2E),
          alignment: Alignment.center,
          child: Icon(Icons.person_rounded, color: const Color(0xFF8E9BAE), size: 18.sp),
        ),
      );
    }

    final fullUrl = ApiEndPoint.getFullImageUrl(clean);
    debugPrint('📸 [Development Notes Coach Avatar URL]: "$fullUrl" (Raw: "$path")');

    if (fullUrl.isNotEmpty && fullUrl.startsWith('http')) {
      return Image.network(
        fullUrl,
        fit: BoxFit.cover,
        width: 36.w,
        height: 36.h,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: 36.w,
            height: 36.h,
            color: const Color(0xFF111A2E),
            alignment: Alignment.center,
            child: Icon(Icons.person_rounded, color: const Color(0xFF8E9BAE), size: 18.sp),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          debugPrint('❌ [Image.network Error - Development Note Coach]: $error | URL: $fullUrl');
          return Container(
            width: 36.w,
            height: 36.h,
            color: const Color(0xFF111A2E),
            alignment: Alignment.center,
            child: Icon(Icons.person_rounded, color: const Color(0xFF8E9BAE), size: 18.sp),
          );
        },
      );
    }

    return Container(
      width: 36.w,
      height: 36.h,
      color: const Color(0xFF111A2E),
      alignment: Alignment.center,
      child: Icon(Icons.person_rounded, color: const Color(0xFF8E9BAE), size: 18.sp),
    );
  }

  String _formatTimestamp(String rawDate) {
    if (rawDate.isEmpty) return '';
    try {
      final dateTime = DateTime.parse(rawDate);
      return DateFormat('dd MMM yyyy · h:mm a').format(dateTime);
    } catch (_) {
      return rawDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DeploymentController>();

    return Obx(() {
      if (controller.isNotesLoading.value) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 40.h),
          child: const Center(
            child: CupertinoActivityIndicator(color: Colors.white, radius: 14),
          ),
        );
      }

      final notesList = controller.notesList;
      if (notesList.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 40.h),
          child: const Center(
            child: CommonText(
              text: "No session notes available",
              fontSize: 14,
              color: Color(0xFF8E9BAE),
            ),
          ),
        );
      }

      return Column(
        children: notesList.map((item) {
          final timestampText = _formatTimestamp(item.createdAt);

          return Padding(
            padding: EdgeInsets.only(bottom: 14.h),
            child: _buildNoteCard(
              coachName: item.coachName.isNotEmpty
                  ? item.coachName
                  : "Coach",
              coachAvatar: item.coachImage,
              timestamp: timestampText,
              badgeText: item.category.isNotEmpty ? item.category : "Feedback",
              badgeColor: const Color(0xFF60A5FA),
              badgeBgColor: const Color(0xFF2563EB).withOpacity(0.2),
              bodyText: item.note,
            ),
          );
        }).toList(),
      );
    });
  }

  Widget _buildNoteCard({
    required String coachName,
    required String coachAvatar,
    required String timestamp,
    required String badgeText,
    required Color badgeColor,
    required Color badgeBgColor,
    required String bodyText,
  }) {
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
          // Header Row: Avatar + Name + Timestamp & Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 36.w,
                      height: 36.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.2),
                      ),
                      child: ClipOval(
                        child: _buildCoachAvatar(coachAvatar),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: coachName,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            textAlign: TextAlign.start,
                          ),
                          if (timestamp.isNotEmpty)
                            CommonText(
                              text: timestamp,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF8E9BAE),
                              textAlign: TextAlign.start,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              if (badgeText.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: badgeBgColor,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: CommonText(
                    text: badgeText,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: badgeColor,
                  ),
                ),
            ],
          ),
          SizedBox(height: 14.h),

          // Body text note
          CommonText(
            text: bodyText,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: const Color(0xFFCBD5E1),
            textAlign: TextAlign.start,
            maxLines: 10,
            height: 1.4,
          ),
        ],
      ),
    );
  }
}
