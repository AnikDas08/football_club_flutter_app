import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../component/text/common_text.dart';
import '../controller/onboarding_controller.dart';
import '../widgets/onboarding_page.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      backgroundColor: const Color(
        0xFF020914,
      ), // Dark blue/black color matching the onboarding background to prevent white transition flashes
      body: Stack(
        children: [
          // Background PageView
          PageView.builder(
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged,
            itemCount: controller.pages.length,
            itemBuilder: (context, index) {
              return OnboardingPage(model: controller.pages[index]);
            },
          ),

          // Skip Button at top right
          Positioned(
            top: 60.h,
            right: 24.w,
            child: Obx(
              () => controller.currentPage.value < controller.pages.length - 1
                  ? GestureDetector(
                      onTap: controller.skipToEnd,
                      child: const CommonText(
                        text: "Skip",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ),

          // Page Indicators (Dots)
          Positioned(
            bottom: 120.h,
            left: 24.w,
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(controller.pages.length, (dotIndex) {
                  bool isActive = controller.currentPage.value == dotIndex;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.only(right: 8.w),
                    height: isActive ? 6.h : 6.h,
                    width: isActive ? 28.w : 8.w,
                    decoration: BoxDecoration(
                      gradient: isActive
                          ? const LinearGradient(
                              colors: [Color(0xFF081A4A), Color(0xFF1239D4)],
                            )
                          : null,
                      color: isActive ? null : const Color(0xFFBFD1FF),
                      border: isActive
                          ? Border.all(color: const Color(0xFFBFD1FF), width: 1)
                          : null,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  );
                }),
              ),
            ),
          ),

          // Bottom Navigation Buttons (Back & Next)
          Positioned(
            bottom: 40.h,
            left: 24.w,
            right: 24.w,
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Button (hidden on page 0)
                  controller.currentPage.value > 0
                      ? GestureDetector(
                          onTap: controller.previousPage,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.arrow_back,
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
                        )
                      : const SizedBox.shrink(),

                  // Next Button
                  GestureDetector(
                    onTap: controller.nextPage,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CommonText(
                          text: "Next",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        SizedBox(width: 6.w),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 18.sp,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
