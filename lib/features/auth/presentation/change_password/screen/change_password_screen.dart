import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_club/component/text/common_text.dart';
import 'package:football_club/component/text_field/common_text_field.dart';
import 'package:football_club/features/auth/presentation/change_password/container/change_password_controller.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePasswordController>(
      init: ChangePasswordController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFF0A0E1A),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Back Button
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

                    // 2. Page Title
                    const CommonText(
                      text: "Change Password",
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    SizedBox(height: 24.h),

                    // 3. OLD PASSWORD
                    _buildFieldLabel("CURRENT PASSWORD"),
                    CommonTextField(
                      controller: controller.currentPasswordController,
                      hintText: "At least 8 characters",
                      isPassword: true,
                      isDark: true,
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded,
                        size: 18.sp,
                        color: const Color(0xFF8E9BAE),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // 4. NEW PASSWORD
                    _buildFieldLabel("NEW PASSWORD"),
                    CommonTextField(
                      controller: controller.newPasswordController,
                      hintText: "At least 8 characters",
                      isPassword: true,
                      isDark: true,
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded,
                        size: 18.sp,
                        color: const Color(0xFF8E9BAE),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // 5. CONFIRM PASSWORD
                    _buildFieldLabel("CONFIRM PASSWORD"),
                    CommonTextField(
                      controller: controller.confirmPasswordController,
                      hintText: "Re-enter password",
                      isPassword: true,
                      isDark: true,
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded,
                        size: 18.sp,
                        color: const Color(0xFF8E9BAE),
                      ),
                    ),
                    SizedBox(height: 28.h),

                    // 6. Save Changes Button
                    GestureDetector(
                      onTap: controller.isLoading
                          ? null
                          : () {
                              controller.changePassword();
                            },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF081A4A), Color(0xFF165DFF)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                        alignment: Alignment.center,
                        child: controller.isLoading
                            ? SizedBox(
                                width: 20.w,
                                height: 20.h,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const CommonText(
                                text: "Save Changes",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: CommonText(
        text: label,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF8E9BAE),
        letterSpacing: 0.5,
      ),
    );
  }
}
