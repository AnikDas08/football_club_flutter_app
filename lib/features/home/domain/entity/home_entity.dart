class CoachFeedbackItem {
  final String coachName;
  final String date;
  final String avatarPath;
  final String feedback;

  const CoachFeedbackItem({
    required this.coachName,
    required this.date,
    required this.avatarPath,
    required this.feedback,
  });
}

class HomeEntity {
  final int sessionsCount;
  final int goalsCount;
  final int assistsCount;
  final int potmCount;

  // Player Progress
  final String playerName;
  final String playerLevel;
  final String playerSubtitle;
  final double playerProgress;
  final String playerImagePath;

  // Upcoming Training
  final String trainingTitle;
  final String daysLeftText;
  final String trainingDateText;
  final String trainingLocationText;
  final String trainingCoachName;
  final String trainingCoachAvatar;

  // Target Goal
  final String goalCategoryTitle;
  final String goalStatusText;
  final String goalTitle;
  final String goalDescription;
  final double goalProgress;
  final String goalDueDate;

  // Latest Coach Feedback
  final String feedbackTitle;
  final String feedbackCoachName;
  final String feedbackDate;
  final String feedbackContent;
  final String feedbackAvatarPath;

  // All Coach Feedbacks List
  final List<CoachFeedbackItem> allCoachFeedbacks;

  // Recent Achievement
  final String achievementCategory;
  final String achievementTitle;
  final String matchInfo;

  const HomeEntity({
    required this.sessionsCount,
    required this.goalsCount,
    required this.assistsCount,
    required this.potmCount,
    required this.playerName,
    required this.playerLevel,
    required this.playerSubtitle,
    required this.playerProgress,
    required this.playerImagePath,
    required this.trainingTitle,
    required this.daysLeftText,
    required this.trainingDateText,
    required this.trainingLocationText,
    required this.trainingCoachName,
    required this.trainingCoachAvatar,
    required this.goalCategoryTitle,
    required this.goalStatusText,
    required this.goalTitle,
    required this.goalDescription,
    required this.goalProgress,
    required this.goalDueDate,
    required this.feedbackTitle,
    required this.feedbackCoachName,
    required this.feedbackDate,
    required this.feedbackContent,
    required this.feedbackAvatarPath,
    required this.allCoachFeedbacks,
    required this.achievementCategory,
    required this.achievementTitle,
    required this.matchInfo,
  });
}
