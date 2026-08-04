import 'package:football_club/features/home/domain/entity/home_entity.dart';

class CoachFeedbackModel extends CoachFeedbackItem {
  const CoachFeedbackModel({
    required super.coachName,
    required super.date,
    required super.avatarPath,
    required super.feedback,
  });

  factory CoachFeedbackModel.fromJson(Map<String, dynamic> json) {
    return CoachFeedbackModel(
      coachName: json['coachName'] ?? '',
      date: json['date'] ?? '',
      avatarPath: json['avatarPath'] ?? 'assets/images/coach_image.png',
      feedback: json['feedback'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coachName': coachName,
      'date': date,
      'avatarPath': avatarPath,
      'feedback': feedback,
    };
  }
}

class HomeModel extends HomeEntity {
  const HomeModel({
    required super.sessionsCount,
    required super.goalsCount,
    required super.assistsCount,
    required super.potmCount,
    required super.playerName,
    required super.playerLevel,
    required super.playerSubtitle,
    required super.playerProgress,
    required super.playerImagePath,
    required super.trainingTitle,
    required super.daysLeftText,
    required super.trainingDateText,
    required super.trainingLocationText,
    required super.trainingCoachName,
    required super.trainingCoachAvatar,
    required super.goalCategoryTitle,
    required super.goalStatusText,
    required super.goalTitle,
    required super.goalDescription,
    required super.goalProgress,
    required super.goalDueDate,
    required super.feedbackTitle,
    required super.feedbackCoachName,
    required super.feedbackDate,
    required super.feedbackContent,
    required super.feedbackAvatarPath,
    required super.allCoachFeedbacks,
    required super.achievementCategory,
    required super.achievementTitle,
    required super.matchInfo,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    final rawFeedbacks = json['allCoachFeedbacks'] as List<dynamic>? ?? [];
    final feedbacks = rawFeedbacks
        .map((e) => CoachFeedbackModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    return HomeModel(
      sessionsCount: json['sessionsCount'] ?? 0,
      goalsCount: json['goalsCount'] ?? 0,
      assistsCount: json['assistsCount'] ?? 0,
      potmCount: json['potmCount'] ?? 0,
      playerName: json['playerName'] ?? '',
      playerLevel: json['playerLevel'] ?? '',
      playerSubtitle: json['playerSubtitle'] ?? '',
      playerProgress: (json['playerProgress'] as num?)?.toDouble() ?? 0.0,
      playerImagePath: json['playerImagePath'] ?? 'assets/images/profile_image.png',
      trainingTitle: json['trainingTitle'] ?? '',
      daysLeftText: json['daysLeftText'] ?? '',
      trainingDateText: json['trainingDateText'] ?? '',
      trainingLocationText: json['trainingLocationText'] ?? '',
      trainingCoachName: json['trainingCoachName'] ?? '',
      trainingCoachAvatar: json['trainingCoachAvatar'] ?? 'assets/images/coach_image.png',
      goalCategoryTitle: json['goalCategoryTitle'] ?? '',
      goalStatusText: json['goalStatusText'] ?? '',
      goalTitle: json['goalTitle'] ?? '',
      goalDescription: json['goalDescription'] ?? '',
      goalProgress: (json['goalProgress'] as num?)?.toDouble() ?? 0.0,
      goalDueDate: json['goalDueDate'] ?? '',
      feedbackTitle: json['feedbackTitle'] ?? '',
      feedbackCoachName: json['feedbackCoachName'] ?? '',
      feedbackDate: json['feedbackDate'] ?? '',
      feedbackContent: json['feedbackContent'] ?? '',
      feedbackAvatarPath: json['feedbackAvatarPath'] ?? 'assets/images/coach_image.png',
      allCoachFeedbacks: feedbacks,
      achievementCategory: json['achievementCategory'] ?? '',
      achievementTitle: json['achievementTitle'] ?? '',
      matchInfo: json['matchInfo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sessionsCount': sessionsCount,
      'goalsCount': goalsCount,
      'assistsCount': assistsCount,
      'potmCount': potmCount,
      'playerName': playerName,
      'playerLevel': playerLevel,
      'playerSubtitle': playerSubtitle,
      'playerProgress': playerProgress,
      'playerImagePath': playerImagePath,
      'trainingTitle': trainingTitle,
      'daysLeftText': daysLeftText,
      'trainingDateText': trainingDateText,
      'trainingLocationText': trainingLocationText,
      'trainingCoachName': trainingCoachName,
      'trainingCoachAvatar': trainingCoachAvatar,
      'goalCategoryTitle': goalCategoryTitle,
      'goalStatusText': goalStatusText,
      'goalTitle': goalTitle,
      'goalDescription': goalDescription,
      'goalProgress': goalProgress,
      'goalDueDate': goalDueDate,
      'feedbackTitle': feedbackTitle,
      'feedbackCoachName': feedbackCoachName,
      'feedbackDate': feedbackDate,
      'feedbackContent': feedbackContent,
      'feedbackAvatarPath': feedbackAvatarPath,
      'allCoachFeedbacks': allCoachFeedbacks
          .map((e) => (e as CoachFeedbackModel).toJson())
          .toList(),
      'achievementCategory': achievementCategory,
      'achievementTitle': achievementTitle,
      'matchInfo': matchInfo,
    };
  }
}
