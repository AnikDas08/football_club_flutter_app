import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_club/component/button/common_button.dart';
import 'package:football_club/component/text/common_text.dart';
import 'package:football_club/component/text_field/common_text_field.dart';
import 'package:football_club/config/route/app_routes.dart';
import 'package:football_club/features/auth/presentation/sign_in/controller/sign_in_controller.dart';
import 'package:football_club/utils/constants/app_colors.dart';
import 'package:football_club/utils/constants/app_images.dart';
import 'package:football_club/utils/helpers/validation.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordFocusNode = FocusNode();
  bool _hasAttemptedSubmit = false;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Widget _buildRuleRow(String ruleText, bool isSatisfied) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 18.w,
            height: 18.h,
            decoration: BoxDecoration(
              color: isSatisfied
                  ? const Color(0xFF10B981).withOpacity(0.15)
                  : Colors.transparent,
              shape: BoxShape.circle,
              border: isSatisfied
                  ? Border.all(color: const Color(0xFF10B981), width: 1.5)
                  : Border.all(
                      color: Colors.white.withOpacity(0.2),
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
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: isSatisfied
                ? Colors.white.withOpacity(0.85)
                : Colors.white.withOpacity(0.35),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020914),
      body: GetBuilder<SignInController>(
        builder: (controller) {
          final password = controller.passwordController.text;
          final has8Characters = password.length >= 8;
          final hasUppercase = password.contains(RegExp(r'[A-Z]'));
          final hasNumber = password.contains(RegExp(r'[0-9]'));
          final hasSpecialChar =
              password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));
          final isPasswordValid =
              has8Characters && hasUppercase && hasNumber && hasSpecialChar;
          final showPasswordRules = !isPasswordValid &&
              (_passwordFocusNode.hasFocus ||
                  password.isNotEmpty ||
                  _hasAttemptedSubmit);

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
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        isDark: true,
                        prefixIcon: const Icon(Icons.person_outline),
                        hintText: "Enter your email",
                        validator: AppValidation.email,
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
                        focusNode: _passwordFocusNode,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Password is required';
                          }
                          if (!isPasswordValid) {
                            return 'Password must meet all requirements';
                          }
                          return null;
                        },
                        isPassword: true,
                        textInputAction: TextInputAction.done,
                        isDark: true,
                        prefixIcon: const Icon(Icons.lock_outline),
                        hintText: "••••••••",
                        onChanged: (val) {
                          setState(() {});
                          if (_hasAttemptedSubmit) {
                            _formKey.currentState?.validate();
                          }
                        },
                      ),

                      // Real-time Password Rules Checklist
                      AnimatedCrossFade(
                        duration: const Duration(milliseconds: 250),
                        crossFadeState: showPasswordRules
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        firstChild: Padding(
                          padding: EdgeInsets.only(top: 14.h, bottom: 2.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildRuleRow(
                                  "At least 8 characters", has8Characters),
                              _buildRuleRow(
                                  "One uppercase letter", hasUppercase),
                              _buildRuleRow("One number", hasNumber),
                              _buildRuleRow(
                                  "One special character", hasSpecialChar),
                            ],
                          ),
                        ),
                        secondChild: const SizedBox.shrink(),
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
                          setState(() {
                            _hasAttemptedSubmit = true;
                          });
                          if (_formKey.currentState!.validate()) {
                            controller.signInUser();
                          }
                        },
                      ),
                      SizedBox(height: 24.h),

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
