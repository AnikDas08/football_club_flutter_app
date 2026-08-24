import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:football_club/component/text/common_text.dart';
import 'package:football_club/config/api/api_end_point.dart';
import 'package:football_club/services/api/api_service.dart';
import 'package:football_club/utils/constants/app_images.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  int? _expandedIndex = 0; // First item expanded by default
  bool _isLoading = true;
  List<Map<String, String>> _faqItems = [];

  @override
  void initState() {
    super.initState();
    _fetchFaqs();
  }

  Future<void> _fetchFaqs() async {
    try {
      final response = await ApiService.get(ApiEndPoint.faqsPublic);
      if (response.statusCode == 200) {
        final List<dynamic> rawData = response.data['data'] as List<dynamic>? ?? [];
        if (rawData.isNotEmpty) {
          final List<Map<String, String>> fetchedFaqs = [];
          for (final item in rawData) {
            if (item is Map<String, dynamic>) {
              final String q = item['question'] ?? '';
              final String a = item['answer'] ?? '';
              if (q.isNotEmpty) {
                fetchedFaqs.add({
                  'question': q,
                  'answer': a,
                });
              }
            }
          }
          if (fetchedFaqs.isNotEmpty) {
            if (mounted) {
              setState(() {
                _faqItems = fetchedFaqs;
                _isLoading = false;
              });
            }
            return;
          }
        }
      }
    } catch (_) {}

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
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

              // Content Area: Loading / Empty / FAQ List
              if (_isLoading)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.h),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF2563EB),
                    ),
                  ),
                )
              else if (_faqItems.isEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.h),
                  child: const Center(
                    child: CommonText(
                      text: "No FAQs available",
                      fontSize: 14,
                      color: Color(0xFF8E9BAE),
                    ),
                  ),
                )
              else
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: CommonText(
                                      text: item["question"] ?? '',
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
                                  text: item["answer"] ?? '',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  maxLines: 10,
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
