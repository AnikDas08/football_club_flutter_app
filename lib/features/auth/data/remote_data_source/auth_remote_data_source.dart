import 'package:football_club/config/api/api_end_point.dart';
import 'package:football_club/services/api/api_response_model.dart';
import 'package:football_club/services/api/api_service.dart';

abstract class AuthRemoteDataSource {
  Future<ApiResponseModel> signIn({required String email, required String password});
  Future<ApiResponseModel> signUp({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String countryCode,
    required String password,
    required String role,
  });
  Future<ApiResponseModel> verifyEmail({required String otp, required String signUpToken});
  Future<ApiResponseModel> forgotPassword({required String email});
  Future<ApiResponseModel> verifyOtp({required String email, required String otp});
  Future<ApiResponseModel> resetPassword({
    required String email,
    required String password,
    required String forgetPasswordToken,
  });
  Future<ApiResponseModel> changePassword({
    required String oldPassword,
    required String newPassword,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<ApiResponseModel> signIn({
    required String email,
    required String password,
  }) async {
    final body = {
      'email': email,
      'password': password,
    };
    return await ApiService.post(ApiEndPoint.signIn, body: body);
  }

  @override
  Future<ApiResponseModel> signUp({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String countryCode,
    required String password,
    required String role,
  }) async {
    final body = {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'countryCode': countryCode,
      'password': password,
      'role': role,
    };
    return await ApiService.post(ApiEndPoint.signUp, body: body);
  }

  @override
  Future<ApiResponseModel> verifyEmail({
    required String otp,
    required String signUpToken,
  }) async {
    final body = {'otp': otp};
    final headers = {'SignUpToken': 'signUpToken $signUpToken'};
    return await ApiService.post(
      ApiEndPoint.verifyEmail,
      body: body,
      header: headers,
    );
  }

  @override
  Future<ApiResponseModel> forgotPassword({required String email}) async {
    return await ApiService.post(
      ApiEndPoint.forgotPassword,
      body: {'email': email},
    );
  }

  @override
  Future<ApiResponseModel> verifyOtp({
    required String email,
    required String otp,
  }) async {
    return await ApiService.post(
      ApiEndPoint.verifyOtp,
      body: {
        'email': email,
        'oneTimeCode': int.tryParse(otp) ?? otp,
      },
    );
  }

  @override
  Future<ApiResponseModel> resetPassword({
    required String email,
    required String password,
    required String forgetPasswordToken,
  }) async {
    final headers = {'token': forgetPasswordToken};
    final body = {
      'newPassword': password,
      'confirmPassword': password,
    };
    return await ApiService.post(
      ApiEndPoint.resetPassword,
      header: headers,
      body: body,
    );
  }

  @override
  Future<ApiResponseModel> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final body = {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
    return await ApiService.patch(
      ApiEndPoint.changePassword,
      body: body,
    );
  }
}
