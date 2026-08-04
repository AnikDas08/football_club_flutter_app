import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/route/app_routes.dart';
import 'package:get/get.dart';
import '../../../component/text/common_text.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Precache onboarding images to avoid white flashing during transition
    precacheImage(const AssetImage(AppImages.onboarding1), context);
    precacheImage(const AssetImage(AppImages.onboarding2), context);
    precacheImage(const AssetImage(AppImages.onboarding3), context);
  }

  @override
  void initState() {
    super.initState();
    // Hide the status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    Future.delayed(const Duration(seconds: 3), () async {
      Get.offNamed(AppRoutes.onboarding);
    });
  }

  @override
  void dispose() {
    // Restore the status bar when leaving splash screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.splash_image),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 100.h),
            Image.asset(AppImages.app_icon, height: 145.h, width: 145.w),
            const Spacer(),
            const CommonText(
              text: "DEVELOP. PROGRESS. ACHIEVE.",
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textColor,
            ),
            CommonText(
              text: "BUILDING TOMORROW'S CHAMPIONS TODAY.",
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.textColor.withOpacity(0.5),
              top: 8,
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}

