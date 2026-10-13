import 'package:football_club/config/api/api_end_point.dart';
import 'package:football_club/services/api/api_response_model.dart';
import 'package:football_club/services/api/api_service.dart';
import 'package:football_club/services/storage/storage_services.dart';

abstract class StatisticsRemoteDataSource {
  Future<ApiResponseModel> fetchStatisticsData();
}

class StatisticsRemoteDataSourceImpl implements StatisticsRemoteDataSource {
  @override
  Future<ApiResponseModel> fetchStatisticsData() async {
    final playerId = LocalStorage.playerId.isNotEmpty
        ? LocalStorage.playerId
        : '';

    if (playerId.isNotEmpty) {
      try {
        final response = await ApiService.get(ApiEndPoint.playerStats(playerId));
        if (response.statusCode == 200) {
          return response;
        }
      } catch (_) {
        // Fallback silently if API fails
      }
    }

    return ApiResponseModel(
      200,
      {
        'data': {
          'goalsByMonth': <Map<String, dynamic>>[],
          'attendanceAnalytics': {
            'attendanceRate': 0.0,
            'attended': '0%',
            'missed': '0%',
            'late': '0%',
            'sessions': 0,
          },
          'matchInvolvement': {
            'shots': 0,
            'onTarget': 0,
            'chances': 0,
          },
        }
      },
    );
  }
}
