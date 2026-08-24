import 'dart:io';
import 'package:football_club/config/api/api_end_point.dart';
import 'package:football_club/services/api/api_response_model.dart';
import 'package:football_club/services/api/api_service.dart';

abstract class ProfileRemoteDataSource {
  Future<ApiResponseModel> fetchProfileData();
  Future<ApiResponseModel> updateProfile(Map<String, dynamic> body);
  Future<ApiResponseModel> fetchNotificationPreferences();
  Future<ApiResponseModel> updateNotificationPreferences(bool push);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  @override
  Future<ApiResponseModel> fetchNotificationPreferences() async {
    return await ApiService.get(ApiEndPoint.notificationPreferences);
  }

  @override
  Future<ApiResponseModel> updateNotificationPreferences(bool push) async {
    return await ApiService.patch(
      ApiEndPoint.notificationPreferences,
      body: {'push': push},
    );
  }

  @override
  Future<ApiResponseModel> fetchProfileData() async {
    return await ApiService.get(ApiEndPoint.userProfile);
  }

  @override
  Future<ApiResponseModel> updateProfile(Map<String, dynamic> body) async {
    final String imagePath =
        (body['profileImagePath'] ?? body['image'] ?? '').toString();
    final bool hasImageFile = imagePath.isNotEmpty &&
        !imagePath.startsWith('http') &&
        !imagePath.startsWith('assets/') &&
        File(imagePath).existsSync();

    final Map<String, dynamic> patchBody = {};

    if (body.containsKey('firstName') &&
        (body['firstName'] is String) &&
        (body['firstName'] as String).isNotEmpty) {
      patchBody['firstName'] = (body['firstName'] as String).trim();
    }
    if (body.containsKey('lastName') &&
        (body['lastName'] is String) &&
        (body['lastName'] as String).isNotEmpty) {
      patchBody['lastName'] = (body['lastName'] as String).trim();
    }

    if (!patchBody.containsKey('firstName') &&
        body.containsKey('playerName') &&
        (body['playerName'] is String) &&
        (body['playerName'] as String).isNotEmpty) {
      final String fullPlayerName = (body['playerName'] as String).trim();
      if (fullPlayerName.contains(' ')) {
        final parts = fullPlayerName.split(' ');
        patchBody['firstName'] = parts.first;
        patchBody['lastName'] = parts.sublist(1).join(' ');
      } else {
        patchBody['firstName'] = fullPlayerName;
        patchBody['lastName'] = '';
      }
    }

    // Map parentName to top-level name
    if (body.containsKey('parentName') &&
        (body['parentName'] is String) &&
        (body['parentName'] as String).isNotEmpty) {
      patchBody['name'] = (body['parentName'] as String).trim();
    }

    // Map position to playingPosition
    if (body.containsKey('position') &&
        (body['position'] is String) &&
        (body['position'] as String).isNotEmpty) {
      patchBody['playingPosition'] = body['position'];
    }

    // Map preferredFoot to favouriteFoot
    if (body.containsKey('preferredFoot') &&
        (body['preferredFoot'] is String) &&
        (body['preferredFoot'] as String).isNotEmpty) {
      patchBody['favouriteFoot'] = body['preferredFoot'];
    }

    // Pass through other fields if present and not empty
    if (body.containsKey('dob') &&
        (body['dob'] is String) &&
        (body['dob'] as String).isNotEmpty) {
      patchBody['dob'] = body['dob'];
    }
    if (body.containsKey('mobile') &&
        (body['mobile'] is String) &&
        (body['mobile'] as String).isNotEmpty) {
      patchBody['mobile'] = body['mobile'];
    }

    if (hasImageFile) {
      final Map<String, dynamic> multipartBody = {};
      if (patchBody.isNotEmpty) {
        multipartBody['data'] = patchBody;
      }

      return await ApiService.multipartImage(
        ApiEndPoint.userProfile,
        method: 'PATCH',
        body: multipartBody,
        files: [
          {
            'name': 'image',
            'image': imagePath,
          }
        ],
      );
    } else {
      return await ApiService.patch(
        ApiEndPoint.userProfile,
        body: patchBody,
      );
    }
  }
}
