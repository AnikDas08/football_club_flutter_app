import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:football_club/component/image/common_image.dart';
import 'package:football_club/component/text/common_text.dart';
import 'package:football_club/config/route/app_routes.dart';
import 'package:football_club/features/profile/presentation/profile_screen/container/profile_controller.dart';
import 'package:football_club/services/storage/storage_services.dart';
import 'package:football_club/utils/constants/app_images.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isNotificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Top Header with Background Image & Profile Summary
            GetBuilder<ProfileController>(
              init: Get.put(ProfileController()),
              builder: (controller) {
                final String? banner = controller.bannerUrl;
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: (banner != null && banner.isNotEmpty)
                          ? NetworkImage(banner) as ImageProvider
                          : const AssetImage(AppImages.home_bg),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF0A0E1A).withOpacity(0.1),
                          const Color(0xFF0A0E1A).withOpacity(0.85),
                          const Color(0xFF0A0E1A),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: 24.w,
                          top: 8.h,
                          left: 24.w,
                          bottom: 10.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header Logo & Notification Bell
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 22.w,
                                      height: 22.h,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF2563EB),
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.sports_soccer,
                                        color: Colors.white,
                                        size: 14.sp,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    const CommonText(
                                      text: "TFP Academy",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF2563EB),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      Get.toNamed(AppRoutes.notifications),
                                  child: Container(
                                    width: 40.w,
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                      color: const Color(
                                        0xFF0C1322,
                                      ).withOpacity(0.6),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.08),
                                        width: 1,
                                      ),
                                    ),
                                    child: Center(
                                      child: Stack(
                                        alignment: Alignment.center,
                                        clipBehavior: Clip.none,
                                        children: [
                                          Icon(
                                            Icons.notifications_none_outlined,
                                            color: Colors.white,
                                            size: 22.sp,
                                          ),
                                          Positioned(
                                            right: 0,
                                            top: 0,
                                            child: Container(
                                              width: 8.w,
                                              height: 8.h,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFF2563EB),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 6.h),

                            // Title
                            const CommonText(
                              text: "Profile",
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 8.h),

                            // Profile Info Section Centered
                            Center(
                              child: Column(
                                children: [
                                  // Avatar Container with Blue Glow
                                  Container(
                                    width: 86.w,
                                    height: 86.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xFF2563EB),
                                        width: 2,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(
                                            0xFF2563EB,
                                          ).withOpacity(0.5),
                                          blurRadius: 16,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: ClipOval(
                                      child: GetBuilder<ProfileController>(
                                        builder: (controller) {
                                          return CommonImage(
                                            imageSrc:
                                                controller.profileImagePath ??
                                                controller
                                                    .profileEntity
                                                    .value
                                                    ?.profileImagePath ??
                                                '',
                                            defaultImage:
                                                AppImages.profile_image,
                                            fill: BoxFit.cover,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 12.h),

                                  // Name & Subtitle dynamically from ProfileController / ProfileRemoteDataSource
                                  GetBuilder<ProfileController>(
                                    init: Get.put(ProfileController()),
                                    builder: (controller) {
                                      final profile =
                                          controller.profileEntity.value;
                                      final name =
                                          profile?.playerName ??
                                          controller.playerNameController.text;
                                      final pos =
                                          profile?.position ??
                                          controller.selectedPosition;

                                      return Column(
                                        children: [
                                          CommonText(
                                            text: name.isNotEmpty
                                                ? name
                                                : "James Thornton",
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                          SizedBox(height: 4.h),
                                          CommonText(
                                            text: "U14 Elite · $pos",
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xFF8E9BAE),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  SizedBox(height: 12.h),

                                  // Badges Row
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 14.w,
                                          vertical: 5.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF59E0B),
                                          borderRadius: BorderRadius.circular(
                                            16.r,
                                          ),
                                        ),
                                        child: const CommonText(
                                          text: "Advanced",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF0F172A),
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 14.w,
                                          vertical: 5.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF091C4A),
                                          borderRadius: BorderRadius.circular(
                                            16.r,
                                          ),
                                          border: Border.all(
                                            color: const Color(
                                              0xFF1D4ED8,
                                            ).withOpacity(0.4),
                                            width: 1,
                                          ),
                                        ),
                                        child: const CommonText(
                                          text: "Season 24/25",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF2563EB),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 14.h),

                                  // Edit Profile Button
                                  GestureDetector(
                                    onTap: () =>
                                        Get.toNamed(AppRoutes.editProfile),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                        vertical: 8.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(
                                          0xFF0C1427,
                                        ).withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.15),
                                          width: 1,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.edit_note_outlined,
                                            color: Colors.white,
                                            size: 16.sp,
                                          ),
                                          SizedBox(width: 6.w),
                                          const CommonText(
                                            text: "Edit Profile",
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            // 2. Body Cards Content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 8.h),

                  GetBuilder<ProfileController>(
                    init: Get.put(ProfileController()),
                    builder: (controller) {
                      final profile = controller.profileEntity.value;
                      final playerName =
                          profile?.playerName ??
                          controller.playerNameController.text;
                      final dob = profile?.dob ?? controller.dobController.text;
                      final foot =
                          profile?.preferredFoot ?? controller.selectedFoot;
                      final parentName =
                          profile?.parentName ??
                          controller.parentNameController.text;
                      final mobile =
                          profile?.mobile ?? controller.mobileController.text;

                      return Column(
                        children: [
                          // Player Information Card
                          _buildSectionCard(
                            title: "Player Information",
                            rows: [
                              {
                                "label": "Player Name",
                                "value": playerName.isNotEmpty ? playerName : "Rahim Uddin",
                              },
                              {
                                "label": "Date of Birth",
                                "value": dob.isNotEmpty ? dob : "15-05-2010",
                              },
                              {
                                "label": "Favourite Foot",
                                "value": foot.isNotEmpty ? foot : "Right",
                              },
                              {
                                "label": "Assigned Coach",
                                "value": "Coach John Doe",
                              },
                            ],
                          ),
                          SizedBox(height: 16.h),

                          // Parent / Guardian Card
                          _buildSectionCard(
                            title: "Parent / Guardian",
                            rows: [
                              {
                                "label": "Name",
                                "value": parentName.isNotEmpty
                                    ? parentName
                                    : "Karim Uddin",
                              },
                              {
                                "label": "Mobile",
                                "value": mobile.isNotEmpty
                                    ? mobile
                                    : "+8801800000000",
                              },
                            ],
                          ),

                          // Medical & Emergency Info Card
                          if (profile?.bloodGroup.isNotEmpty == true ||
                              profile?.emergencyContactName.isNotEmpty == true ||
                              profile?.medicalConditions.isNotEmpty == true)
                            Column(
                              children: [
                                SizedBox(height: 16.h),
                                _buildSectionCard(
                                  title: "Medical & Emergency Info",
                                  rows: [
                                    if (profile?.bloodGroup.isNotEmpty == true)
                                      {"label": "Blood Group", "value": profile!.bloodGroup},
                                    if (profile?.allergies.isNotEmpty == true)
                                      {"label": "Allergies", "value": profile!.allergies},
                                    if (profile?.medicalConditions.isNotEmpty == true)
                                      {"label": "Conditions", "value": profile!.medicalConditions},
                                    if (profile?.medications.isNotEmpty == true)
                                      {"label": "Medications", "value": profile!.medications},
                                    if (profile?.emergencyContactName.isNotEmpty == true)
                                      {"label": "Emergency Contact", "value": profile!.emergencyContactName},
                                    if (profile?.emergencyPhone.isNotEmpty == true)
                                      {"label": "Emergency Phone", "value": profile!.emergencyPhone},
                                    if (profile?.medicalNotes.isNotEmpty == true)
                                      {"label": "Medical Notes", "value": profile!.medicalNotes},
                                  ],
                                ),
                              ],
                            ),

                          // Address Info Card
                          if (profile?.homeAddress.isNotEmpty == true ||
                              profile?.city.isNotEmpty == true)
                            Column(
                              children: [
                                SizedBox(height: 16.h),
                                _buildSectionCard(
                                  title: "Address Information",
                                  rows: [
                                    if (profile?.homeAddress.isNotEmpty == true)
                                      {"label": "Home Address", "value": profile!.homeAddress},
                                    if (profile?.city.isNotEmpty == true)
                                      {"label": "City", "value": profile!.city},
                                    if (profile?.postcode.isNotEmpty == true)
                                      {"label": "Postcode", "value": profile!.postcode},
                                  ],
                                ),
                              ],
                            ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 16.h),

                  // Settings & Options Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0C1427).withOpacity(0.85),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.08),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        // Notifications Switch Item
                        _buildOptionItem(
                          icon: Icons.notifications_none_outlined,
                          iconColor: const Color(0xFF2563EB),
                          iconBgColor: const Color(0xFF091C4A),
                          title: "Notifications",
                          trailing: Transform.scale(
                            scale: 0.75,
                            child: Switch.adaptive(
                              value: _isNotificationsEnabled,
                              activeColor: const Color(0xFF2563EB),
                              onChanged: (val) {
                                setState(() {
                                  _isNotificationsEnabled = val;
                                });
                              },
                            ),
                          ),
                        ),

                        // Change Password Item
                        _buildOptionItem(
                          icon: Icons.lock_outline_rounded,
                          iconColor: const Color(0xFF8E9BAE),
                          iconBgColor: const Color(0xFF0C1D38),
                          title: "Change Password",
                          onTap: () => Get.toNamed(AppRoutes.changePassword),
                        ),

                        /*// Settings Item
                        _buildOptionItem(
                          icon: Icons.settings_outlined,
                          iconColor: const Color(0xFF8E9BAE),
                          iconBgColor: const Color(0xFF0C1D38),
                          title: "Settings",
                          onTap: () => Get.toNamed(AppRoutes.setting),
                        ),*/

                        // Privacy Item
                        _buildOptionItem(
                          icon: Icons.shield_outlined,
                          iconColor: const Color(0xFF8E9BAE),
                          iconBgColor: const Color(0xFF0C1D38),
                          title: "Privacy Policy",
                          onTap: () => Get.toNamed(AppRoutes.privacyPolicy),
                        ),

                        _buildOptionItem(
                          icon: Icons.description_outlined,
                          iconColor: const Color(0xFF8E9BAE),
                          iconBgColor: const Color(0xFF0C1D38),
                          title: "Terms & Conditions",
                          onTap: () => Get.toNamed(AppRoutes.termsOfServices),
                        ),

                        // Support Item
                        _buildOptionItem(
                          icon: Icons.help_outline_rounded,
                          iconColor: const Color(0xFF8E9BAE),
                          iconBgColor: const Color(0xFF0C1D38),
                          title: "Support",
                          onTap: () => Get.toNamed(AppRoutes.helpSupport),
                        ),

                        // About TFP Item
                        _buildOptionItem(
                          icon: Icons.info_outline_rounded,
                          iconColor: const Color(0xFF8E9BAE),
                          iconBgColor: const Color(0xFF0C1D38),
                          title: "About TFP",
                          onTap: () => Get.toNamed(AppRoutes.aboutTfp),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Log Out Button
                  GestureDetector(
                    onTap: logOutPopUp,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A0910),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: const Color(0xFF7F1D1D).withOpacity(0.4),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout_rounded,
                            color: const Color(0xFFEF4444),
                            size: 18.sp,
                          ),
                          SizedBox(width: 8.w),
                          const CommonText(
                            text: "Log Out",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFEF4444),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 28.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required List<Map<String, String>> rows,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0C1427).withOpacity(0.85),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withOpacity(0.08), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: title,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          SizedBox(height: 14.h),
          Column(
            children: List.generate(rows.length, (index) {
              final row = rows[index];
              final isLast = index == rows.length - 1;

              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(
                          text: row["label"]!,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF8E9BAE),
                        ),
                        CommonText(
                          text: row["value"]!,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  if (!isLast)
                    Divider(height: 1, color: Colors.white.withOpacity(0.05)),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  void logOutPopUp() {
    Get.dialog(
      Dialog(
        backgroundColor: const Color(0xFF0C1427),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: BorderSide(color: Colors.white.withOpacity(0.12), width: 1),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48.w,
                height: 48.h,
                decoration: const BoxDecoration(
                  color: Color(0xFF2A0910),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.logout_rounded,
                  color: const Color(0xFFEF4444),
                  size: 24.sp,
                ),
              ),
              SizedBox(height: 16.h),
              const CommonText(
                text: "Log Out",
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              SizedBox(height: 8.h),
              const CommonText(
                text: "Are you sure you want to log out of your account?",
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color(0xFF8E9BAE),
                textAlign: TextAlign.center,
                maxLines: 3,
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E293B),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        alignment: Alignment.center,
                        child: const CommonText(
                          text: "No",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        Get.back();
                        await LocalStorage.removeAllPrefData();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF081A4A), Color(0xFF165DFF)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        alignment: Alignment.center,
                        child: const CommonText(
                          text: "Yes",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 36.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(icon, color: iconColor, size: 18.sp),
                ),
                SizedBox(width: 14.w),
                CommonText(
                  text: title,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ],
            ),
            trailing ??
                Icon(
                  Icons.chevron_right,
                  color: const Color(0xFF8E9BAE),
                  size: 20.sp,
                ),
          ],
        ),
      ),
    );
  }
}
