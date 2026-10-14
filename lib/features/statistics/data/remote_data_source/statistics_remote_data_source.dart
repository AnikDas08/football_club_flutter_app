import 'package:football_club/config/api/api_end_point.dart';
import 'package:football_club/features/statistics/data/model/statistics_model.dart';
import 'package:football_club/services/api/api_service.dart';

abstract class StatisticsRemoteDataSource {
  Future<StatisticsModel?> fetchStatisticsData({required String playerId});
}

class StatisticsRemoteDataSourceImpl implements StatisticsRemoteDataSource {
  @override
  Future<StatisticsModel?> fetchStatisticsData({required String playerId}) async {
    if (playerId.isEmpty) return null;
    try {
      final response = await ApiService.get(ApiEndPoint.playerStats(playerId));
      if (response.statusCode == 200 && response.data['data'] != null) {
        return StatisticsModel.fromJson(response.data['data']);
      }
    } catch (_) {}
    return null;
  }
}
