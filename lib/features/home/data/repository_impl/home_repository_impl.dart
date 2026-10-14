import 'package:football_club/features/deployment/data/model/achievement_model.dart';
import 'package:football_club/features/deployment/data/model/player_target_model.dart';
import 'package:football_club/features/home/data/model/home_dashboard_models.dart';
import 'package:football_club/features/home/data/model/session_note_model.dart';
import 'package:football_club/features/home/data/remote_data_source/home_remote_data_source.dart';
import 'package:football_club/features/home/domain/entity/home_entity.dart';
import 'package:football_club/features/home/domain/entity/session_note_entity.dart';
import 'package:football_club/features/home/domain/repository/home_repository.dart';
import 'package:football_club/features/profile/data/model/profile_model.dart';
import 'package:football_club/services/storage/storage_keys.dart';
import 'package:football_club/services/storage/storage_services.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({HomeRemoteDataSource? remoteDataSource})
      : remoteDataSource = remoteDataSource ?? HomeRemoteDataSourceImpl();

  String _formatFeedbackDate(String rawDate) {
    if (rawDate.isEmpty) return '';
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final dt = DateTime.tryParse(rawDate);
    if (dt != null && dt.month >= 1 && dt.month <= 12) {
      return '${dt.day} ${months[dt.month - 1]}';
    }
    return rawDate;
  }

  @override
  Future<HomeEntity?> getHomeDashboardData() async {
    String playerId = LocalStorage.playerId.trim();

    ProfileModel? userProfile;
    HomePlayerProfileModel? playerProfile;
    HomeOverallScoreModel? overallScore;
    HomeDevelopmentStatsModel? devStats;
    HomeUpcomingTrainingModel? training;
    PlayerTargetModel? target;
    SessionNoteModel? feedback;
    List<SessionNoteModel> sessionNotesList = [];
    AchievementRecordModel? achievement;

    Future<void> loadUserProfile() async {
      userProfile = await remoteDataSource.fetchUserProfile();
      if (userProfile != null && LocalStorage.playerId.isNotEmpty) {
        playerId = LocalStorage.playerId.trim();
      }
    }

    Future<void> loadTarget(String pid) async {
      target = await remoteDataSource.fetchCurrentTarget(pid);
      if (target == null) {
        final targets = await remoteDataSource.fetchMyTargets(
          playerId: pid,
          page: 1,
          limit: 1,
        );
        if (targets.isNotEmpty) {
          target = targets.first;
        }
      }
    }

    Future<void> loadFeedback(String pid) async {
      feedback = await remoteDataSource.fetchLatestFeedback(pid);
      if (feedback == null) {
        final notesResult = await remoteDataSource.fetchSessionNotes(
          playerId: pid,
          page: 1,
          limit: 10,
        );
        sessionNotesList = notesResult.notes;
        if (sessionNotesList.isNotEmpty) {
          feedback = sessionNotesList.first;
        }
      }
    }

    // Parallel loading of typed models
    if (playerId.isEmpty) {
      await loadUserProfile();
      if (playerId.isNotEmpty) {
        await Future.wait([
          remoteDataSource.fetchPlayerProfile(playerId).then((v) => playerProfile = v),
          remoteDataSource.fetchOverallScore(playerId).then((v) => overallScore = v),
          remoteDataSource.fetchDevelopmentStats(playerId).then((v) => devStats = v),
          remoteDataSource.fetchUpcomingTraining(playerId).then((v) => training = v),
          loadTarget(playerId),
          loadFeedback(playerId),
          remoteDataSource.fetchLatestAchievement(playerId).then((v) => achievement = v),
        ]);
      }
    } else {
      await Future.wait([
        loadUserProfile(),
        remoteDataSource.fetchPlayerProfile(playerId).then((v) => playerProfile = v),
        remoteDataSource.fetchOverallScore(playerId).then((v) => overallScore = v),
        remoteDataSource.fetchDevelopmentStats(playerId).then((v) => devStats = v),
        remoteDataSource.fetchUpcomingTraining(playerId).then((v) => training = v),
        loadTarget(playerId),
        loadFeedback(playerId),
        remoteDataSource.fetchLatestAchievement(playerId).then((v) => achievement = v),
      ]);
    }

    // Resolving precedence via typed properties
    final String resolvedName = (playerProfile?.name.trim().isNotEmpty == true)
        ? playerProfile!.name
        : (userProfile?.playerName.trim().isNotEmpty == true)
            ? userProfile!.playerName
            : (LocalStorage.myName.isNotEmpty ? LocalStorage.myName : 'Player');

    final String resolvedImage = (playerProfile?.image.trim().isNotEmpty == true)
        ? playerProfile!.image
        : (userProfile?.profileImagePath.trim().isNotEmpty == true)
            ? userProfile!.profileImagePath
            : LocalStorage.myImage;

    if (resolvedImage.isNotEmpty) {
      LocalStorage.myImage = resolvedImage;
      await LocalStorage.setString(LocalStorageKeys.myImage, resolvedImage);
    }

    final String resolvedLevel = (playerProfile?.levelBadge.isNotEmpty == true)
        ? playerProfile!.levelBadge
        : (overallScore?.performanceBadge.isNotEmpty == true)
            ? overallScore!.performanceBadge
            : '';

    final double resolvedProgress =
        (playerProfile?.progress != null && playerProfile!.progress > 0)
            ? playerProfile!.progress
            : (overallScore?.progress ?? 0.0);

    final String matchInfoText = [
      if (achievement?.matchEvent.isNotEmpty == true) achievement!.matchEvent,
      if (achievement?.formattedDate.isNotEmpty == true) achievement!.formattedDate,
    ].join(' · ');

    final List<CoachFeedbackItem> allFeedbacks = sessionNotesList.map((note) {
      return CoachFeedbackItem(
        coachName: note.coachName,
        date: _formatFeedbackDate(note.createdAt),
        avatarPath: note.coachImage,
        feedback: note.note,
      );
    }).toList();

    return HomeEntity(
      sessionsCount: devStats?.sessions ?? 0,
      goalsCount: devStats?.goals ?? 0,
      assistsCount: devStats?.assists ?? 0,
      potmCount: devStats?.potm ?? 0,
      playerName: resolvedName,
      playerLevel: resolvedLevel,
      playerSubtitle: playerProfile?.subtitle ?? '',
      playerProgress: resolvedProgress,
      playerImagePath: resolvedImage,
      trainingTitle: training?.title ?? '',
      daysLeftText: training?.daysRemainingText ?? '',
      trainingDateText: training?.formattedDateTime ?? '',
      trainingLocationText: training?.venue ?? '',
      trainingCoachName: training?.coachName ?? '',
      trainingCoachAvatar: training?.coachAvatar ?? '',
      goalCategoryTitle: target != null ? 'Current Target' : '',
      goalStatusText: target?.status ?? '',
      goalTitle: target?.title ?? '',
      goalDescription: target?.description ?? '',
      goalProgress: target != null
          ? (target!.progress > 1
              ? target!.progress / 100.0
              : target!.progress.toDouble())
          : 0.0,
      goalDueDate: target?.dueFormatted.isNotEmpty == true
          ? target!.dueFormatted
          : (target?.dueDate ?? ''),
      feedbackTitle: feedback != null ? 'Latest Coach Feedback' : '',
      feedbackCoachName: feedback?.coachName ?? '',
      feedbackDate:
          feedback != null ? _formatFeedbackDate(feedback!.createdAt) : '',
      feedbackContent: feedback?.note ?? '',
      feedbackAvatarPath: feedback?.coachImage ?? '',
      allCoachFeedbacks: allFeedbacks,
      achievementCategory: achievement != null ? 'RECENT ACHIEVEMENT' : '',
      achievementTitle: achievement?.awardType ?? '',
      matchInfo: matchInfoText,
    );
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
}
