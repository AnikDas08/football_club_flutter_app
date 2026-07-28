import 'package:flutter/cupertino.dart';
import 'package:football_club/services/storage/storage_keys.dart';
import 'package:get/get.dart';
import '../../../../../config/api/api_end_point.dart';
import '../../../../../config/route/app_routes.dart';
import '../../../../../services/api/api_client.dart';
import '../../../../../services/api/api_service.dart';
import '../../../../../services/storage/storage_services.dart';
import '../../../../../utils/app_snackbar.dart';

class SignInController extends GetxController {
  /// Sign in Button Loading variable
  bool isLoading = false;

  /// email and password Controller here
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final ApiClient apiClient = DioApiClient();

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

      final response = await apiClient.post(ApiEndPoint.signIn, body: body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data['data'] ?? '';
        LocalStorage.setString(LocalStorageKeys.token,data['accessToken'] ?? '');
        LocalStorage.setString(LocalStorageKeys.refreshToken,data['refreshToken'] ?? '');

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

  @override
  void onClose() {
    /*emailController.dispose();
    passwordController.dispose();*/
    super.onClose();
  }
}
