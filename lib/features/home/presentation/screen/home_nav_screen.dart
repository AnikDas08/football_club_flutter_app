import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../component/text/common_text.dart';
import '../../../deployment/presentation/screen/deployment_screen.dart';
import '../../../profile/presentation/screen/profile_screen.dart';
import '../../../statistics/presentation/screen/statistics_screen.dart';
import '../controller/home_controller.dart';
import '../controller/home_nav_controller.dart';
import 'home_screen.dart';

class HomeNavScreen extends StatelessWidget {
  HomeNavScreen({super.key});

  final List<Map<String, dynamic>> _navItems = [
    {"icon": Icons.home_outlined, "activeIcon": Icons.home_outlined, "label": "Home"},
    {"icon": Icons.trending_up, "activeIcon": Icons.trending_up, "label": "Development"},
    {"icon": Icons.bar_chart_outlined, "activeIcon": Icons.bar_chart_outlined, "label": "Statistics"},
    {"icon": Icons.person_outline, "activeIcon": Icons.person_outline, "label": "Profile"},
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    Get.put(HomeNavController());

    return GetBuilder<HomeNavController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFF0A0E1A),
          body: IndexedStack(
            index: controller.selectedIndex,
            children: const [
              HomeScreen(),
              DeploymentScreen(),
              StatisticsScreen(),
              ProfileScreen(),
            ],
          ),

          /// Floating Navigation with Safe Area & Universal Device Responsiveness
          bottomNavigationBar: SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF0C1322),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: const Color(0xFF1E2A45),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.35),
                      blurRadius: 16,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: List.generate(_navItems.length, (index) {
                    final isActive = controller.selectedIndex == index;
                    final item = _navItems[index];

                    return Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => controller.changeIndex(index),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 38.w,
                                  height: 38.h,
                                  decoration: isActive
                                      ? BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [Color(0xFF081A4A), Color(0xFF1239D4)],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                          borderRadius: BorderRadius.circular(12.r),
                                        )
                                      : null,
                                  alignment: Alignment.center,
                                  child: Icon(
                                    isActive
                                        ? item["activeIcon"] as IconData
                                        : item["icon"] as IconData,
                                    color: isActive
                                        ? Colors.white
                                        : const Color(0xFF475569),
                                    size: 22.sp,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 3.h),
                            CommonText(
                              text: item["label"] as String,
                              fontSize: 11,
                              fontWeight:
                                  isActive ? FontWeight.w600 : FontWeight.w400,
                              color: isActive
                                  ? const Color(0xFF165DFF)
                                  : const Color(0xFF475569),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
