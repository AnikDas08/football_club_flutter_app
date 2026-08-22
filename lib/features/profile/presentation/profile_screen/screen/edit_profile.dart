import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_club/config/api/api_end_point.dart';
import 'package:get/get.dart';

import 'package:football_club/component/image/common_image.dart';
import 'package:football_club/component/text/common_text.dart';
import 'package:football_club/component/text_field/common_text_field.dart';
import 'package:football_club/features/profile/presentation/profile_screen/container/profile_controller.dart';
import 'package:football_club/utils/constants/app_images.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: Get.put(ProfileController()),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFF0A0E1A),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Back Button
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

                  // 2. Page Title
                  const CommonText(
                    text: "Edit Profile",
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  SizedBox(height: 20.h),

                  // 3. Change Photo Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0C1427).withOpacity(0.85),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: const Color(0xFF1D4ED8).withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: controller.getProfileImage,
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                width: 80.w,
                                height: 80.h,
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
                                      ).withOpacity(0.4),
                                      blurRadius: 14,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: ClipOval(
                                  child: _buildProfileAvatar(controller.profileImagePath),
                                ),
                              ),
                              Container(
                                width: 26.w,
                                height: 26.h,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF165DFF),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        const CommonText(
                          text: "Tap to change photo",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF8E9BAE),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // 4. Form Fields
                  // FIRST NAME & LAST NAME FIELDS
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel("FIRST NAME"),
                            CommonTextField(
                              controller: controller.firstNameController,
                              isDark: true,
                              prefixIcon: Icon(
                                Icons.person_outline_rounded,
                                size: 18.sp,
                                color: const Color(0xFF8E9BAE),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel("LAST NAME"),
                            CommonTextField(
                              controller: controller.lastNameController,
                              isDark: true,
                              prefixIcon: Icon(
                                Icons.person_outline_rounded,
                                size: 18.sp,
                                color: const Color(0xFF8E9BAE),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // DATE OF BIRTH
                  _buildFieldLabel("DATE OF BIRTH"),
                  CommonTextField(
                    controller: controller.dobController,
                    isDark: true,
                    onTap: () => controller.pickDate(context),
                    prefixIcon: Icon(
                      Icons.calendar_today_outlined,
                      size: 18.sp,
                      color: const Color(0xFF8E9BAE),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // PLAYING POSITION
                  _buildFieldLabel("PLAYING POSITION"),
                  _buildDropdownField(
                    value: controller.selectedPosition,
                    items: controller.positions,
                    onChanged: controller.selectPosition,
                  ),
                  SizedBox(height: 16.h),

                  // FAVOURITE FOOT
                  _buildFieldLabel("FAVOURITE FOOT"),
                  _buildDropdownField(
                    value: controller.selectedFoot,
                    items: controller.feet,
                    onChanged: controller.selectFoot,
                  ),
                  SizedBox(height: 16.h),

                  // PARENT / GUARDIAN FULL NAME
                  _buildFieldLabel("PARENT / GUARDIAN FULL NAME"),
                  CommonTextField(
                    controller: controller.parentNameController,
                    isDark: true,
                    prefixIcon: Icon(
                      Icons.person_outline_rounded,
                      size: 18.sp,
                      color: const Color(0xFF8E9BAE),
                    ),
                  ),
                  SizedBox(height: 16.h),



                  // MOBILE NUMBER
                  _buildFieldLabel("MOBILE NUMBER"),
                  CommonTextField(
                    controller: controller.mobileController,
                    isDark: true,
                    keyboardType: TextInputType.phone,
                    prefixIcon: Icon(
                      Icons.phone_outlined,
                      size: 18.sp,
                      color: const Color(0xFF8E9BAE),
                    ),
                  ),
                  SizedBox(height: 28.h),

                  // 5. Save Changes Button
                  GestureDetector(
                    onTap: controller.isLoading ? null : controller.saveProfile,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF081A4A), Color(0xFF165DFF)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      alignment: Alignment.center,
                      child: controller.isLoading
                          ? SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const CommonText(
                              text: "Save Changes",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileAvatar(String? path) {
    return CommonImage(
      imageSrc: path ?? '',
      defaultImage: AppImages.profile_image,
      fill: BoxFit.cover,
      width: 80.w,
      height: 80.h,
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: CommonText(
        text: label,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF8E9BAE),
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildDropdownField({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFF0C1427).withOpacity(0.85),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withOpacity(0.08), width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: const Color(0xFF0C1427),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: const Color(0xFF8E9BAE),
            size: 20.sp,
          ),
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          items: items.map((item) {
            return DropdownMenuItem<String>(value: item, child: Text(item));
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
