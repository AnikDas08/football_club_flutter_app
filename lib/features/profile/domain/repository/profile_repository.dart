import 'package:football_club/features/profile/domain/entity/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity?> getProfileData();
  Future<bool> updateProfile(Map<String, dynamic> body);
}
