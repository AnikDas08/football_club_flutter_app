import 'package:football_club/config/api/api_end_point.dart';
import 'package:football_club/features/deployment/data/model/achievement_model.dart';
import 'package:football_club/features/deployment/data/model/player_target_model.dart';
import 'package:football_club/features/home/data/model/home_dashboard_models.dart';
import 'package:football_club/features/home/data/model/session_note_model.dart';
import 'package:football_club/features/profile/data/model/profile_model.dart';
import 'package:football_club/services/api/api_service.dart';

abstract class HomeRemoteDataSource {
  Future<ProfileModel?> fetchUserProfile();
  Future<HomePlayerProfileModel?> fetchPlayerProfile(String playerId);
  Future<HomeOverallScoreModel?> fetchOverallScore(String playerId);
  Future<HomeDevelopmentStatsModel?> fetchDevelopmentStats(String playerId);
  Future<HomeUpcomingTrainingModel?> fetchUpcomingTraining(String playerId);
  Future<PlayerTargetModel?> fetchCurrentTarget(String playerId);
  Future<List<PlayerTargetModel>> fetchMyTargets({
    required String playerId,
    int page = 1,
    int limit = 1,
  });
  Future<SessionNoteModel?> fetchLatestFeedback(String playerId);
  Future<({List<SessionNoteModel> notes, int totalPage})> fetchSessionNotes({
    required String playerId,
    int page = 1,
    int limit = 10,
  });
  Future<AchievementRecordModel?> fetchLatestAchievement(String playerId);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<ProfileModel?> fetchUserProfile() async {
    try {
      final response = await ApiService.get(ApiEndPoint.userProfile);
      if (response.statusCode == 200 && response.data['data'] != null) {
        return ProfileModel.fromJson(response.data['data']);
      }
    } catch (_) {}
    return null;
  }

  @override
  Future<HomePlayerProfileModel?> fetchPlayerProfile(String playerId) async {
    try {
      final response =
          await ApiService.get(ApiEndPoint.playerProfile(playerId));
      if (response.statusCode == 200 && response.data['data'] != null) {
        return HomePlayerProfileModel.fromJson(response.data['data']);
      }
    } catch (_) {}
    return null;
  }

  @override
  Future<HomeOverallScoreModel?> fetchOverallScore(String playerId) async {
    try {
      final response =
          await ApiService.get(ApiEndPoint.overallScore(playerId));
      if (response.statusCode == 200 && response.data['data'] != null) {
        return HomeOverallScoreModel.fromJson(response.data['data']);
      }
    } catch (_) {}
    return null;
  }

  @override
  Future<HomeDevelopmentStatsModel?> fetchDevelopmentStats(
      String playerId) async {
    try {
      final response =
          await ApiService.get(ApiEndPoint.developmentStats(playerId));
      if (response.statusCode == 200 && response.data['data'] != null) {
        return HomeDevelopmentStatsModel.fromJson(response.data['data']);
      }
    } catch (_) {}
    return null;
  }

  @override
  Future<HomeUpcomingTrainingModel?> fetchUpcomingTraining(
      String playerId) async {
    try {
      final response =
          await ApiService.get(ApiEndPoint.upcomingTraining(playerId));
      if (response.statusCode == 200 && response.data['data'] != null) {
        return HomeUpcomingTrainingModel.fromJson(response.data['data']);
      }
    } catch (_) {}
    return null;
  }

  @override
  Future<PlayerTargetModel?> fetchCurrentTarget(String playerId) async {
    try {
      final response =
          await ApiService.get(ApiEndPoint.currentTarget(playerId));
      if (response.statusCode == 200 && response.data['data'] != null) {
        final d = response.data['data'];
        if (d is Map<String, dynamic> && d.isNotEmpty) {
          return PlayerTargetModel.fromJson(d);
        } else if (d is List && d.isNotEmpty) {
          return PlayerTargetModel.fromJson(d.first as Map<String, dynamic>);
        }
      }
    } catch (_) {}
    return null;
  }

  @override
  Future<List<PlayerTargetModel>> fetchMyTargets({
    required String playerId,
    int page = 1,
    int limit = 1,
  }) async {
    try {
      final response = await ApiService.get(
        ApiEndPoint.myTargets(playerId, page: page, limit: limit),
      );
      if (response.statusCode == 200 && response.data['data'] != null) {
        final d = response.data['data'];
        if (d is List) {
          return d
              .map((e) =>
                  PlayerTargetModel.fromJson(e as Map<String, dynamic>))
              .toList();
        } else if (d is Map<String, dynamic>) {
          return [PlayerTargetModel.fromJson(d)];
        }
      }
    } catch (_) {}
    return [];
  }

  @override
  Future<SessionNoteModel?> fetchLatestFeedback(String playerId) async {
    try {
      final response =
          await ApiService.get(ApiEndPoint.latestFeedback(playerId));
      if (response.statusCode == 200 && response.data['data'] != null) {
        final d = response.data['data'];
        if (d is Map<String, dynamic> && d.isNotEmpty) {
          return SessionNoteModel.fromJson(d);
        } else if (d is List && d.isNotEmpty) {
          return SessionNoteModel.fromJson(d.first as Map<String, dynamic>);
        }
      }
    } catch (_) {}
    return null;
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
  Future<AchievementRecordModel?> fetchLatestAchievement(
      String playerId) async {
    try {
      final response =
          await ApiService.get(ApiEndPoint.myAchievements(playerId));
      if (response.statusCode == 200 && response.data['data'] != null) {
        final dynamic rawData = response.data['data'];
        List<dynamic> achievementsList = [];
        if (rawData is Map<String, dynamic>) {
          if (rawData['achievements'] is List &&
              (rawData['achievements'] as List).isNotEmpty) {
            achievementsList = rawData['achievements'] as List;
          } else if (rawData['grid'] is List &&
              (rawData['grid'] as List).isNotEmpty) {
            achievementsList = rawData['grid'] as List;
          }
        } else if (rawData is List) {
          achievementsList = rawData;
        }

        if (achievementsList.isNotEmpty) {
          final first = achievementsList.first as Map<String, dynamic>;
          return AchievementRecordModel.fromJson(first);
        }
      }
    } catch (_) {}
    return null;
  }
}
