import 'package:football_club/features/statistics/domain/entity/statistics_entity.dart';

class GoalMonthModel extends GoalMonthItem {
  const GoalMonthModel({
    required super.month,
    required super.value,
  });

  factory GoalMonthModel.fromJson(Map<String, dynamic> json) {
    return GoalMonthModel(
      month: json['month'] ?? '',
      value: (json['goals'] as num?)?.toInt() ??
          (json['value'] as num?)?.toInt() ??
          0,
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

    final attendanceMap = json['attendanceAnalytics'] as Map<String, dynamic>?;
    final String attended = attendanceMap?['attended'] ??
        json['attendedPercentage'] ??
        '87%';
    final String missed =
        attendanceMap?['missed'] ?? json['missedPercentage'] ?? '8%';
    final String late =
        attendanceMap?['late'] ?? json['latePercentage'] ?? '5%';

    double rate = 0.87;
    final rawRate =
        attendanceMap?['attendanceRate'] ?? json['attendanceRate'];
    if (rawRate is num) {
      rate = rawRate > 1 ? rawRate.toDouble() / 100.0 : rawRate.toDouble();
    } else if (rawRate is String) {
      final clean = rawRate.replaceAll('%', '').trim();
      final parsed = double.tryParse(clean) ?? 87.0;
      rate = parsed > 1 ? parsed / 100.0 : parsed;
    }

    final matchMap = json['matchInvolvement'] as Map<String, dynamic>?;
    final int shots = (matchMap?['shots'] as num?)?.toInt() ??
        (json['shotsCount'] as num?)?.toInt() ??
        72;
    final int onTarget = (matchMap?['onTarget'] as num?)?.toInt() ??
        (json['onTargetCount'] as num?)?.toInt() ??
        41;
    final int chances = (matchMap?['chances'] as num?)?.toInt() ??
        (json['chancesCreatedCount'] as num?)?.toInt() ??
        28;

    return StatisticsModel(
      goalsByMonth: goals,
      attendanceRate: rate,
      attendedPercentage: attended,
      missedPercentage: missed,
      latePercentage: late,
      playerImagePath:
          json['playerImagePath'] ?? 'assets/images/player_image.png',
      shotsCount: shots,
      onTargetCount: onTarget,
      chancesCreatedCount: chances,
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
