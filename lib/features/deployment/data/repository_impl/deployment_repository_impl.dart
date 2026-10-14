import 'package:football_club/features/deployment/data/remote_data_source/deployment_remote_data_source.dart';
import 'package:football_club/features/deployment/domain/entity/achievement_entity.dart';
import 'package:football_club/features/deployment/domain/entity/deployment_entity.dart';
import 'package:football_club/features/deployment/domain/entity/player_target_entity.dart';
import 'package:football_club/features/deployment/domain/entity/timeline_item_entity.dart';
import 'package:football_club/features/deployment/domain/repository/deployment_repository.dart';
import 'package:football_club/features/home/domain/entity/session_note_entity.dart';
import 'package:football_club/services/storage/storage_services.dart';

class DeploymentRepositoryImpl implements DeploymentRepository {
  final DeploymentRemoteDataSource remoteDataSource;

  DeploymentRepositoryImpl({DeploymentRemoteDataSource? remoteDataSource})
      : remoteDataSource =
            remoteDataSource ?? DeploymentRemoteDataSourceImpl();

  @override
  Future<DeploymentEntity?> getDeploymentData() async {
    final playerId = LocalStorage.playerId.trim();
    if (playerId.isEmpty) return null;
    return await remoteDataSource.fetchDeploymentData(playerId: playerId);
  }

  @override
  Future<({List<PlayerTargetEntity> targets, int totalPage})> getPlayerTargets({
    required String playerId,
    int page = 1,
    int limit = 10,
  }) async {
    final result = await remoteDataSource.fetchPlayerTargets(
      playerId: playerId,
      page: page,
      limit: limit,
    );
    return (targets: result.targets, totalPage: result.totalPage);
  }

  @override
  Future<({List<SessionNoteEntity> notes, int totalPage})> getSessionNotes({
    required String playerId,
    int page = 1,
    int limit = 10,
  }) async {
    final result = await remoteDataSource.fetchSessionNotes(
      playerId: playerId,
      page: page,
      limit: limit,
    );
    return (notes: result.notes, totalPage: result.totalPage);
  }

  @override
  Future<List<TimelineItemEntity>> getDevelopmentTimeline({
    required String playerId,
  }) async {
    return await remoteDataSource.fetchDevelopmentTimeline(playerId: playerId);
  }

  @override
  Future<AchievementDataEntity?> getPlayerAchievements({
    required String playerId,
  }) async {
    return await remoteDataSource.fetchPlayerAchievements(playerId: playerId);
  }
}
