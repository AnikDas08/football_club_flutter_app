import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/route/app_routes.dart';
import '../../../utils/constants/app_images.dart';

class OnboardingModel {
  final String tag;
  final String title;
  final String description;
  final String image;

  OnboardingModel({
    required this.tag,
    required this.title,
    required this.description,
    required this.image,
  });
}

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  final List<OnboardingModel> pages = [
    OnboardingModel(
      tag: "Track Progress",
      title: "Your Football Journey\nStarts Here",
      description: "Monitor every session, goal, and milestone of your child's development at TFP Academy.",
      image: AppImages.onboarding1,
    ),
    OnboardingModel(
      tag: "Development",
      title: "Real-Time Coach\nFeedback",
      description: "Get instant notes from coaches after every training session. Stay informed, stay involved.",
      image: AppImages.onboarding2,
    ),
    OnboardingModel(
      tag: "Achievements",
      title: "Celebrate Every\nWin",
      description: "From first goals to Player of the Match - every achievement is captured and celebrated.",
      image: AppImages.onboarding3,
    ),
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.offNamed(AppRoutes.signIn);
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void skipToEnd() {
    Get.offNamed(AppRoutes.signIn);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
