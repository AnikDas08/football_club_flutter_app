import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_club/utils/constants/app_colors.dart';

import '../../../component/text/common_text.dart';
import '../controller/onboarding_controller.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingModel model;

  const OnboardingPage({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(model.image),
          fit: BoxFit.fill,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),

          // Category Tag
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(30.r),
              border: Border.all(
                color: Colors.white.withOpacity(0.15),
                width: 1,
              ),
            ),
            child: CommonText(
              text: model.tag,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.85),
            ),
          ),
          SizedBox(height: 16.h),

          // Title
          CommonText(
            text: model.title,
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            textAlign: TextAlign.start,
            maxLines: 3,
            height: 1.2,
          ),
          SizedBox(height: 16.h),

          // Subtitle
          CommonText(
            text: model.description,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
            textAlign: TextAlign.start,
            maxLines: 5,
            height: 1.5,
          ),
          SizedBox(height: 148.h), // Space for indicator and buttons
        ],
      ),
    );
  }
}
