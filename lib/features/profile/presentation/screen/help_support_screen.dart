import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_images.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  int? _expandedIndex = 0; // First item expanded by default as in screenshot

  final List<Map<String, String>> _faqItems = [
    {
      "question": "How do I update my player's details?",
      "answer":
          "Go to Profile → Settings → Edit Profile to update any information.",
    },
    {
      "question": "How often are assessments updated?",
      "answer":
          "Assessments are updated monthly by your assigned coach following evaluations.",
    },
    {
      "question": "Can I message the coach directly?",
      "answer":
          "Yes, you can send direct messages to your coach via the Messages tab.",
    },
    {
      "question": "How do I change my password?",
      "answer": "Go to Profile → Settings → Change Password.",
    },
    {
      "question": "How often are assessments updated?",
      "answer":
          "Assessments are updated monthly by your assigned coach following evaluations.",
    },
    {
      "question": "Can I message the coach directly?",
      "answer":
          "Yes, you can send direct messages to your coach via the Messages tab.",
    },
    {
      "question": "How do I change my password?",
      "answer": "Go to Profile → Settings → Change Password.",
    },
  ];

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

              // Page Title
              const CommonText(
                text: "Help & Support",
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              SizedBox(height: 16.h),

              // Top Image Banner Card
              Container(
                width: double.infinity,
                height: 150.h,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  image: const DecorationImage(
                    image: AssetImage(AppImages.home_bg),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.15),
                      width: 1,
                    ),
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF000716).withOpacity(0.75),
                        const Color(0xFF0A0E1A).withOpacity(0.9),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CommonText(
                        text: "How can we help?",
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      SizedBox(height: 6.h),
                      const CommonText(
                        text: "Our team is here to support you",
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF8E9BAE),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // Section Title: FREQUENTLY ASKED QUESTIONS
              const CommonText(
                text: "FREQUENTLY ASKED QUESTIONS",
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.8,
              ),
              SizedBox(height: 12.h),

              // FAQ Accordion List
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _faqItems.length,
                itemBuilder: (context, index) {
                  final item = _faqItems[index];
                  final isExpanded = _expandedIndex == index;

                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isExpanded) {
                            _expandedIndex = null;
                          } else {
                            _expandedIndex = index;
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(16.w),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: CommonText(
                                    text: item["question"]!,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Icon(
                                  isExpanded
                                      ? Icons.keyboard_arrow_down
                                      : Icons.chevron_right,
                                  color: const Color(0xFF8E9BAE),
                                  size: 20.sp,
                                ),
                              ],
                            ),
                            if (isExpanded) ...[
                              SizedBox(height: 12.h),
                              Divider(
                                height: 1,
                                color: Colors.white.withOpacity(0.05),
                              ),
                              SizedBox(height: 12.h),
                              CommonText(
                                text: item["answer"]!,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                maxLines: 5,
                                color: const Color(0xFFCBD5E1),
                                textAlign: TextAlign.start,
                                height: 1.4,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
