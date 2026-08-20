import 'package:football_club/features/auth/data/model/user_model.dart';
import 'package:football_club/features/auth/data/remote_data_source/auth_remote_data_source.dart';
import 'package:football_club/features/auth/domain/entity/user_entity.dart';
import 'package:football_club/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({AuthRemoteDataSource? remoteDataSource})
      : remoteDataSource = remoteDataSource ?? AuthRemoteDataSourceImpl();

  @override
  Future<UserEntity?> signIn({
    required String email,
    required String password,
  }) async {
    final response = await remoteDataSource.signIn(email: email, password: password);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data['data'] ?? {};
      return UserModel.fromJson(data);
    }
    throw Exception(response.message);
  }

  @override
  Future<String?> signUp({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String countryCode,
    required String password,
    required String role,
  }) async {
    final response = await remoteDataSource.signUp(
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      countryCode: countryCode,
      password: password,
      role: role,
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data['data'] ?? {};
      return data['signUpToken'] as String?;
    }
    return null;
  }

  @override
  Future<UserEntity?> verifyEmail({
    required String otp,
    required String signUpToken,
  }) async {
    final response = await remoteDataSource.verifyEmail(
      otp: otp,
      signUpToken: signUpToken,
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data['data'] ?? {};
      return UserModel.fromJson(data);
    }
    return null;
  }

  @override
  Future<void> sendForgotPasswordEmail({required String email}) async {
    final response = await remoteDataSource.forgotPassword(email: email);
    if (response.statusCode != 200) {
      throw Exception(response.message);
    }
  }

  @override
  Future<String?> verifyOtp({
    required String email,
    required String otp,
  }) async {
    final response = await remoteDataSource.verifyOtp(email: email, otp: otp);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data['data'] ?? {};
      return data['verifyToken'] as String?;
    }
    throw Exception(response.message);
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String password,
    required String forgetPasswordToken,
  }) async {
    final response = await remoteDataSource.resetPassword(
      email: email,
      password: password,
      forgetPasswordToken: forgetPasswordToken,
    );
    if (response.statusCode != 200) {
      throw Exception(response.message);
    }
  }

  @override
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    await remoteDataSource.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }
}
