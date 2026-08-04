import 'package:football_club/services/api/api_response_model.dart';
import 'package:football_club/services/api/api_service.dart';

abstract class ProfileRemoteDataSource {
  Future<ApiResponseModel> fetchProfileData();
  Future<ApiResponseModel> updateProfile(Map<String, dynamic> body);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  @override
  Future<ApiResponseModel> fetchProfileData() async {
    return ApiResponseModel(
      200,
      {
        'data': {
          'playerName': 'James Thornton',
          'email': 'james.thornton@example.com',
          'dob': '02-02-2000',
          'parentName': 'Robert Thornton',
          'mobile': '+44 7911 123456',
          'position': 'Attacking Midfielder',
          'preferredFoot': 'Right',
          'profileImagePath': 'assets/images/profile_image.png',
        }
      },
    );
  }

  @override
  Future<ApiResponseModel> updateProfile(Map<String, dynamic> body) async {
    return ApiResponseModel(200, {'message': 'Profile updated successfully'});
  }
}
