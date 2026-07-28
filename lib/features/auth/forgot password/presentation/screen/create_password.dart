import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../../../../../utils/helpers/validation.dart';
import '../controller/forget_password_controller.dart';

class CreatePassword extends StatelessWidget {
  CreatePassword({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(
      builder: (controller) {
        final password = controller.passwordController.text;
        final has8Characters = password.length >= 8;
        final hasUppercase = password.contains(RegExp(r'[A-Z]'));
        final hasNumber = password.contains(RegExp(r'[0-9]'));
        final hasSpecialChar = password.contains(
          RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
        );

        Widget buildRuleRow(String ruleText, bool isSatisfied) {
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              children: [
                Container(
                  width: 20.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: isSatisfied
                        ? const Color(0xFF10B981).withOpacity(0.12)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: isSatisfied
                        ? null
                        : Border.all(
                            color: Colors.white.withOpacity(0.15),
                            width: 1.5,
                          ),
                  ),
                  alignment: Alignment.center,
                  child: isSatisfied
                      ? Icon(
                          Icons.check,
                          color: const Color(0xFF10B981),
                          size: 12.sp,
                        )
                      : null,
                ),
                SizedBox(width: 10.w),
                CommonText(
                  text: ruleText,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: isSatisfied
                      ? Colors.white.withOpacity(0.8)
                      : Colors.white.withOpacity(0.25),
                ),
              ],
            ),
          );
        }

        return Scaffold(
          backgroundColor: const Color(0xFF0A0E1A),
          body: SafeArea(
            child: Column(
              children: [
                // Custom Header Back Button
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
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
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 40.h),

                          // Title
                          const CommonText(
                            text: "Set a new password",
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 12.h),

                          // Subtitle
                          CommonText(
                            text:
                                "Choose something strong and unique. We'll keep you logged in on this device.",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.5),
                            textAlign: TextAlign.start,
                            maxLines: 3,
                            height: 1.4,
                          ),
                          SizedBox(height: 32.h),

                          // New Password Label
                          CommonText(
                            text: "NEW PASSWORD",
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withOpacity(0.4),
                            bottom: 8,
                          ),

                          // New Password Field
                          CommonTextField(
                            controller: controller.passwordController,
                            validator: AppValidation.password,
                            isPassword: true,
                            textInputAction: TextInputAction.next,
                            isDark: true,
                            prefixIcon: const Icon(Icons.lock_outline),
                            hintText: "••••••••••",
                            onChanged: (val) {
                              controller
                                  .update(); // Rebuild rules checklist reactively
                            },
                          ),
                          SizedBox(height: 20.h),

                          // Confirm Password Label
                          CommonText(
                            text: "CONFIRM PASSWORD",
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withOpacity(0.4),
                            bottom: 8,
                          ),

                          // Confirm Password Field
                          CommonTextField(
                            controller: controller.confirmPasswordController,
                            validator: (value) => AppValidation.confirmPassword(
                              value,
                              controller.passwordController,
                            ),
                            isPassword: true,
                            textInputAction: TextInputAction.done,
                            isDark: true,
                            prefixIcon: const Icon(Icons.lock_outline),
                            hintText: "••••••••••",
                          ),
                          SizedBox(height: 24.h),

                          // Rules Checklist
                          buildRuleRow("At least 8 characters", has8Characters),
                          buildRuleRow("One uppercase letter", hasUppercase),
                          buildRuleRow("One number", hasNumber),
                          buildRuleRow("One special character", hasSpecialChar),
                          SizedBox(height: 32.h),

                          // Update Password Button
                          CommonButton(
                            titleText: "Update Password",
                            isLoading: controller.isLoading,
                            buttonHeight: 56.h,
                            buttonRadius: 30.r,
                            gradient: const LinearGradient(
                              colors: [Color(0xFF081A4A), Color(0xFF1239D4)],
                            ),
                            onTap: () {
                              /*if (_formKey.currentState!.validate()) {
                                controller.resetPassword();
                              }*/
                              controller.resetPassword();
                            },
                          ),
                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
