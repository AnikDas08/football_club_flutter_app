import 'dart:io';
import 'package:football_club/config/api/api_end_point.dart';
import 'package:football_club/services/api/api_response_model.dart';
import 'package:football_club/services/api/api_service.dart';

import 'package:football_club/features/profile/data/model/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel?> fetchProfileData();
  Future<ProfileModel?> updateProfile(Map<String, dynamic> body);
  Future<bool?> fetchNotificationPreferences();
  Future<bool> updateNotificationPreferences(bool push);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  @override
  Future<bool?> fetchNotificationPreferences() async {
    try {
      final response = await ApiService.get(ApiEndPoint.notificationPreferences);
      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['data'];
        if (data != null && data['push'] != null) {
          return data['push'] as bool;
        }
      }
    } catch (_) {}
    return null;
  }

  @override
  Future<bool> updateNotificationPreferences(bool push) async {
    try {
      final response = await ApiService.patch(
        ApiEndPoint.notificationPreferences,
        body: {'push': push},
      );
      return response.isSuccess;
    } catch (_) {}
    return false;
  }

  @override
  Future<ProfileModel?> fetchProfileData() async {
    try {
      final response = await ApiService.get(ApiEndPoint.userProfile);
      if (response.statusCode == 200 && response.data['data'] != null) {
        return ProfileModel.fromJson(response.data['data']);
      }
    } catch (_) {}
    return null;
  }

  @override
  Future<ProfileModel?> updateProfile(Map<String, dynamic> body) async {
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

    ApiResponseModel response;
    if (hasImageFile) {
      final Map<String, dynamic> multipartBody = {};
      if (patchBody.isNotEmpty) {
        multipartBody['data'] = patchBody;
      }

      response = await ApiService.multipartImage(
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
      response = await ApiService.patch(
        ApiEndPoint.userProfile,
        body: patchBody,
      );
    }

    if (response.isSuccess) {
      if (response.data is Map && response.data['data'] != null) {
        return ProfileModel.fromJson(response.data['data']);
      }
      return await fetchProfileData();
    }
    return null;
  }
}
