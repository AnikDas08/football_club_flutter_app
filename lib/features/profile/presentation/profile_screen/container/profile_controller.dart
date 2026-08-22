import 'dart:io';

import 'package:flutter/material.dart';
import 'package:football_club/features/profile/data/repository_impl/profile_repository_impl.dart';
import 'package:football_club/features/profile/domain/entity/profile_entity.dart';
import 'package:football_club/features/profile/domain/repository/profile_repository.dart';
import 'package:football_club/utils/app_snackbar.dart';
import 'package:football_club/utils/helpers/banner_helper.dart';
import 'package:football_club/utils/helpers/other_helper.dart';
import 'package:football_club/features/home/presentation/home_screen/container/home_controller.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final ProfileRepository profileRepository;

  ProfileController({ProfileRepository? profileRepository})
      : profileRepository = profileRepository ?? ProfileRepositoryImpl();

  /// Language list
  final List<String> languages = ['English', 'French', 'Arabic'];
  String selectedLanguage = 'English';
  String? profileImagePath;
  String? bannerUrl;
  bool isLoading = false;
  final profileEntity = Rxn<ProfileEntity>();

  /// Form Controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
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

  String normalizePosition(String pos) {
    if (pos.isEmpty) return positions.first;
    for (final item in positions) {
      if (item.toLowerCase() == pos.toLowerCase()) return item;
    }
    for (final item in positions) {
      if (item.toLowerCase().contains(pos.toLowerCase()) ||
          pos.toLowerCase().contains(item.toLowerCase())) {
        return item;
      }
    }
    return positions.contains(pos) ? pos : positions.first;
  }

  String normalizeFoot(String foot) {
    if (foot.isEmpty) return feet.first;
    for (final item in feet) {
      if (item.toLowerCase() == foot.toLowerCase()) return item;
    }
    return feet.contains(foot) ? foot : feet.first;
  }

  void populateControllers(ProfileEntity data) {
    if (data.playerName.contains(' ')) {
      final parts = data.playerName.split(' ');
      firstNameController.text = parts.first;
      lastNameController.text = parts.sublist(1).join(' ');
    } else {
      firstNameController.text = data.playerName;
      lastNameController.text = '';
    }
    playerNameController.text = data.playerName;

    if (dobController.text.isEmpty || dobController.text != data.dob) {
      dobController.text = data.dob;
    }
    if (parentNameController.text.isEmpty || parentNameController.text != data.parentName) {
      parentNameController.text = data.parentName;
    }
    if (emailController.text.isEmpty || emailController.text != data.email) {
      emailController.text = data.email;
    }
    if (mobileController.text.isEmpty || mobileController.text != data.mobile) {
      mobileController.text = data.mobile;
    }
    selectedPosition = normalizePosition(data.position);
    selectedFoot = normalizeFoot(data.preferredFoot);
    if (profileImagePath == null || profileImagePath!.isEmpty) {
      profileImagePath = data.profileImagePath;
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (profileEntity.value != null) {
      populateControllers(profileEntity.value!);
    }
    fetchProfileData();
    fetchProfileBanner();
  }

  Future<void> fetchProfileBanner() async {
    try {
      final url = await BannerHelper.fetchBanner('profile');
      if (url != null && url.isNotEmpty) {
        bannerUrl = url;
        update();
      }
    } catch (_) {}
  }

  Future<void> fetchProfileData() async {
    try {
      isLoading = true;
      update();
      final data = await profileRepository.getProfileData();
      if (data != null) {
        profileEntity.value = data;
        populateControllers(data);
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

  /// Save changes (PATCH operation: only send changed fields)
  Future<void> saveProfile() async {
    final initial = profileEntity.value;

    final String currentFirstName = firstNameController.text.trim();
    final String currentLastName = lastNameController.text.trim();
    final String currentFullName = '$currentFirstName $currentLastName'.trim();

    final String initialFirstName = (initial?.playerName.contains(' ') == true)
        ? initial!.playerName.split(' ').first
        : (initial?.playerName ?? '');
    final String initialLastName = (initial?.playerName.contains(' ') == true)
        ? initial!.playerName.split(' ').sublist(1).join(' ')
        : '';

    final bool isFirstNameChanged = initial == null || currentFirstName != initialFirstName;
    final bool isLastNameChanged = initial == null || currentLastName != initialLastName;

    final bool isImageChanged = profileImagePath != null &&
        profileImagePath != initial?.profileImagePath &&
        !profileImagePath!.startsWith('http') &&
        !profileImagePath!.startsWith('assets/') &&
        File(profileImagePath!).existsSync();

    final bool isDobChanged = initial == null || dobController.text.trim() != initial.dob;
    final bool isParentChanged = initial == null || parentNameController.text.trim() != initial.parentName;
    final bool isMobileChanged = initial == null || mobileController.text.trim() != initial.mobile;
    final bool isPosChanged = initial == null || selectedPosition != initial.position;
    final bool isFootChanged = initial == null || selectedFoot != initial.preferredFoot;

    final bool hasChanges = isImageChanged ||
        isFirstNameChanged ||
        isLastNameChanged ||
        isDobChanged ||
        isParentChanged ||
        isMobileChanged ||
        isPosChanged ||
        isFootChanged;

    if (!hasChanges) {
      AppSnackbar.success(
        title: 'Info',
        message: 'No changes to update',
      );
      Get.back();
      return;
    }

    final Map<String, dynamic> updatePayload = {};

    if (isFirstNameChanged) {
      updatePayload['firstName'] = currentFirstName;
    }
    if (isLastNameChanged) {
      updatePayload['lastName'] = currentLastName;
    }
    if (isDobChanged) {
      updatePayload['dob'] = dobController.text.trim();
    }
    if (isParentChanged) {
      updatePayload['parentName'] = parentNameController.text.trim();
    }
    if (isMobileChanged) {
      updatePayload['mobile'] = mobileController.text.trim();
    }
    if (isPosChanged) {
      updatePayload['position'] = selectedPosition;
    }
    if (isFootChanged) {
      updatePayload['preferredFoot'] = selectedFoot;
    }
    if (isImageChanged) {
      updatePayload['profileImagePath'] = profileImagePath!;
    }

    isLoading = true;
    update();

    final success = await profileRepository.updateProfile(updatePayload);

    isLoading = false;
    update();

    if (success) {
      final updatedProfile = ProfileEntity(
        playerName: currentFullName,
        email: emailController.text,
        dob: dobController.text,
        parentName: parentNameController.text,
        mobile: mobileController.text,
        position: selectedPosition,
        preferredFoot: selectedFoot,
        profileImagePath: isImageChanged ? profileImagePath! : (initial?.profileImagePath ?? ''),
        bloodGroup: initial?.bloodGroup ?? '',
        allergies: initial?.allergies ?? '',
        medicalConditions: initial?.medicalConditions ?? '',
        medications: initial?.medications ?? '',
        emergencyContactName: initial?.emergencyContactName ?? '',
        emergencyPhone: initial?.emergencyPhone ?? '',
        medicalNotes: initial?.medicalNotes ?? '',
        homeAddress: initial?.homeAddress ?? '',
        city: initial?.city ?? '',
        postcode: initial?.postcode ?? '',
      );

      profileEntity.value = updatedProfile;
      update();

      if (Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().updatePlayerProfileLocally(
          name: updatedProfile.playerName,
          imagePath: updatedProfile.profileImagePath,
          position: updatedProfile.position,
        );
      }
      AppSnackbar.success(
        title: 'Success',
        message: 'Profile updated successfully',
      );
      Get.back();
    }
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    playerNameController.dispose();
    dobController.dispose();
    parentNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    super.onClose();
  }
}
