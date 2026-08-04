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
  Future<bool> updateProfile(ProfileEntity profile) async {
    final model = ProfileModel(
      playerName: profile.playerName,
      email: profile.email,
      dob: profile.dob,
      parentName: profile.parentName,
      mobile: profile.mobile,
      position: profile.position,
      preferredFoot: profile.preferredFoot,
      profileImagePath: profile.profileImagePath,
    );
    final response = await remoteDataSource.updateProfile(model.toJson());
    return response.statusCode == 200;
  }
}
