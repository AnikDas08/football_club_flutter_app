import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/route/app_routes.dart';
import '../../../../utils/app_snackbar.dart';
import '../../../../utils/helpers/other_helper.dart';

class ProfileController extends GetxController {
  /// Language list
  final List<String> languages = ['English', 'French', 'Arabic'];
  String selectedLanguage = 'English';
  String? profileImagePath;
  bool isLoading = false;

  /// Form Controllers
  final playerNameController = TextEditingController(text: "Nt Knowles");
  final dobController = TextEditingController(text: "02-02-2000");
  final parentNameController = TextEditingController(text: "Nt Knowles");
  final emailController = TextEditingController(text: "ntknowles@gmail.com");
  final mobileController = TextEditingController(text: "+44 7XXX XXXXXX");

  TextEditingController get nameController => playerNameController;
  TextEditingController get numberController => mobileController;

  /// Options
  String selectedPosition = "Goalkeeper";
  String selectedFoot = "Left";

  final List<String> positions = [
    "Goalkeeper",
    "Defender",
    "Midfielder",
    "Attacking Midfielder",
    "Forward",
    "Winger",
  ];

  final List<String> feet = ["Left", "Right", "Both"];

  @override
  void onInit() {
    super.onInit();
    // Initialize default values if needed
  }

  /// Pick profile image
  Future<void> getProfileImage() async {
    final pickedImage = await OtherHelper.pickImage();
    if (pickedImage != null) {
      profileImagePath = pickedImage;
      update();
    }
  }

  /// Select position
  void selectPosition(String? position) {
    if (position != null) {
      selectedPosition = position;
      update();
    }
  }

  /// Select foot
  void selectFoot(String? foot) {
    if (foot != null) {
      selectedFoot = foot;
      update();
    }
  }

  /// Select language
  void selectLanguage(int index) {
    selectedLanguage = languages[index];
    update();
    Get.back();
  }

  /// Date picker
  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 2, 2),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dobController.text =
          "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
      update();
    }
  }

  /// Save changes
  Future<void> saveProfile() async {
    isLoading = true;
    update();

    await Future.delayed(const Duration(milliseconds: 600));

    isLoading = false;
    update();

    AppSnackbar.success(
      title: 'Success',
      message: 'Profile updated successfully',
    );

    Get.back();
  }

  @override
  void onClose() {
    playerNameController.dispose();
    dobController.dispose();
    parentNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    super.onClose();
  }
}
