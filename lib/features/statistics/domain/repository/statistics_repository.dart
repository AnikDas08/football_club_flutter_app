import 'package:football_club/features/statistics/domain/entity/statistics_entity.dart';

abstract class StatisticsRepository {
  Future<StatisticsEntity?> getStatisticsData();
}
