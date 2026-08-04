import 'package:football_club/features/statistics/domain/entity/statistics_entity.dart';

class GoalMonthModel extends GoalMonthItem {
  const GoalMonthModel({
    required super.month,
    required super.value,
  });

  factory GoalMonthModel.fromJson(Map<String, dynamic> json) {
    return GoalMonthModel(
      month: json['month'] ?? '',
      value: json['value'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'value': value,
    };
  }
}

class StatisticsModel extends StatisticsEntity {
  const StatisticsModel({
    required super.goalsByMonth,
    required super.attendanceRate,
    required super.attendedPercentage,
    required super.missedPercentage,
    required super.latePercentage,
    required super.playerImagePath,
    required super.shotsCount,
    required super.onTargetCount,
    required super.chancesCreatedCount,
  });

  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    final rawGoals = json['goalsByMonth'] as List<dynamic>? ?? [];
    final goals = rawGoals
        .map((e) => GoalMonthModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    return StatisticsModel(
      goalsByMonth: goals,
      attendanceRate: (json['attendanceRate'] as num?)?.toDouble() ?? 0.87,
      attendedPercentage: json['attendedPercentage'] ?? '87%',
      missedPercentage: json['missedPercentage'] ?? '8%',
      latePercentage: json['latePercentage'] ?? '5%',
      playerImagePath: json['playerImagePath'] ?? 'assets/images/player_image.png',
      shotsCount: json['shotsCount'] ?? 72,
      onTargetCount: json['onTargetCount'] ?? 41,
      chancesCreatedCount: json['chancesCreatedCount'] ?? 28,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'goalsByMonth':
          goalsByMonth.map((e) => (e as GoalMonthModel).toJson()).toList(),
      'attendanceRate': attendanceRate,
      'attendedPercentage': attendedPercentage,
      'missedPercentage': missedPercentage,
      'latePercentage': latePercentage,
      'playerImagePath': playerImagePath,
      'shotsCount': shotsCount,
      'onTargetCount': onTargetCount,
      'chancesCreatedCount': chancesCreatedCount,
    };
  }
}
