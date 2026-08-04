import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_images.dart';

class AboutTfpScreen extends StatelessWidget {
  const AboutTfpScreen({super.key});

  Future<void> _sendEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    try {
      if (!await launchUrl(launchUri, mode: LaunchMode.externalApplication)) {
        await launchUrl(launchUri);
      }
    } catch (e) {
      debugPrint('Could not launch email: $e');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    try {
      if (!await launchUrl(launchUri, mode: LaunchMode.externalApplication)) {
        await launchUrl(launchUri);
      }
    } catch (e) {
      debugPrint('Could not launch phone call: $e');
    }
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

              // Title
              const CommonText(
                text: "About TFP",
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              SizedBox(height: 16.h),

              // Top Image Card with Logo Banner
              Container(
                width: double.infinity,
                height: 170.h,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/ftf_image.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.15),
                      width: 1,
                    ),
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF081A4A).withOpacity(0.7),
                        const Color(0xFF0A0E1A).withOpacity(0.9),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 56.w,
                        height: 56.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF091C4A),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF2563EB),
                            width: 2,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.sports_soccer,
                          color: Colors.white,
                          size: 32.sp,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      const CommonText(
                        text: "TFP Academy",
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      SizedBox(height: 4.h),
                      const CommonText(
                        text: "Player Profile",
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF8E9BAE),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Contact Cards (Email Us & Call Us)
              Row(
                children: [
                  Expanded(
                    child: _buildContactCard(
                      icon: Icons.email_outlined,
                      iconColor: const Color(0xFF2563EB),
                      iconBgColor: const Color(0xFF091C4A),
                      title: "Email Us",
                      subtitle: "support@tfp.com",
                      onTap: () => _sendEmail("support@tfp.com"),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _buildContactCard(
                      icon: Icons.phone_outlined,
                      iconColor: const Color(0xFF10B981),
                      iconBgColor: const Color(0xFF052E16),
                      title: "Call Us",
                      subtitle: "+44 161 000 0000",
                      onTap: () => _makePhoneCall("+441610000000"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Our Mission Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(18.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF0C1427).withOpacity(0.85),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.12),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CommonText(
                      text: "Our Mission",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10.h),
                    const CommonText(
                      text:
                          "TFP Academy is dedicated to developing the next generation of football talent through structured development, expert coaching, and data-driven insights. Every player deserves to know exactly where they stand and how to improve.",
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFCBD5E1),
                      textAlign: TextAlign.start,
                      height: 1.4,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // Statistics Counters Row
              Row(
                children: [
                  Expanded(
                    child: _buildStatCounterCard(
                      countText: "500+",
                      label: "Players",
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _buildStatCounterCard(
                      countText: "12+",
                      label: "Coaches",
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _buildStatCounterCard(
                      countText: "8",
                      label: "Years",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // App Specs Table Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(18.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF0C1427).withOpacity(0.85),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.12),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    _buildSpecRow("Version", "2.4.1"),
                    Divider(
                      height: 20.h,
                      color: Colors.white.withOpacity(0.05),
                    ),
                    _buildSpecRow("Platform", "iOS & Android"),
                    Divider(
                      height: 20.h,
                      color: Colors.white.withOpacity(0.05),
                    ),
                    _buildSpecRow("Academy", "TFP Academy"),
                    Divider(
                      height: 20.h,
                      color: Colors.white.withOpacity(0.05),
                    ),
                    _buildSpecRow(
                      "Contact",
                      "info@tfp.academy",
                      onTap: () => _sendEmail("info@tfp.academy"),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: const Color(0xFF0C1427).withOpacity(0.85),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.white.withOpacity(0.12), width: 1),
        ),
        child: Column(
          children: [
            Container(
              width: 38.w,
              height: 38.h,
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(icon, color: iconColor, size: 20.sp),
            ),
            SizedBox(height: 10.h),
            CommonText(
              text: title,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            SizedBox(height: 4.h),
            CommonText(
              text: subtitle,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF8E9BAE),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCounterCard({
    required String countText,
    required String label,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0C1427).withOpacity(0.85),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withOpacity(0.12), width: 1),
      ),
      child: Column(
        children: [
          CommonText(
            text: countText,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF2563EB),
          ),
          SizedBox(height: 4.h),
          CommonText(
            text: label,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF8E9BAE),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecRow(String label, String value, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonText(
            text: label,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF8E9BAE),
          ),
          CommonText(
            text: value,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: onTap != null ? const Color(0xFF2563EB) : Colors.white,
          ),
        ],
      ),
    );
  }
}
