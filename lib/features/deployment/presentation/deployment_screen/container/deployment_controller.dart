import 'package:football_club/features/deployment/data/repository_impl/deployment_repository_impl.dart';
import 'package:football_club/features/deployment/domain/entity/achievement_entity.dart';
import 'package:football_club/features/deployment/domain/entity/deployment_entity.dart';
import 'package:football_club/features/deployment/domain/entity/player_target_entity.dart';
import 'package:football_club/features/deployment/domain/entity/timeline_item_entity.dart';
import 'package:football_club/features/deployment/domain/repository/deployment_repository.dart';
import 'package:football_club/features/home/domain/entity/session_note_entity.dart';
import 'package:football_club/services/storage/storage_services.dart';
import 'package:football_club/utils/helpers/banner_helper.dart';
import 'package:get/get.dart';

class DeploymentController extends GetxController {
  final DeploymentRepository deploymentRepository;

  DeploymentController({DeploymentRepository? deploymentRepository})
      : deploymentRepository =
            deploymentRepository ?? DeploymentRepositoryImpl();

  var isLoading = false.obs;
  final deploymentEntity = Rxn<DeploymentEntity>();

  var isTargetsLoading = false.obs;
  var targetsList = <PlayerTargetEntity>[].obs;

  var isNotesLoading = false.obs;
  var notesList = <SessionNoteEntity>[].obs;

  var isTimelineLoading = false.obs;
  var timelineList = <TimelineItemEntity>[].obs;

  var isAchievementsLoading = false.obs;
  final achievementData = Rxn<AchievementDataEntity>();
  var bannerUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDeploymentData();
    fetchPlayerTargets();
    fetchSessionNotes();
    fetchDevelopmentTimeline();
    fetchPlayerAchievements();
    fetchDevelopmentBanner();
  }

  Future<void> fetchDevelopmentBanner() async {
    try {
      final url = await BannerHelper.fetchBanner('development');
      if (url != null && url.isNotEmpty) {
        bannerUrl.value = url;
      }
    } catch (_) {}
  }

  Future<void> fetchDeploymentData() async {
    try {
      isLoading.value = true;
      final data = await deploymentRepository.getDeploymentData();
      if (data != null) {
        deploymentEntity.value = data;
      }
    } catch (e) {
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchPlayerTargets() async {
    try {
      isTargetsLoading.value = true;
      final playerId = LocalStorage.playerId.isNotEmpty
          ? LocalStorage.playerId
          : '435464';

      final result = await deploymentRepository.getPlayerTargets(
        playerId: playerId,
        page: 1,
        limit: 10,
      );

      targetsList.assignAll(result.targets);
    } catch (_) {
      // Handle error
    } finally {
      isTargetsLoading.value = false;
    }
  }

  Future<void> fetchSessionNotes() async {
    try {
      isNotesLoading.value = true;
      final playerId = LocalStorage.playerId.isNotEmpty
          ? LocalStorage.playerId
          : '904854';

      final result = await deploymentRepository.getSessionNotes(
        playerId: playerId,
        page: 1,
        limit: 10,
      );

      notesList.assignAll(result.notes);
    } catch (_) {
      // Handle error
    } finally {
      isNotesLoading.value = false;
    }
  }

  Future<void> fetchDevelopmentTimeline() async {
    try {
      isTimelineLoading.value = true;
      final playerId = LocalStorage.playerId.isNotEmpty
          ? LocalStorage.playerId
          : '345454';

      final list = await deploymentRepository.getDevelopmentTimeline(
        playerId: playerId,
      );

      timelineList.assignAll(list);
    } catch (_) {
      // Handle error
    } finally {
      isTimelineLoading.value = false;
    }
  }

  Future<void> fetchPlayerAchievements() async {
    try {
      isAchievementsLoading.value = true;
      final playerId = LocalStorage.playerId.isNotEmpty
          ? LocalStorage.playerId
          : '89345435';

      final data = await deploymentRepository.getPlayerAchievements(
        playerId: playerId,
      );

      if (data != null) {
        achievementData.value = data;
      }
    } catch (_) {
      // Handle error
    } finally {
      isAchievementsLoading.value = false;
    }
  }
}
