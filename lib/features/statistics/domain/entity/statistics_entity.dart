class GoalMonthItem {
  final String month;
  final int value;

  const GoalMonthItem({
    required this.month,
    required this.value,
  });
}

class StatisticsEntity {
  final List<GoalMonthItem> goalsByMonth;
  final double attendanceRate;
  final String attendedPercentage;
  final String missedPercentage;
  final String latePercentage;
  final String playerImagePath;
  final int shotsCount;
  final int onTargetCount;
  final int chancesCreatedCount;

  const StatisticsEntity({
    required this.goalsByMonth,
    required this.attendanceRate,
    required this.attendedPercentage,
    required this.missedPercentage,
    required this.latePercentage,
    required this.playerImagePath,
    required this.shotsCount,
    required this.onTargetCount,
    required this.chancesCreatedCount,
  });
}
