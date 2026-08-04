import 'dart:async';
import 'package:flutter/material.dart';
import 'package:football_club/config/api/api_end_point.dart';
import 'package:football_club/config/route/app_routes.dart';
import 'package:football_club/services/api/api_service.dart';
import 'package:football_club/services/storage/storage_keys.dart';
import 'package:football_club/services/storage/storage_services.dart';
import 'package:football_club/utils/app_snackbar.dart';
import 'package:football_club/utils/helpers/other_helper.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find<SignUpController>();

  bool isLoading = false;
  bool isLoadingVerify = false;
  String selectRole = 'User';
  String countryCode = '+880';
  String? image;
  String signUpToken = '';
  Timer? _timer;
  int _seconds = 0;

  /// Form controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final numberController = TextEditingController();
  final otpController = TextEditingController();

  /// Get formatted timer text (mm:ss)
  String get time {
    final minutes = (_seconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  /// Change selected country
  void onCountryChange(Country value) {
    countryCode = value.dialCode;
  }

  /// Change role
  void setSelectedRole(String value) {
    selectRole = value;
    update();
  }

  /// Pick image from gallery
  Future<void> openGallery() async {
    image = await OtherHelper.pickImage();
    update();
  }

  /// Set loading state
  void _setLoading(bool value) {
    isLoading = value;
    update();
  }

  /// Set verify loading state
  void _setVerifyLoading(bool value) {
    isLoadingVerify = value;
    update();
  }

  /// Sign up user API call
  Future<void> signUpUser() async {
    Get.toNamed(AppRoutes.verifyUser);
    return;
    try {
      _setLoading(true);

      final body = {
        'fullName': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phoneNumber': numberController.text.trim(),
        'countryCode': countryCode,
        'password': passwordController.text.trim(),
        'role': selectRole.toLowerCase(),
      };

      final response = await ApiService.post(ApiEndPoint.signUp, body: body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data['data'] ?? {};
        signUpToken = data['signUpToken'] ?? '';

        Get.toNamed(AppRoutes.verifyUser);
      } else {
        AppSnackbar.error(
          title: response.statusCode.toString(),
          message: response.message,
        );
      }
    } catch (e) {
      AppSnackbar.error(title: 'Error', message: e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Start OTP countdown timer (3 minutes)
  void startTimer() {
    _timer?.cancel();
    _seconds = 180;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        timer.cancel();
        return;
      }
      _seconds--;
      update();
    });
  }

  /// Verify OTP API call
  Future<void> verifyOtp() async {
    Get.offAllNamed(AppRoutes.signIn);
    return;
    try {
      _setVerifyLoading(true);
      final body = {'otp': otpController.text};
      final headers = {'SignUpToken': 'signUpToken $signUpToken'};
      final response = await ApiService.post(
        ApiEndPoint.verifyEmail,
        body: body,
        header: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data['data'] ?? {};

        LocalStorage.setString(LocalStorageKeys.token, data['accessToken']);
        LocalStorage.setString(LocalStorageKeys.refreshToken, data['refreshToken']);

        Get.offAllNamed(AppRoutes.signIn);
      } else {
        Get.snackbar(response.statusCode.toString(), response.message);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      _setVerifyLoading(false);
    }
  }

  /// Dispose controllers & timer
  @override
  void onClose() {
    _timer?.cancel();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    numberController.dispose();
    otpController.dispose();
    super.onClose();
  }
}
