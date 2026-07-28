import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_club/utils/constants/app_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../config/route/app_routes.dart';
import '../../../../../../../utils/constants/app_images.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../../../../../utils/helpers/validation.dart';
import '../controller/sign_in_controller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020914),
      body: GetBuilder<SignInController>(
        builder: (controller) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.login_bg),
                fit: BoxFit.fill,
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 150.h),
                      
                      // App Icon logo at top-left
                      Image.asset(
                        AppImages.app_icon,
                        width: 56.w,
                        height: 56.h,
                      ),
                      SizedBox(height: 16.h),

                      // Welcome Back Title
                      CommonText(
                        text: "Welcome back",
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textColor,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 8.h),

                      // Subtitle
                      CommonText(
                        text: "Log In to your NEERTH account to keep moving.",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor.withOpacity(0.5),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 32.h),

                      // Email Label
                      CommonText(
                        text: "EMAIL",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textColor.withOpacity(0.5),
                        bottom: 8,
                      ),
                      
                      // Email Field
                      CommonTextField(
                        controller: controller.emailController,
                        validator: AppValidation.email,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        isDark: true,
                        prefixIcon: const Icon(Icons.person_outline),
                        hintText: "lea@mail.com",
                      ),
                      SizedBox(height: 20.h),

                      // Password Label
                      CommonText(
                        text: "PASSWORD",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textColor.withOpacity(0.5),
                        bottom: 8,
                      ),
                      
                      // Password Field
                      CommonTextField(
                        controller: controller.passwordController,
                        validator: AppValidation.password,
                        isPassword: true,
                        textInputAction: TextInputAction.done,
                        isDark: true,
                        prefixIcon: const Icon(Icons.lock_outline),
                        hintText: "••••••••",
                      ),
                      SizedBox(height: 12.h),

                      // Forgot Password Link
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => Get.toNamed(AppRoutes.forgotPassword),
                          child: const CommonText(
                            text: "Forgot Password?",
                            color: Color(0xFF165DFF),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 32.h),

                      // Sign In Button
                      CommonButton(
                        titleText: "Sign In",
                        isLoading: controller.isLoading,
                        buttonHeight: 56.h,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF081A4A), Color(0xFF1239D4)],
                        ),
                        suffixIcon: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 18.sp,
                        ),
                        onTap: () {
                          /*if (!_formKey.currentState!.validate()) {
                            return;
                          }*/
                          controller.signInUser();
                        },
                      ),
                      SizedBox(height: 24.h),

                      // Divider Row (— or —)
                      /*Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.white.withOpacity(0.1),
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: CommonText(
                              text: "or",
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.3),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.white.withOpacity(0.1),
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),

                      // Create Account Button
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.signUp),
                        child: Container(
                          height: 56.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30.r),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.15),
                              width: 1,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const CommonText(
                            text: "Create Account",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 48.h),*/

                      // Terms & Privacy Policy Footer
                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: GoogleFonts.roboto(
                              fontSize: 14.sp,
                              color: Colors.white.withOpacity(0.5),
                            ),
                            children: [
                              const TextSpan(text: "By continuing you agree to TFP's "),
                              TextSpan(
                                text: "Terms",
                                style: GoogleFonts.roboto(
                                  color: const Color(0xFF165DFF),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const TextSpan(text: " & "),
                              TextSpan(
                                text: "Privacy Policy",
                                style: GoogleFonts.roboto(
                                  color: const Color(0xFF165DFF),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
