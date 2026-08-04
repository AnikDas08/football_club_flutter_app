import 'package:football_club/services/api/api_response_model.dart';
import 'package:football_club/services/api/api_service.dart';

abstract class HomeRemoteDataSource {
  Future<ApiResponseModel> fetchHomeData();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<ApiResponseModel> fetchHomeData() async {
    return ApiResponseModel(
      200,
      {
        'data': {
          'sessionsCount': 42,
          'goalsCount': 18,
          'assistsCount': 11,
          'potmCount': 4,
        }
      },
    );
  }
}
