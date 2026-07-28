import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_club/config/route/app_routes.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../controller/forget_password_controller.dart';

class VerifyScreen extends StatelessWidget {
  VerifyScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(
      builder: (controller) {
        final minutes = controller.remainingSeconds ~/ 60;
        final seconds = controller.remainingSeconds % 60;

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
                            text: "OTP Verification",
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 12.h),

                          // Subtitle
                          CommonText(
                            text:
                                "Check your email to see the verification code",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.5),
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            height: 1.4,
                          ),
                          SizedBox(height: 48.h),

                          // OTP Pin Code Fields
                          PinCodeTextField(
                            appContext: context,
                            controller: controller.otpController,
                            length: 6,
                            autoFocus: true,
                            keyboardType: TextInputType.number,
                            autoDisposeControllers: false,
                            cursorColor: const Color(0xFF1239D4),
                            validator: (value) {
                              if (value != null && value.length == 6)
                                return null;
                              return "Otp is invalid";
                            },
                            textStyle: GoogleFonts.roboto(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(16.r),
                              fieldHeight: 64.h,
                              fieldWidth: 58.w,
                              borderWidth: 1.5.w,
                              selectedColor: const Color(0xFF1239D4),
                              activeColor: Colors.white.withOpacity(0.17),
                              inactiveColor: Colors.white.withOpacity(0.17),
                              activeFillColor: Colors.white.withOpacity(0.10),
                              selectedFillColor: Colors.white.withOpacity(0.10),
                              inactiveFillColor: Colors.white.withOpacity(0.10),
                            ),
                            enableActiveFill: true,
                            onChanged: (value) {},
                          ),
                          SizedBox(height: 24.h),

                          // Don't receive code prompt
                          Center(
                            child: CommonText(
                              text: "Don't receive the code?",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                          SizedBox(height: 16.h),

                          // Timer & Resend Button Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Timer Capsule
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 10.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF165DFF,
                                  ).withOpacity(0.20),
                                  borderRadius: BorderRadius.circular(16.r),
                                  border: Border.all(
                                    color: const Color(
                                      0xFF165DFF,
                                    ).withOpacity(0.30),
                                    width: 1.2,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CommonText(
                                          text: minutes.toString().padLeft(
                                            2,
                                            '0',
                                          ),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                        SizedBox(height: 2.h),
                                        CommonText(
                                          text: "minutes",
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white.withOpacity(0.5),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                      ),
                                      child: Container(
                                        width: 1.2,
                                        height: 28.h,
                                        color: const Color(
                                          0xFF1239D4,
                                        ).withOpacity(0.5),
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CommonText(
                                          text: seconds.toString().padLeft(
                                            2,
                                            '0',
                                          ),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                        SizedBox(height: 2.h),
                                        CommonText(
                                          text: "seconds",
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white.withOpacity(0.5),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 16.w),

                              // Resend Button
                              TextButton(
                                onPressed: controller.canResendOtp
                                    ? () => controller.sendForgetPasswordEmail()
                                    : null,
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                  ),
                                ),
                                child: CommonText(
                                  text: "Resend",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: controller.canResendOtp
                                      ? const Color(0xFF165DFF)
                                      : const Color(0xFF165DFF),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 48.h),

                          // Verify Button
                          CommonButton(
                            titleText: "Verify",
                            isLoading: controller.isLoading,
                            buttonHeight: 56.h,
                            buttonRadius: 30.r,
                            gradient: const LinearGradient(
                              colors: [Color(0xFF081A4A), Color(0xFF1239D4)],
                            ),
                            onTap: () {
                              /*if (_formKey.currentState!.validate()) {
                                controller.verifyOtp();
                              }*/
                              Get.toNamed(AppRoutes.createPassword);
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
