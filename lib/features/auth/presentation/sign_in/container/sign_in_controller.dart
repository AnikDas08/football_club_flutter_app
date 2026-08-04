import 'package:flutter/cupertino.dart';
import 'package:football_club/config/api/api_end_point.dart';
import 'package:football_club/config/route/app_routes.dart';
import 'package:football_club/services/api/api_service.dart';
import 'package:football_club/services/storage/storage_keys.dart';
import 'package:football_club/services/storage/storage_services.dart';
import 'package:football_club/utils/app_snackbar.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  /// Sign in Button Loading variable
  bool isLoading = false;

  /// email and password Controller here
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// Sign in Api call here
  Future<void> signInUser() async {
    if (isLoading) return;

    try {
      isLoading = true;
      update();

      Get.offAllNamed(AppRoutes.home);
      return;

      final Map<String, String> body = {
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
      };

      final response = await ApiService.post(ApiEndPoint.signIn, body: body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data['data'] ?? '';
        LocalStorage.setString(LocalStorageKeys.token, data['accessToken'] ?? '');
        LocalStorage.setString(LocalStorageKeys.refreshToken, data['refreshToken'] ?? '');

        /// clear
        emailController.clear();
        passwordController.clear();

        /// navigate
        Get.offAllNamed(AppRoutes.home);
      } else {
        AppSnackbar.error(
          title: response.statusCode.toString(),
          message: response.message,
        );
      }
    } catch (e) {
      AppSnackbar.error(title: 'Error', message: e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }
}
