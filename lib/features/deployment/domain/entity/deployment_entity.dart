class DevelopmentAreaItem {
  final String icon;
  final String name;
  final double score;
  final double progress;

  const DevelopmentAreaItem({
    required this.icon,
    required this.name,
    required this.score,
    required this.progress,
  });
}

class FootballSkillItem {
  final String name;
  final int stars;
  final String score;

  const FootballSkillItem({
    required this.name,
    required this.stars,
    required this.score,
  });
}

class DeploymentEntity {
  final double overallScore;
  final double maxScore;
  final String improvement;
  final String status;
  final List<DevelopmentAreaItem> developmentAreas;
  final List<FootballSkillItem> footballSkills;
  final List<String> growthMonths;
  final List<double> growthValues;

  const DeploymentEntity({
    required this.overallScore,
    required this.maxScore,
    required this.improvement,
    required this.status,
    required this.developmentAreas,
    required this.footballSkills,
    required this.growthMonths,
    required this.growthValues,
  });
}
