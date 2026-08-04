import 'package:football_club/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> signIn({
    required String email,
    required String password,
  });

  Future<String?> signUp({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String countryCode,
    required String password,
    required String role,
  });

  Future<UserEntity?> verifyEmail({
    required String otp,
    required String signUpToken,
  });

  Future<void> sendForgotPasswordEmail({
    required String email,
  });

  Future<String?> verifyOtp({
    required String email,
    required String otp,
  });

  Future<void> resetPassword({
    required String email,
    required String password,
    required String forgetPasswordToken,
  });

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  });
}
