import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_images.dart';

class MatchInvolvementCard extends StatelessWidget {
  const MatchInvolvementCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        image: DecorationImage(
          image: const AssetImage(AppImages.home_bg),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            const Color(0xFF000716).withOpacity(0.85),
            BlendMode.srcOver,
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Colors.white.withOpacity(0.15),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CommonText(
              text: "Match Involvement",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: _buildMetricItem(
                    icon: Icons.sports_soccer,
                    iconColor: const Color(0xFF2563EB),
                    iconBgColor: const Color(0xFF091C4A),
                    value: "72",
                    label: "Shots",
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: _buildMetricItem(
                    icon: Icons.track_changes,
                    iconColor: const Color(0xFF10B981),
                    iconBgColor: const Color(0xFF052E16),
                    value: "41",
                    label: "On Target",
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: _buildMetricItem(
                    icon: Icons.format_list_bulleted_rounded,
                    iconColor: const Color(0xFFA855F7),
                    iconBgColor: const Color(0xFF3B0764),
                    value: "28",
                    label: "Chances",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String value,
    required String label,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0C1427).withOpacity(0.7),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              color: iconColor,
              size: 18.sp,
            ),
          ),
          SizedBox(height: 12.h),
          CommonText(
            text: value,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.white,
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
}
