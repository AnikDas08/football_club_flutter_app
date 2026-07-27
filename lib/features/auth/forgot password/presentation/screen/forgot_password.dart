import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../../config/route/app_routes.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../../../../../utils/helpers/validation.dart';
import '../controller/forget_password_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(
      builder: (controller) => Scaffold(
        backgroundColor: const Color(0xFF0A0E1A),
        body: SafeArea(
          child: Column(
            children: [
              // Custom Header Back Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
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
                          size: 18.sp,
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
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 24.h),

                        // Lock Icon container with glowing border spread
                        Container(
                          width: 64.w,
                          height: 64.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0C1322).withOpacity(0.6),
                            borderRadius: BorderRadius.circular(24.r),
                            border: Border.all(
                              color: const Color(0xFF1239D4),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF1239D4).withOpacity(0.35),
                                blurRadius: 16.r,
                                spreadRadius: 3.r,
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.lock_outline,
                            color: const Color(0xFF2563EB),
                            size: 28.sp,
                          ),
                        ),
                        SizedBox(height: 24.h),

                        // Forgot password title
                        const CommonText(
                          text: "Forgot you password?",
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 12.h),

                        // Subtitle instruction
                        CommonText(
                          text: "Enter the email associated with your TFP account and we'll send you a code",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.5),
                          textAlign: TextAlign.start,
                          maxLines: 3,
                          height: 1.4,
                        ),
                        SizedBox(height: 24.h),

                        // EMAIL label
                        CommonText(
                          text: "EMAIL",
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.4),
                          bottom: 8,
                        ),

                        // Email Text Field
                        CommonTextField(
                          controller: controller.emailController,
                          validator: AppValidation.email,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          isDark: true,
                          prefixIcon: const Icon(Icons.mail_outline),
                          hintText: "lea@mail.com",
                        ),
                        SizedBox(height: 24.h),

                        // Security disclaimer card
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0C1322).withOpacity(0.06),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: const Color(0xFF0084FF33).withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.security_outlined,
                                color: const Color(0xFF0084FF),
                                size: 20.sp,
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: CommonText(
                                  text: "For your security, the code expires in 1 minutes and can only be used once.",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF0084FF),
                                  textAlign: TextAlign.start,
                                  maxLines: 3,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 32.h),

                        // Submit Button
                        CommonButton(
                          titleText: "Send Code",
                          isLoading: controller.isLoading,
                          buttonHeight: 56.h,
                          buttonRadius: 30.r,
                          gradient: const LinearGradient(
                            colors: [Color(0xFF081A4A), Color(0xFF1239D4)],
                          ),
                          onTap: () {
                            /*if (_formKey.currentState!.validate()) {

                            }*/
                            controller.sendForgetPasswordEmail();
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
      ),
    );
  }
}
