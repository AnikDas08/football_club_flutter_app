import 'package:flutter/material.dart';
import 'package:football_club/features/profile/data/repository_impl/profile_repository_impl.dart';
import 'package:football_club/features/profile/domain/entity/profile_entity.dart';
import 'package:football_club/features/profile/domain/repository/profile_repository.dart';
import 'package:football_club/utils/app_snackbar.dart';
import 'package:football_club/utils/helpers/other_helper.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final ProfileRepository profileRepository;

  ProfileController({ProfileRepository? profileRepository})
      : profileRepository = profileRepository ?? ProfileRepositoryImpl();

  /// Language list
  final List<String> languages = ['English', 'French', 'Arabic'];
  String selectedLanguage = 'English';
  String? profileImagePath;
  bool isLoading = false;
  final profileEntity = Rxn<ProfileEntity>();

  /// Form Controllers
  final playerNameController = TextEditingController();
  final dobController = TextEditingController();
  final parentNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();

  TextEditingController get nameController => playerNameController;
  TextEditingController get numberController => mobileController;

  /// Options
  String selectedPosition = "Attacking Midfielder";
  String selectedFoot = "Right";

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
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    try {
      isLoading = true;
      update();
      final data = await profileRepository.getProfileData();
      if (data != null) {
        profileEntity.value = data;
        playerNameController.text = data.playerName;
        dobController.text = data.dob;
        parentNameController.text = data.parentName;
        emailController.text = data.email;
        mobileController.text = data.mobile;
        selectedPosition = data.position;
        selectedFoot = data.preferredFoot;
        profileImagePath = data.profileImagePath;
      }
    } catch (e) {
      // Handle error
    } finally {
      isLoading = false;
      update();
    }
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

    final updatedProfile = ProfileEntity(
      playerName: playerNameController.text,
      email: emailController.text,
      dob: dobController.text,
      parentName: parentNameController.text,
      mobile: mobileController.text,
      position: selectedPosition,
      preferredFoot: selectedFoot,
      profileImagePath: profileImagePath ?? 'assets/images/profile_image.png',
    );

    final success = await profileRepository.updateProfile(updatedProfile);

    isLoading = false;
    update();

    if (success) {
      profileEntity.value = updatedProfile;
      AppSnackbar.success(
        title: 'Success',
        message: 'Profile updated successfully',
      );
      Get.back();
    }
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
