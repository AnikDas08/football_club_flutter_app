import 'package:flutter/cupertino.dart';
import 'package:football_club/config/api/api_end_point.dart';
import 'package:football_club/config/route/app_routes.dart';
import 'package:football_club/services/api/api_response_model.dart';
import 'package:football_club/services/api/api_service.dart';
import 'package:football_club/utils/app_snackbar.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  /// controllers
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  /// Form Key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// loading
  bool isLoading = false;

  void _setLoading(bool value) {
    isLoading = value;
    update();
  }

  /// Change Password API Method
  Future<void> changePassword() async {
    if (!formKey.currentState!.validate()) return;

    try {
      _setLoading(true);

      final Map<String, String> body = {
        'currentPassword': currentPasswordController.text.trim(),
        'newPassword': newPasswordController.text.trim(),
        'confirmPassword': confirmPasswordController.text.trim(),
      };

      ApiResponseModel response = await ApiService.post(
        ApiEndPoint.changePassword,
        body: body,
      );

      if (response.statusCode != 200) {
        response = await ApiService.patch(
          ApiEndPoint.changePassword,
          body: body,
        );
      }

      if (response.statusCode == 200) {
        /// Clear text fields
        currentPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();

        // Redirect to Home screen
        Get.offAllNamed(AppRoutes.home);

        // Show global success snackbar on Home screen
        AppSnackbar.success(
          title: 'Success',
          message: response.message.isNotEmpty
              ? response.message
              : 'Password changed successfully',
        );
      } else {
        AppSnackbar.error(
          title: 'Error',
          message: response.message.isNotEmpty
              ? response.message
              : 'Failed to change password',
        );
      }
    } catch (e) {
      AppSnackbar.error(
        title: 'Error',
        message: 'Something went wrong: ${e.toString()}',
      );
    } finally {
      _setLoading(false);
    }
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
