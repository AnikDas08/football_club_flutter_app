import 'package:flutter/cupertino.dart';
import 'package:football_club/config/route/app_routes.dart';
import 'package:football_club/features/auth/data/repository_impl/auth_repository_impl.dart';
import 'package:football_club/features/auth/domain/entity/user_entity.dart';
import 'package:football_club/features/auth/domain/repository/auth_repository.dart';
import 'package:football_club/services/storage/storage_keys.dart';
import 'package:football_club/services/storage/storage_services.dart';
import 'package:football_club/utils/app_snackbar.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final AuthRepository authRepository;

  SignInController({AuthRepository? authRepository})
      : authRepository = authRepository ?? AuthRepositoryImpl();

  /// Sign in Button Loading variable
  bool isLoading = false;

  /// email and password Controller here
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// Sign in via AuthRepository → AuthRepositoryImpl → AuthRemoteDataSourceImpl
  Future<void> signInUser() async {
    if (isLoading) return;

    try {
      isLoading = true;
      update();

      final UserEntity? user = await authRepository.signIn(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (user != null) {
        final String accessToken = user.accessToken ?? '';
        final String refreshToken = user.refreshToken ?? '';
        final String userId = user.id ?? '';
        final String playerId = user.playerId ?? '';

        /// Store tokens in SharedPreferences
        await LocalStorage.setString(LocalStorageKeys.token, accessToken);
        await LocalStorage.setString(LocalStorageKeys.refreshToken, refreshToken);
        await LocalStorage.setString(LocalStorageKeys.userId, userId);
        await LocalStorage.setString(LocalStorageKeys.playerId, playerId);
        await LocalStorage.setBool(LocalStorageKeys.isLogIn, true);

        /// Update in-memory variables immediately
        LocalStorage.token = accessToken;
        LocalStorage.refreshToken = refreshToken;
        LocalStorage.userId = userId;
        LocalStorage.playerId = playerId;
        LocalStorage.isLogIn = true;

        /// Clear form fields
        emailController.clear();
        passwordController.clear();

        /// Navigate to home
        Get.offAllNamed(AppRoutes.home);
      } else {
        AppSnackbar.error(
          title: 'Sign In Failed',
          message: 'Invalid email or password.',
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
    super.onClose();
  }
}
