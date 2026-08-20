import 'dart:async';
import 'package:flutter/material.dart';
import 'package:football_club/config/route/app_routes.dart';
import 'package:football_club/features/auth/data/repository_impl/auth_repository_impl.dart';
import 'package:football_club/features/auth/domain/repository/auth_repository.dart';
import 'package:football_club/features/auth/presentation/forgot_password/widgets/password_changed_dialog.dart';
import 'package:football_club/utils/app_snackbar.dart';
import 'package:football_club/utils/enum/enum.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  final AuthRepository authRepository;

  ForgetPasswordController({AuthRepository? authRepository})
      : authRepository = authRepository ?? AuthRepositoryImpl();

  static ForgetPasswordController get instance =>
      Get.find<ForgetPasswordController>();

  bool isLoading = false;
  ForgetPasswordStep currentStep = ForgetPasswordStep.email;
  String forgetPasswordToken = '';
  static const int _otpDurationSeconds = 180;
  int remainingSeconds = 0;
  Timer? _timer;

  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool get canResendOtp => remainingSeconds == 0;

  String get timerText {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// ===================== TIMER =====================
  void startOtpTimer() {
    _timer?.cancel();
    remainingSeconds = _otpDurationSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds == 0) {
        timer.cancel();
      } else {
        remainingSeconds--;
        update();
      }
    });
  }

  /// ===================== SEND FORGET PASSWORD EMAIL =====================
  Future<void> sendForgetPasswordEmail() async {
    try {
      _setLoading(true);
      await authRepository.sendForgotPasswordEmail(
        email: emailController.text.trim(),
      );
      AppSnackbar.success(
        title: 'Success',
        message: 'OTP sent to your email.',
      );
      currentStep = ForgetPasswordStep.otp;
      startOtpTimer();
      Get.toNamed(AppRoutes.verifyEmail);
    } catch (e) {
      AppSnackbar.error(
        title: 'Error',
        message: e.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      _setLoading(false);
    }
  }

  /// ===================== VERIFY OTP =====================
  Future<void> verifyOtp() async {
    try {
      _setLoading(true);
      final token = await authRepository.verifyOtp(
        email: emailController.text.trim(),
        otp: otpController.text.trim(),
      );
      if (token != null && token.isNotEmpty) {
        forgetPasswordToken = token;
        currentStep = ForgetPasswordStep.resetPassword;
        Get.toNamed(AppRoutes.createPassword);
      } else {
        AppSnackbar.error(title: 'Error', message: 'Invalid OTP. Try again.');
      }
    } catch (e) {
      AppSnackbar.error(
        title: 'Error',
        message: e.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      _setLoading(false);
    }
  }

  /// ===================== RESET PASSWORD =====================
  Future<void> resetPassword() async {
    if (passwordController.text != confirmPasswordController.text) {
      AppSnackbar.error(title: 'Error', message: 'Passwords do not match.');
      return;
    }
    try {
      _setLoading(true);
      await authRepository.resetPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        forgetPasswordToken: forgetPasswordToken,
      );
      _clearAll();
      Get.dialog(
        const PasswordChangedDialog(),
        barrierColor: const Color(0xFF020914).withOpacity(0.85),
        barrierDismissible: false,
      );
    } catch (e) {
      AppSnackbar.error(
        title: 'Error',
        message: e.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      _setLoading(false);
    }
  }

  /// ===================== RESEND OTP =====================
  Future<void> resendOtp() async {
    if (!canResendOtp) return;
    await sendForgetPasswordEmail();
  }

  /// ===================== HELPERS =====================
  void _setLoading(bool value) {
    isLoading = value;
    update();
  }

  void _clearAll() {
    emailController.clear();
    otpController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    _timer?.cancel();
    remainingSeconds = 0;
  }

  @override
  void onClose() {
    _timer?.cancel();
    emailController.dispose();
    otpController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
