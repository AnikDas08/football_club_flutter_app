import 'package:football_club/features/statistics/data/remote_data_source/statistics_remote_data_source.dart';
import 'package:football_club/features/statistics/domain/entity/statistics_entity.dart';
import 'package:football_club/features/statistics/domain/repository/statistics_repository.dart';
import 'package:football_club/services/storage/storage_services.dart';

class StatisticsRepositoryImpl implements StatisticsRepository {
  final StatisticsRemoteDataSource remoteDataSource;

  StatisticsRepositoryImpl({StatisticsRemoteDataSource? remoteDataSource})
      : remoteDataSource =
            remoteDataSource ?? StatisticsRemoteDataSourceImpl();

  @override
  Future<StatisticsEntity?> getStatisticsData() async {
    final playerId = LocalStorage.playerId.trim();
    if (playerId.isEmpty) return null;
    return await remoteDataSource.fetchStatisticsData(playerId: playerId);
  }
}
