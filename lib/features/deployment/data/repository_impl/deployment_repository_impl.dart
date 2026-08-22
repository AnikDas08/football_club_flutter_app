import 'package:football_club/features/deployment/data/model/achievement_model.dart';
import 'package:football_club/features/deployment/data/model/deployment_model.dart';
import 'package:football_club/features/deployment/data/model/player_target_model.dart';
import 'package:football_club/features/deployment/data/model/timeline_item_model.dart';
import 'package:football_club/features/deployment/data/remote_data_source/deployment_remote_data_source.dart';
import 'package:football_club/features/deployment/domain/entity/achievement_entity.dart';
import 'package:football_club/features/deployment/domain/entity/deployment_entity.dart';
import 'package:football_club/features/deployment/domain/entity/player_target_entity.dart';
import 'package:football_club/features/deployment/domain/entity/timeline_item_entity.dart';
import 'package:football_club/features/deployment/domain/repository/deployment_repository.dart';
import 'package:football_club/features/home/data/model/session_note_model.dart';
import 'package:football_club/features/home/domain/entity/session_note_entity.dart';

class DeploymentRepositoryImpl implements DeploymentRepository {
  final DeploymentRemoteDataSource remoteDataSource;

  DeploymentRepositoryImpl({DeploymentRemoteDataSource? remoteDataSource})
      : remoteDataSource =
            remoteDataSource ?? DeploymentRemoteDataSourceImpl();

  @override
  Future<DeploymentEntity?> getDeploymentData() async {
    final response = await remoteDataSource.fetchDeploymentData();
    if (response.statusCode == 200) {
      final data = response.data['data'] ?? {};
      return DeploymentModel.fromJson(data);
    }
    return null;
  }

  @override
  Future<({List<PlayerTargetEntity> targets, int totalPage})> getPlayerTargets({
    required String playerId,
    int page = 1,
    int limit = 10,
  }) async {
    final response = await remoteDataSource.fetchPlayerTargets(
      playerId: playerId,
      page: page,
      limit: limit,
    );

    if (response.statusCode == 200 && response.data != null) {
      final rawList = response.data['data'] as List<dynamic>? ?? [];
      final targets = rawList
          .map((e) => PlayerTargetModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();

      final meta = response.data['meta'] as Map<String, dynamic>?;
      final totalPage = meta?['totalPage'] as int? ?? 1;

      return (targets: targets, totalPage: totalPage);
    }
    return (targets: <PlayerTargetEntity>[], totalPage: 1);
  }

  @override
  Future<({List<SessionNoteEntity> notes, int totalPage})> getSessionNotes({
    required String playerId,
    int page = 1,
    int limit = 10,
  }) async {
    final response = await remoteDataSource.fetchSessionNotes(
      playerId: playerId,
      page: page,
      limit: limit,
    );

    if (response.statusCode == 200 && response.data != null) {
      final rawList = response.data['data'] as List<dynamic>? ?? [];
      final notes = rawList
          .map((e) => SessionNoteModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();

      final meta = response.data['meta'] as Map<String, dynamic>?;
      final totalPage = meta?['totalPage'] as int? ?? 1;

      return (notes: notes, totalPage: totalPage);
    }
    return (notes: <SessionNoteEntity>[], totalPage: 1);
  }

  @override
  Future<List<TimelineItemEntity>> getDevelopmentTimeline({
    required String playerId,
  }) async {
    final response = await remoteDataSource.fetchDevelopmentTimeline(
      playerId: playerId,
    );

    if (response.statusCode == 200 && response.data != null) {
      final rawList = response.data['data'] as List<dynamic>? ?? [];
      return rawList
          .map((e) => TimelineItemModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }
    return <TimelineItemEntity>[];
  }

  @override
  Future<AchievementDataEntity?> getPlayerAchievements({
    required String playerId,
  }) async {
    final response = await remoteDataSource.fetchPlayerAchievements(
      playerId: playerId,
    );

    if (response.statusCode == 200 && response.data != null) {
      final data = response.data['data'] as Map<String, dynamic>?;
      if (data != null) {
        return AchievementDataModel.fromJson(data);
      }
    }
    return null;
  }
}
