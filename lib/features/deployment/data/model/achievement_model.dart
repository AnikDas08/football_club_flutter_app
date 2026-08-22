import 'package:football_club/features/deployment/domain/entity/achievement_entity.dart';

class AchievementGridModel extends AchievementGridItem {
  const AchievementGridModel({
    required super.title,
    required super.subtitle,
    required super.value,
    required super.hasEarned,
    super.icon,
  });

  factory AchievementGridModel.fromJson(Map<String, dynamic> json) {
    final titleStr = json['title'] ?? '';
    String iconStr = "🏆";
    if (titleStr.contains("Match")) {
      iconStr = "🏆";
    } else if (titleStr.contains("Week")) {
      iconStr = "⭐";
    } else if (titleStr.contains("Scorer")) {
      iconStr = "🥇";
    } else if (titleStr.contains("Improved")) {
      iconStr = "📈";
    } else if (titleStr.contains("Captain")) {
      iconStr = "🎖";
    } else if (titleStr.contains("Milestone")) {
      iconStr = "🎯";
    }

    return AchievementGridModel(
      title: titleStr,
      subtitle: json['subtitle'] ?? '',
      value: json['value'] ?? '',
      hasEarned: json['hasEarned'] ?? false,
      icon: iconStr,
    );
  }
}

class AchievementRecordModel extends AchievementRecordItem {
  const AchievementRecordModel({
    required super.id,
    required super.awardType,
    required super.matchEvent,
    required super.description,
    required super.date,
    required super.coachName,
    required super.formattedDate,
  });

  factory AchievementRecordModel.fromJson(Map<String, dynamic> json) {
    return AchievementRecordModel(
      id: json['_id'] ?? json['id'] ?? '',
      awardType: json['awardType'] ?? '',
      matchEvent: json['matchEvent'] ?? '',
      description: json['description'] ?? '',
      date: json['date'] ?? '',
      coachName: json['coachName'] ?? '',
      formattedDate: json['formattedDate'] ?? '',
    );
  }
}

class AchievementDataModel extends AchievementDataEntity {
  const AchievementDataModel({
    required super.totalCount,
    required super.grid,
    required super.achievements,
  });

  factory AchievementDataModel.fromJson(Map<String, dynamic> json) {
    final summary = json['summary'] as Map<String, dynamic>?;
    final total = summary?['total'] as int? ?? 0;

    final gridRaw = json['grid'] as List<dynamic>? ?? [];
    final gridList = gridRaw
        .map((e) => AchievementGridModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    final achievementsRaw = json['achievements'] as List<dynamic>? ?? [];
    final achievementsList = achievementsRaw
        .map((e) => AchievementRecordModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    return AchievementDataModel(
      totalCount: total,
      grid: gridList,
      achievements: achievementsList,
    );
  }
}
