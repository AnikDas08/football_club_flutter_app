import 'package:football_club/features/profile/data/model/profile_model.dart';
import 'package:football_club/features/profile/data/remote_data_source/profile_remote_data_source.dart';
import 'package:football_club/features/profile/domain/entity/profile_entity.dart';
import 'package:football_club/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({ProfileRemoteDataSource? remoteDataSource})
      : remoteDataSource =
            remoteDataSource ?? ProfileRemoteDataSourceImpl();

  @override
  Future<ProfileEntity?> getProfileData() async {
    final response = await remoteDataSource.fetchProfileData();
    if (response.statusCode == 200) {
      final data = response.data['data'] ?? {};
      return ProfileModel.fromJson(data);
    }
    return null;
  }

  @override
  Future<ProfileEntity?> updateProfile(Map<String, dynamic> body) async {
    final response = await remoteDataSource.updateProfile(body);
    if (response.isSuccess) {
      if (response.data is Map && response.data['data'] != null) {
        return ProfileModel.fromJson(response.data['data']);
      }
      return await getProfileData();
    }
    return null;
  }

  @override
  Future<bool?> getNotificationPreferences() async {
    final response = await remoteDataSource.fetchNotificationPreferences();
    if (response.statusCode == 200) {
      final data = response.data['data'];
      if (data != null && data['push'] != null) {
        return data['push'] as bool;
      }
    }
    return null;
  }

  @override
  Future<bool> updateNotificationPreferences(bool push) async {
    final response =
        await remoteDataSource.updateNotificationPreferences(push);
    return response.isSuccess;
  }
}
