import 'package:football_club/features/statistics/data/model/statistics_model.dart';
import 'package:football_club/features/statistics/data/remote_data_source/statistics_remote_data_source.dart';
import 'package:football_club/features/statistics/domain/entity/statistics_entity.dart';
import 'package:football_club/features/statistics/domain/repository/statistics_repository.dart';

class StatisticsRepositoryImpl implements StatisticsRepository {
  final StatisticsRemoteDataSource remoteDataSource;

  StatisticsRepositoryImpl({StatisticsRemoteDataSource? remoteDataSource})
      : remoteDataSource =
            remoteDataSource ?? StatisticsRemoteDataSourceImpl();

  @override
  Future<StatisticsEntity?> getStatisticsData() async {
    final response = await remoteDataSource.fetchStatisticsData();
    if (response.statusCode == 200) {
      final data = response.data['data'] ?? {};
      return StatisticsModel.fromJson(data);
    }
    return null;
  }
}
