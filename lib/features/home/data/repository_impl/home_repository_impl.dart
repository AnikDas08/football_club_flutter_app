import 'package:football_club/features/home/data/model/home_model.dart';
import 'package:football_club/features/home/data/remote_data_source/home_remote_data_source.dart';
import 'package:football_club/features/home/domain/entity/home_entity.dart';
import 'package:football_club/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({HomeRemoteDataSource? remoteDataSource})
      : remoteDataSource = remoteDataSource ?? HomeRemoteDataSourceImpl();

  @override
  Future<HomeEntity?> getHomeDashboardData() async {
    final response = await remoteDataSource.fetchHomeData();
    if (response.statusCode == 200) {
      final data = response.data['data'] ?? {};
      return HomeModel.fromJson(data);
    }
    return null;
  }
}
