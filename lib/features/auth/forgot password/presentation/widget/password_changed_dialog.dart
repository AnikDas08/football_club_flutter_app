import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../config/route/app_routes.dart';
import '../../../../../../component/button/common_button.dart';
import '../../../../../../component/text/common_text.dart';

class PasswordChangedDialog extends StatelessWidget {
  const PasswordChangedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xff011343),
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: const Color(0xFF051129),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: Colors.white.withOpacity(0.08),
            width: 1.2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16.h),
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 80.h,
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    width: 56.h,
                    height: 56.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.check,
                      color: const Color(0xFF10B981),
                      size: 32.sp,
                    ),
                  ),
                ),
                Positioned(
                  top: -10.h,
                  left: -20.w,
                  child: Container(
                    width: 6.w,
                    height: 6.h,
                    decoration: const BoxDecoration(
                      color: Color(0xFF10B981),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  top: 10.h,
                  right: -25.w,
                  child: Container(
                    width: 6.w,
                    height: 6.h,
                    decoration: const BoxDecoration(
                      color: Color(0xFF00C0FF),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10.h,
                  left: -25.w,
                  child: Container(
                    width: 6.w,
                    height: 6.h,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFBBF24),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -5.h,
                  right: -15.w,
                  child: Container(
                    width: 6.w,
                    height: 6.h,
                    decoration: const BoxDecoration(
                      color: Color(0xFF10B981),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            const CommonText(
              text: "Password changed!",
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            SizedBox(height: 12.h),
            CommonText(
              text: "Your password has been updated successfully. You can now log in with your new password.",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.white.withOpacity(0.5),
              textAlign: TextAlign.center,
              maxLines: 3,
              height: 1.4,
            ),
            SizedBox(height: 24.h),
            CommonButton(
              titleText: "Continue to login",
              buttonHeight: 48.h,
              buttonRadius: 24.r,
              gradient: const LinearGradient(
                colors: [Color(0xFF081A4A), Color(0xFF1239D4)],
              ),
              onTap: () {
                Get.offAllNamed(AppRoutes.signIn);
              },
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}
