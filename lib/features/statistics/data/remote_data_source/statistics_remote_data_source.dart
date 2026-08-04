import 'package:football_club/services/api/api_response_model.dart';

abstract class StatisticsRemoteDataSource {
  Future<ApiResponseModel> fetchStatisticsData();
}

class StatisticsRemoteDataSourceImpl implements StatisticsRemoteDataSource {
  @override
  Future<ApiResponseModel> fetchStatisticsData() async {
    return ApiResponseModel(
      200,
      {
        'data': {
          'goalsByMonth': [
            {"month": "Aug", "value": 2},
            {"month": "Sep", "value": 3},
            {"month": "Oct", "value": 2},
            {"month": "Nov", "value": 4},
            {"month": "Dec", "value": 1},
            {"month": "Jan", "value": 3},
            {"month": "Feb", "value": 3},
          ],
          'attendanceRate': 0.87,
          'attendedPercentage': '87%',
          'missedPercentage': '8%',
          'latePercentage': '5%',
          'playerImagePath': 'assets/images/player_image.png',
          'shotsCount': 72,
          'onTargetCount': 41,
          'chancesCreatedCount': 28,
        }
      },
    );
  }
}
