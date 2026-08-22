import 'package:football_club/config/api/api_end_point.dart';
import 'package:football_club/services/api/api_response_model.dart';
import 'package:football_club/services/api/api_service.dart';
import 'package:football_club/services/storage/storage_services.dart';

abstract class DeploymentRemoteDataSource {
  Future<ApiResponseModel> fetchDeploymentData();
  Future<ApiResponseModel> fetchPlayerTargets({
    required String playerId,
    int page = 1,
    int limit = 10,
  });
  Future<ApiResponseModel> fetchSessionNotes({
    required String playerId,
    int page = 1,
    int limit = 10,
  });
  Future<ApiResponseModel> fetchDevelopmentTimeline({required String playerId});
  Future<ApiResponseModel> fetchPlayerAchievements({required String playerId});
}

class DeploymentRemoteDataSourceImpl implements DeploymentRemoteDataSource {
  @override
  Future<ApiResponseModel> fetchDeploymentData() async {
    final Map<String, dynamic> deploymentDataMap = {
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
    };

    final playerId = LocalStorage.playerId.isNotEmpty
        ? LocalStorage.playerId
        : '4345454';

    try {
      final response = await ApiService.get(ApiEndPoint.overallScore(playerId));
      if (response.statusCode == 200) {
        final scoreData = response.data['data'] as Map<String, dynamic>?;
        if (scoreData != null) {
          final dynamic rawScore = scoreData['overallScore'];
          final String monthlyImprovement = scoreData['monthlyImprovement'] ?? '';
          final String performanceBadge = scoreData['performanceBadge'] ?? '';
          final String overallScoreText = scoreData['overallScoreText'] ?? '';

          double scoreVal = 0.0;
          if (rawScore is num) {
            scoreVal = rawScore.toDouble();
          } else if (rawScore is String) {
            scoreVal = double.tryParse(rawScore) ?? 0.0;
          }

          double maxScoreVal = 10.0;
          if (overallScoreText.contains('/')) {
            final parts = overallScoreText.split('/');
            if (parts.length > 1) {
              maxScoreVal = double.tryParse(parts[1].trim()) ?? 10.0;
            }
          }

          deploymentDataMap['overallScore'] = scoreVal;
          deploymentDataMap['maxScore'] = maxScoreVal;
          if (monthlyImprovement.isNotEmpty) {
            deploymentDataMap['improvement'] = monthlyImprovement;
          }
          if (performanceBadge.isNotEmpty) {
            deploymentDataMap['status'] = performanceBadge;
          }
        }
      }
    } catch (_) {
      // Fallback silently if API call fails
    }

    try {
      final response = await ApiService.get(ApiEndPoint.coreAreas(playerId));
      if (response.statusCode == 200) {
        final coreData = response.data['data'] as Map<String, dynamic>?;
        if (coreData != null) {
          final double technical = (coreData['technical'] as num?)?.toDouble() ?? 0.0;
          final double mentality = (coreData['mentality'] as num?)?.toDouble() ?? 0.0;
          final double physical = (coreData['physical'] as num?)?.toDouble() ?? 0.0;
          final double psychological = (coreData['psychological'] as num?)?.toDouble() ?? 0.0;
          final double social = (coreData['social'] as num?)?.toDouble() ?? 0.0;

          deploymentDataMap['developmentAreas'] = [
            {"icon": "⚽", "name": "Technical", "score": technical, "progress": (technical / 10.0).clamp(0.0, 1.0)},
            {"icon": "🧠", "name": "Mentality", "score": mentality, "progress": (mentality / 10.0).clamp(0.0, 1.0)},
            {"icon": "💪", "name": "Physicality", "score": physical, "progress": (physical / 10.0).clamp(0.0, 1.0)},
            {"icon": "🎯", "name": "Psychological", "score": psychological, "progress": (psychological / 10.0).clamp(0.0, 1.0)},
            {"icon": "🏆", "name": "Social", "score": social, "progress": (social / 10.0).clamp(0.0, 1.0)},
          ];
        }
      }
    } catch (_) {
      // Fallback silently if core areas API call fails
    }

    try {
      final response = await ApiService.get(ApiEndPoint.footballSkills(playerId));
      if (response.statusCode == 200) {
        final skillData = response.data['data'] as Map<String, dynamic>?;
        if (skillData != null) {
          final double shooting = (skillData['shooting'] as num?)?.toDouble() ?? 0.0;
          final double passing = (skillData['passing'] as num?)?.toDouble() ?? 0.0;
          final double dribbling = (skillData['dribbling'] as num?)?.toDouble() ?? 0.0;
          final double footballIQ = (skillData['footballIQ'] as num?)?.toDouble() ?? 0.0;
          final double speed = (skillData['speed'] as num?)?.toDouble() ?? 0.0;
          final double communication = (skillData['communication'] as num?)?.toDouble() ?? 0.0;

          String formatScore(double val) =>
              val % 1 == 0 ? val.toInt().toString() : val.toString();

          deploymentDataMap['footballSkills'] = [
            {"name": "Shooting", "stars": shooting.round(), "score": formatScore(shooting)},
            {"name": "Passing", "stars": passing.round(), "score": formatScore(passing)},
            {"name": "Dribbling", "stars": dribbling.round(), "score": formatScore(dribbling)},
            {"name": "Football IQ", "stars": footballIQ.round(), "score": formatScore(footballIQ)},
            {"name": "Speed", "stars": speed.round(), "score": formatScore(speed)},
            {"name": "Communication", "stars": communication.round(), "score": formatScore(communication)},
          ];
        }
      }
    } catch (_) {
      // Fallback silently if football skills API call fails
    }

    try {
      final response = await ApiService.get(ApiEndPoint.growthChart(playerId));
      if (response.statusCode == 200) {
        final rawList = response.data['data'] as List<dynamic>?;
        if (rawList != null && rawList.isNotEmpty) {
          final List<String> months = [];
          final List<double> values = [];

          for (final item in rawList) {
            if (item is Map<String, dynamic>) {
              final String month = item['month'] ?? '';
              final double score = ((item['overallScore'] as num?) ?? 0).toDouble();
              months.add(month);
              values.add(score);
            }
          }

          if (months.isNotEmpty && values.isNotEmpty) {
            deploymentDataMap['growthMonths'] = months;
            deploymentDataMap['growthValues'] = values;
          }
        }
      }
    } catch (_) {
      // Fallback silently if growth chart API call fails
    }

    return ApiResponseModel(200, {'data': deploymentDataMap});
  }

  @override
  Future<ApiResponseModel> fetchPlayerTargets({
    required String playerId,
    int page = 1,
    int limit = 10,
  }) async {
    return await ApiService.get(
      ApiEndPoint.myTargets(playerId, page: page, limit: limit),
    );
  }

  @override
  Future<ApiResponseModel> fetchSessionNotes({
    required String playerId,
    int page = 1,
    int limit = 10,
  }) async {
    return await ApiService.get(
      ApiEndPoint.sessionNotes(playerId, page: page, limit: limit),
    );
  }

  @override
  Future<ApiResponseModel> fetchDevelopmentTimeline({
    required String playerId,
  }) async {
    return await ApiService.get(
      ApiEndPoint.developmentTimeline(playerId),
    );
  }

  @override
  Future<ApiResponseModel> fetchPlayerAchievements({
    required String playerId,
  }) async {
    return await ApiService.get(
      ApiEndPoint.myAchievements(playerId),
    );
  }
}
