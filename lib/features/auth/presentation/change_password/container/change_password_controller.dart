import 'package:flutter/cupertino.dart';
import 'package:football_club/config/api/api_end_point.dart';
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
        'oldPassword': currentPasswordController.text.trim(),
        'newPassword': newPasswordController.text.trim(),
      };

      final response = await ApiService.patch(
        ApiEndPoint.changePassword,
        body: body,
      );

      if (response.statusCode == 200) {
        AppSnackbar.success(
          title: 'Success',
          message: 'Password changed successfully',
        );

        /// Clear text fields
        currentPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();

        Get.back();
      } else {
        AppSnackbar.error(
          title: response.statusCode.toString(),
          message: response.message,
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
