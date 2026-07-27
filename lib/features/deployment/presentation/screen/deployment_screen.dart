import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../component/text/common_text.dart';

class DeploymentScreen extends StatelessWidget {
  const DeploymentScreen({super.key});

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
                text: "Deployment",
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              SizedBox(height: 8.h),
              CommonText(
                text: "Tactical positions and player configurations on the field.",
                fontSize: 14,
                color: Colors.white.withOpacity(0.5),
              ),
              SizedBox(height: 48.h),
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.map_outlined,
                      size: 64.sp,
                      color: Colors.white.withOpacity(0.15),
                    ),
                    SizedBox(height: 16.h),
                    CommonText(
                      text: "No active deployments configured",
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
