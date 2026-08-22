import 'package:football_club/features/deployment/domain/entity/achievement_entity.dart';
import 'package:football_club/features/deployment/domain/entity/deployment_entity.dart';
import 'package:football_club/features/deployment/domain/entity/player_target_entity.dart';
import 'package:football_club/features/deployment/domain/entity/timeline_item_entity.dart';
import 'package:football_club/features/home/domain/entity/session_note_entity.dart';

abstract class DeploymentRepository {
  Future<DeploymentEntity?> getDeploymentData();
  Future<({List<PlayerTargetEntity> targets, int totalPage})> getPlayerTargets({
    required String playerId,
    int page = 1,
    int limit = 10,
  });
  Future<({List<SessionNoteEntity> notes, int totalPage})> getSessionNotes({
    required String playerId,
    int page = 1,
    int limit = 10,
  });
  Future<List<TimelineItemEntity>> getDevelopmentTimeline({
    required String playerId,
  });
  Future<AchievementDataEntity?> getPlayerAchievements({
    required String playerId,
  });
}
