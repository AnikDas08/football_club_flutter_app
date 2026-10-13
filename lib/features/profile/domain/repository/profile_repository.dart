import 'package:football_club/features/profile/domain/entity/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity?> getProfileData();
  Future<ProfileEntity?> updateProfile(Map<String, dynamic> body);
  Future<bool?> getNotificationPreferences();
  Future<bool> updateNotificationPreferences(bool push);
}
