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
    return await remoteDataSource.fetchProfileData();
  }

  @override
  Future<ProfileEntity?> updateProfile(Map<String, dynamic> body) async {
    return await remoteDataSource.updateProfile(body);
  }

  @override
  Future<bool?> getNotificationPreferences() async {
    return await remoteDataSource.fetchNotificationPreferences();
  }

  @override
  Future<bool> updateNotificationPreferences(bool push) async {
    return await remoteDataSource.updateNotificationPreferences(push);
  }
}

