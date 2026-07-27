import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../component/text/common_text.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              const CommonText(
                text: "Statistics",
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              SizedBox(height: 8.h),
              CommonText(
                text: "Analyze club achievements, performance trends, and player ratings.",
                fontSize: 14,
                color: Colors.white.withOpacity(0.5),
              ),
              SizedBox(height: 48.h),
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.bar_chart_outlined,
                      size: 64.sp,
                      color: Colors.white.withOpacity(0.15),
                    ),
                    SizedBox(height: 16.h),
                    CommonText(
                      text: "No active statistics profiles loaded",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
