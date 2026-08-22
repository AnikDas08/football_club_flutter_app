class AchievementGridItem {
  final String title;
  final String subtitle;
  final String value;
  final bool hasEarned;
  final String icon;

  const AchievementGridItem({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.hasEarned,
    this.icon = "🏆",
  });
}

class AchievementRecordItem {
  final String id;
  final String awardType;
  final String matchEvent;
  final String description;
  final String date;
  final String coachName;
  final String formattedDate;

  const AchievementRecordItem({
    required this.id,
    required this.awardType,
    required this.matchEvent,
    required this.description,
    required this.date,
    required this.coachName,
    required this.formattedDate,
  });
}

class AchievementDataEntity {
  final int totalCount;
  final List<AchievementGridItem> grid;
  final List<AchievementRecordItem> achievements;

  const AchievementDataEntity({
    required this.totalCount,
    required this.grid,
    required this.achievements,
  });
}
