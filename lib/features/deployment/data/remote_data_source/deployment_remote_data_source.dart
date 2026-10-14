import 'package:football_club/config/api/api_end_point.dart';
import 'package:football_club/features/deployment/data/model/achievement_model.dart';
import 'package:football_club/features/deployment/data/model/deployment_model.dart';
import 'package:football_club/features/deployment/data/model/player_target_model.dart';
import 'package:football_club/features/deployment/data/model/timeline_item_model.dart';
import 'package:football_club/features/home/data/model/session_note_model.dart';
import 'package:football_club/services/api/api_service.dart';

abstract class DeploymentRemoteDataSource {
  Future<DeploymentModel?> fetchDeploymentData({required String playerId});
  Future<({List<PlayerTargetModel> targets, int totalPage})> fetchPlayerTargets({
    required String playerId,
    int page = 1,
    int limit = 10,
  });
  Future<({List<SessionNoteModel> notes, int totalPage})> fetchSessionNotes({
    required String playerId,
    int page = 1,
    int limit = 10,
  });
  Future<List<TimelineItemModel>> fetchDevelopmentTimeline({
    required String playerId,
  });
  Future<AchievementDataModel?> fetchPlayerAchievements({
    required String playerId,
  });
}

class DeploymentRemoteDataSourceImpl implements DeploymentRemoteDataSource {
  @override
  Future<DeploymentModel?> fetchDeploymentData({required String playerId}) async {
    if (playerId.isEmpty) return null;

    double scoreVal = 0.0;
    double maxScoreVal = 10.0;
    String improvement = '0%';
    String status = 'No Assessment';
    List<DevelopmentAreaModel> areas = [];
    List<FootballSkillModel> skills = [];
    List<String> months = [];
    List<double> values = [];

    Future<void> loadOverallScore() async {
      try {
        final response =
            await ApiService.get(ApiEndPoint.overallScore(playerId));
        if (response.statusCode == 200 && response.data['data'] != null) {
          final scoreData = response.data['data'] as Map<String, dynamic>;
          final dynamic rawScore = scoreData['overallScore'];
          final String monthlyImprovement =
              scoreData['monthlyImprovement'] ?? '';
          final String performanceBadge = scoreData['performanceBadge'] ?? '';
          final String overallScoreText = scoreData['overallScoreText'] ?? '';

          if (rawScore is num) {
            scoreVal = rawScore.toDouble();
          } else if (rawScore is String) {
            scoreVal = double.tryParse(rawScore) ?? 0.0;
          }

          if (overallScoreText.contains('/')) {
            final parts = overallScoreText.split('/');
            if (parts.length > 1) {
              maxScoreVal = double.tryParse(parts[1].trim()) ?? 10.0;
            }
          }

          if (monthlyImprovement.isNotEmpty) improvement = monthlyImprovement;
          if (performanceBadge.isNotEmpty) status = performanceBadge;
        }
      } catch (_) {}
    }

    Future<void> loadCoreAreas() async {
      try {
        final response = await ApiService.get(ApiEndPoint.coreAreas(playerId));
        if (response.statusCode == 200 && response.data['data'] != null) {
          final coreData = response.data['data'] as Map<String, dynamic>;
          final double technical =
              (coreData['technical'] as num?)?.toDouble() ?? 0.0;
          final double mentality =
              (coreData['mentality'] as num?)?.toDouble() ?? 0.0;
          final double physical =
              (coreData['physical'] as num?)?.toDouble() ?? 0.0;
          final double psychological =
              (coreData['psychological'] as num?)?.toDouble() ?? 0.0;
          final double social = (coreData['social'] as num?)?.toDouble() ?? 0.0;

          areas = [
            DevelopmentAreaModel(
              icon: "⚽",
              name: "Technical",
              score: technical,
              progress: (technical / 10.0).clamp(0.0, 1.0),
            ),
            DevelopmentAreaModel(
              icon: "🧠",
              name: "Mentality",
              score: mentality,
              progress: (mentality / 10.0).clamp(0.0, 1.0),
            ),
            DevelopmentAreaModel(
              icon: "💪",
              name: "Physicality",
              score: physical,
              progress: (physical / 10.0).clamp(0.0, 1.0),
            ),
            DevelopmentAreaModel(
              icon: "🎯",
              name: "Psychological",
              score: psychological,
              progress: (psychological / 10.0).clamp(0.0, 1.0),
            ),
            DevelopmentAreaModel(
              icon: "🏆",
              name: "Social",
              score: social,
              progress: (social / 10.0).clamp(0.0, 1.0),
            ),
          ];
        }
      } catch (_) {}
    }

    Future<void> loadFootballSkills() async {
      try {
        final response =
            await ApiService.get(ApiEndPoint.footballSkills(playerId));
        if (response.statusCode == 200 && response.data['data'] != null) {
          final skillData = response.data['data'] as Map<String, dynamic>;
          final double shooting =
              (skillData['shooting'] as num?)?.toDouble() ?? 0.0;
          final double passing =
              (skillData['passing'] as num?)?.toDouble() ?? 0.0;
          final double dribbling =
              (skillData['dribbling'] as num?)?.toDouble() ?? 0.0;
          final double footballIQ =
              (skillData['footballIQ'] as num?)?.toDouble() ?? 0.0;
          final double speed = (skillData['speed'] as num?)?.toDouble() ?? 0.0;
          final double communication =
              (skillData['communication'] as num?)?.toDouble() ?? 0.0;

          String formatScore(double val) =>
              val % 1 == 0 ? val.toInt().toString() : val.toString();

          skills = [
            FootballSkillModel(
              name: "Shooting",
              stars: shooting.round(),
              score: formatScore(shooting),
            ),
            FootballSkillModel(
              name: "Passing",
              stars: passing.round(),
              score: formatScore(passing),
            ),
            FootballSkillModel(
              name: "Dribbling",
              stars: dribbling.round(),
              score: formatScore(dribbling),
            ),
            FootballSkillModel(
              name: "Football IQ",
              stars: footballIQ.round(),
              score: formatScore(footballIQ),
            ),
            FootballSkillModel(
              name: "Speed",
              stars: speed.round(),
              score: formatScore(speed),
            ),
            FootballSkillModel(
              name: "Communication",
              stars: communication.round(),
              score: formatScore(communication),
            ),
          ];
        }
      } catch (_) {}
    }

    Future<void> loadGrowthChart() async {
      try {
        final response = await ApiService.get(ApiEndPoint.growthChart(playerId));
        if (response.statusCode == 200 && response.data['data'] != null) {
          final rawList = response.data['data'] as List<dynamic>?;
          if (rawList != null && rawList.isNotEmpty) {
            final List<String> mList = [];
            final List<double> vList = [];
            for (final item in rawList) {
              if (item is Map<String, dynamic>) {
                final String month = item['month'] ?? '';
                final double score =
                    ((item['overallScore'] as num?) ?? 0).toDouble();
                mList.add(month);
                vList.add(score);
              }
            }
            if (mList.isNotEmpty && vList.isNotEmpty) {
              months = mList;
              values = vList;
            }
          }
        }
      } catch (_) {}
    }

    // Run all 4 assessment calls in parallel!
    await Future.wait([
      loadOverallScore(),
      loadCoreAreas(),
      loadFootballSkills(),
      loadGrowthChart(),
    ]);

    return DeploymentModel(
      overallScore: scoreVal,
      maxScore: maxScoreVal,
      improvement: improvement,
      status: status,
      developmentAreas: areas,
      footballSkills: skills,
      growthMonths: months,
      growthValues: values,
    );
  }

  @override
  Future<({List<PlayerTargetModel> targets, int totalPage})> fetchPlayerTargets({
    required String playerId,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await ApiService.get(
        ApiEndPoint.myTargets(playerId, page: page, limit: limit),
      );
      if (response.statusCode == 200 && response.data != null) {
        final rawList = response.data['data'] as List<dynamic>? ?? [];
        final targets = rawList
            .map((e) =>
                PlayerTargetModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
        final meta = response.data['meta'] as Map<String, dynamic>?;
        final totalPage = meta?['totalPage'] as int? ?? 1;
        return (targets: targets, totalPage: totalPage);
      }
    } catch (_) {}
    return (targets: <PlayerTargetModel>[], totalPage: 1);
  }

  @override
  Future<({List<SessionNoteModel> notes, int totalPage})> fetchSessionNotes({
    required String playerId,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await ApiService.get(
        ApiEndPoint.sessionNotes(playerId, page: page, limit: limit),
      );
      if (response.statusCode == 200 && response.data != null) {
        final rawList = response.data['data'] as List<dynamic>? ?? [];
        final notes = rawList
            .map((e) =>
                SessionNoteModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
        final meta = response.data['meta'] as Map<String, dynamic>?;
        final totalPage = meta?['totalPage'] as int? ?? 1;
        return (notes: notes, totalPage: totalPage);
      }
    } catch (_) {}
    return (notes: <SessionNoteModel>[], totalPage: 1);
  }

  @override
  Future<List<TimelineItemModel>> fetchDevelopmentTimeline({
    required String playerId,
  }) async {
    try {
      final response = await ApiService.get(
        ApiEndPoint.developmentTimeline(playerId),
      );
      if (response.statusCode == 200 && response.data != null) {
        final rawList = response.data['data'] as List<dynamic>? ?? [];
        return rawList
            .map((e) =>
                TimelineItemModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }
    } catch (_) {}
    return [];
  }

  @override
  Future<AchievementDataModel?> fetchPlayerAchievements({
    required String playerId,
  }) async {
    try {
      final response = await ApiService.get(
        ApiEndPoint.myAchievements(playerId),
      );
      if (response.statusCode == 200 && response.data != null) {
        final raw = response.data['data'];
        if (raw is Map<String, dynamic>) {
          return AchievementDataModel.fromJson(raw);
        }
      }
    } catch (_) {}
    return null;
  }
}
