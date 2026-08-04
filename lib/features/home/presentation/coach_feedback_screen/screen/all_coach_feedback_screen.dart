import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_club/component/text/common_text.dart';
import 'package:football_club/features/home/presentation/home_screen/container/home_controller.dart';
import 'package:get/get.dart';

class AllCoachFeedbackScreen extends StatelessWidget {
  const AllCoachFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
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

              // Page Title: All Coach Feedback
              const CommonText(
                text: "All Coach Feedback",
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              SizedBox(height: 20.h),

              // List of Coach Feedback Cards from HomeController / HomeRemoteDataSource
              Obx(() {
                final feedbackList =
                    controller.homeEntity.value?.allCoachFeedbacks ?? [];

                if (feedbackList.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: const CommonText(
                        text: "No coach feedback available",
                        fontSize: 14,
                        color: Color(0xFF8E9BAE),
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: feedbackList.length,
                  separatorBuilder: (context, index) => SizedBox(height: 14.h),
                  itemBuilder: (context, index) {
                    final item = feedbackList[index];

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
                                      color: const Color(
                                        0xFF2563EB,
                                      ).withOpacity(0.35),
                                      blurRadius: 10,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(2.r),
                                child: ClipOval(
                                  child: Image.asset(
                                    item.avatarPath,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.w),

                              // Name, Date & Feedback Text
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CommonText(
                                          text: item.coachName,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                        CommonText(
                                          text: item.date,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF8E9BAE),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6.h),
                                    CommonText(
                                      text: item.feedback,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF8E9BAE),
                                      textAlign: TextAlign.start,
                                      height: 1.4,
                                      maxLines: 10,
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
                                coachName: item.coachName,
                                date: item.date,
                                avatarPath: item.avatarPath,
                                feedback: item.feedback,
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
                );
              }),
              SizedBox(height: 24.h),
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
                      child: Image.asset(avatarPath, fit: BoxFit.cover),
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
                        SizedBox(height: 2.h),
                        CommonText(
                          text: date,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF8E9BAE),
                        ),
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
              const CommonText(
                text: "Full Coach Note",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
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
