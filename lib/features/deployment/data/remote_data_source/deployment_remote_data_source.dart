import 'package:football_club/services/api/api_response_model.dart';
import 'package:football_club/services/api/api_service.dart';

abstract class DeploymentRemoteDataSource {
  Future<ApiResponseModel> fetchDeploymentData();
}

class DeploymentRemoteDataSourceImpl implements DeploymentRemoteDataSource {
  @override
  Future<ApiResponseModel> fetchDeploymentData() async {
    return ApiResponseModel(
      200,
      {
        'data': {
          'overallScore': 8.2,
          'maxScore': 10.0,
          'improvement': '+6.1%',
          'status': 'Excellent',
          'developmentAreas': [
            {"icon": "⚽", "name": "Technical", "score": 7.6, "progress": 0.76},
            {"icon": "🧠", "name": "Mentality", "score": 7.1, "progress": 0.71},
            {"icon": "💪", "name": "Physicality", "score": 7.0, "progress": 0.70},
            {"icon": "🎯", "name": "Psychological", "score": 7.4, "progress": 0.74},
            {"icon": "🏆", "name": "Social", "score": 8.0, "progress": 0.80},
          ],
          'footballSkills': [
            {"name": "Shooting", "stars": 4, "score": "4"},
            {"name": "Passing", "stars": 5, "score": "4.5"},
            {"name": "Dribbling", "stars": 4, "score": "4"},
            {"name": "Football IQ", "stars": 5, "score": "4.5"},
            {"name": "Speed", "stars": 4, "score": "3.5"},
            {"name": "Communication", "stars": 4, "score": "4"},
          ],
          'growthMonths': ["Aug", "Sep", "Oct", "Nov", "Dec", "Jan", "Feb"],
          'growthValues': [6.75, 7.1, 7.4, 7.35, 7.8, 8.0, 8.25],
        }
      },
    );
  }
}
