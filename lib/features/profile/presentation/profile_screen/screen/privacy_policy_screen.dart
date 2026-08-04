import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:football_club/component/text/common_text.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  final String? privacyPolicyText;

  const PrivacyPolicyScreen({super.key, this.privacyPolicyText});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  late String _content;

  @override
  void initState() {
    super.initState();
    _content =
        widget.privacyPolicyText ??
        "1. Acceptance of Terms\n\n"
            "By accessing or using this application, you agree to comply with and be bound by these Terms & Conditions. If you do not agree with any part of these terms, please do not use the application.\n\n"
            "2. User Account\n\n"
            "Users may be required to create an account to access certain features of the application. You are responsible for maintaining the confidentiality of your account information.\n\n"
            "3. Use of the Application\n\n"
            "You agree to use the application only for lawful purposes and in accordance with these terms. Any misuse of the platform may result in account suspension or termination.\n\n"
            "4. User Responsibilities\n\n"
            "• Provide accurate information.\n"
            "• Maintain account security.\n"
            "• Comply with applicable laws and regulations.\n"
            "• Avoid fraudulent or harmful activities.\n\n"
            "5. Intellectual Property\n\n"
            "All content, trademarks, logos, and materials available within the application are the property of the company and may not be copied or distributed without permission.\n\n"
            "6. Limitation of Liability\n\n"
            "The company shall not be liable for any indirect, incidental, or consequential damages resulting from the use of the application.\n\n"
            "7. Termination\n\n"
            "We reserve the right to suspend or terminate any account that violates these Terms & Conditions.\n\n"
            "8. Changes to Terms\n\n"
            "We may update these Terms & Conditions from time to time. Continued use of the application constitutes acceptance of the updated terms.\n\n"
            "9. Contact Us\n\n"
            "If you have any questions regarding these Terms & Conditions, please contact our support team.";
  }

  @override
  Widget build(BuildContext context) {
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

              // Page Title: Privacy Policy
              const CommonText(
                text: "Privacy Policy",
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              SizedBox(height: 20.h),

              // Privacy Policy Text Card Container
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF0C1427).withOpacity(0.85),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.12),
                    width: 1,
                  ),
                ),
                child: CommonText(
                  text: _content,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFFCBD5E1),
                  textAlign: TextAlign.start,
                  height: 1.6,
                  maxLines: 200,
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
