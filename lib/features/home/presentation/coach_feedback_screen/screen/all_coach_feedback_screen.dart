import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_club/component/image/common_image.dart';
import 'package:football_club/component/other_widgets/common_shimmer.dart';
import 'package:football_club/component/text/common_text.dart';
import 'package:football_club/features/home/presentation/coach_feedback_screen/container/all_coach_feedback_controller.dart';
import 'package:football_club/utils/constants/app_images.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AllCoachFeedbackScreen extends StatelessWidget {
  const AllCoachFeedbackScreen({super.key});

  String _formatDate(String rawDate) {
    if (rawDate.isEmpty) return '';
    try {
      final dateTime = DateTime.parse(rawDate);
      return DateFormat('dd MMM yyyy').format(dateTime);
    } catch (_) {
      return rawDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllCoachFeedbackController());

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Bar: Back Button & Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  const CommonText(
                    text: "All Coach Feedback",
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ],
              ),
            ),

            // Content Area
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return _buildShimmerList();
                }

                if (controller.notes.isEmpty) {
                  return Center(
                    child: const CommonText(
                      text: "No session notes available",
                      fontSize: 14,
                      color: Color(0xFF8E9BAE),
                    ),
                  );
                }

                return RefreshIndicator(
                  color: const Color(0xFF2563EB),
                  backgroundColor: const Color(0xFF0C1427),
                  onRefresh: () => controller.fetchSessionNotes(isRefresh: true),
                  child: ListView.separated(
                    controller: controller.scrollController,
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    itemCount: controller.notes.length + 1,
                    separatorBuilder: (context, index) => SizedBox(height: 14.h),
                    itemBuilder: (context, index) {
                      if (index == controller.notes.length) {
                        return Obx(() {
                          if (controller.isLoadingMore.value) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xFF2563EB),
                                ),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        });
                      }

                      final item = controller.notes[index];
                      final dateText = _formatDate(item.createdAt);

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
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Coach Avatar
                                Container(
                                  width: 44.w,
                                  height: 44.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xFF2563EB),
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.4),
                                        blurRadius: 8,
                                        spreadRadius: 1,
                                        offset: const Offset(0, 2),
                                      ),
                                      BoxShadow(
                                        color: const Color(0xFF2563EB)
                                            .withOpacity(0.35),
                                        blurRadius: 10,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.all(2.r),
                                  child: ClipOval(
                                    child: CommonImage(
                                      imageSrc: item.coachImage,
                                      fill: BoxFit.cover,
                                      defaultImage: AppImages.coach_image,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12.w),

                                // Name, Category, Date & Feedback Text
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: CommonText(
                                              text: item.coachName.isNotEmpty
                                                  ? item.coachName
                                                  : "Coach",
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          if (dateText.isNotEmpty)
                                            CommonText(
                                              text: dateText,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xFF8E9BAE),
                                            ),
                                        ],
                                      ),
                                      if (item.category.isNotEmpty) ...[
                                        SizedBox(height: 4.h),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8.w,
                                            vertical: 2.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF2563EB)
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(6.r),
                                          ),
                                          child: CommonText(
                                            text: item.category,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF60A5FA),
                                          ),
                                        ),
                                      ],
                                      SizedBox(height: 6.h),
                                      CommonText(
                                        text: item.note,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF8E9BAE),
                                        textAlign: TextAlign.start,
                                        height: 1.4,
                                        maxLines: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12.h),

                            // View Full Note Link
                            Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () => _showCoachFeedbackNoteDialog(
                                  context,
                                  coachName: item.coachName.isNotEmpty
                                      ? item.coachName
                                      : "Coach",
                                  date: dateText,
                                  avatarPath: item.coachImage,
                                  feedback: item.note,
                                  category: item.category,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const CommonText(
                                      text: "View Full Note",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF2563EB),
                                    ),
                                    SizedBox(width: 4.w),
                                    Icon(
                                      Icons.chevron_right,
                                      color: const Color(0xFF2563EB),
                                      size: 16.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerList() {
    return CommonShimmer(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        itemCount: 4,
        separatorBuilder: (context, index) => SizedBox(height: 14.h),
        itemBuilder: (context, index) => Container(
          width: double.infinity,
          padding: EdgeInsets.all(18.w),
          decoration: BoxDecoration(
            color: const Color(0xFF0C1427),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(width: 44.w, height: 44.h, borderRadius: 22.r),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ShimmerBox(width: 120.w, height: 15.h, borderRadius: 4.r),
                            ShimmerBox(width: 60.w, height: 13.h, borderRadius: 4.r),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        ShimmerBox(width: double.infinity, height: 13.h, borderRadius: 4.r),
                        SizedBox(height: 6.h),
                        ShimmerBox(width: 180.w, height: 13.h, borderRadius: 4.r),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Center(
                child: ShimmerBox(width: 110.w, height: 13.h, borderRadius: 4.r),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCoachFeedbackNoteDialog(
    BuildContext context, {
    required String coachName,
    required String date,
    required String avatarPath,
    required String feedback,
    required String category,
  }) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: const Color(0xFF0C1427),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: BorderSide(color: Colors.white.withOpacity(0.12), width: 1),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44.w,
                    height: 44.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF2563EB),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2563EB).withOpacity(0.35),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(2.r),
                    child: ClipOval(
                      child: CommonImage(
                        imageSrc: avatarPath,
                        fill: BoxFit.cover,
                        defaultImage: AppImages.coach_image,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: coachName,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        if (date.isNotEmpty) ...[
                          SizedBox(height: 2.h),
                          CommonText(
                            text: date,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF8E9BAE),
                          ),
                        ],
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close_rounded,
                      color: const Color(0xFF8E9BAE),
                      size: 22.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Divider(height: 1, color: Colors.white.withOpacity(0.08)),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CommonText(
                    text: "Full Coach Note",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  if (category.isNotEmpty)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2563EB).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: CommonText(
                        text: category,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF60A5FA),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 8.h),
              Flexible(
                child: SingleChildScrollView(
                  child: CommonText(
                    text: feedback,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFCBD5E1),
                    textAlign: TextAlign.start,
                    height: 1.5,
                    maxLines: 50,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF081A4A), Color(0xFF165DFF)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  alignment: Alignment.center,
                  child: const CommonText(
                    text: "Close",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
