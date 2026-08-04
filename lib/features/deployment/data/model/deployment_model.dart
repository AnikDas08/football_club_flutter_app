import 'package:football_club/features/deployment/domain/entity/deployment_entity.dart';

class DevelopmentAreaModel extends DevelopmentAreaItem {
  const DevelopmentAreaModel({
    required super.icon,
    required super.name,
    required super.score,
    required super.progress,
  });

  factory DevelopmentAreaModel.fromJson(Map<String, dynamic> json) {
    return DevelopmentAreaModel(
      icon: json['icon'] ?? '',
      name: json['name'] ?? '',
      score: (json['score'] as num?)?.toDouble() ?? 0.0,
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'icon': icon,
      'name': name,
      'score': score,
      'progress': progress,
    };
  }
}

class FootballSkillModel extends FootballSkillItem {
  const FootballSkillModel({
    required super.name,
    required super.stars,
    required super.score,
  });

  factory FootballSkillModel.fromJson(Map<String, dynamic> json) {
    return FootballSkillModel(
      name: json['name'] ?? '',
      stars: json['stars'] ?? 0,
      score: json['score']?.toString() ?? '0',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'stars': stars,
      'score': score,
    };
  }
}

class DeploymentModel extends DeploymentEntity {
  const DeploymentModel({
    required super.overallScore,
    required super.maxScore,
    required super.improvement,
    required super.status,
    required super.developmentAreas,
    required super.footballSkills,
    required super.growthMonths,
    required super.growthValues,
  });

  factory DeploymentModel.fromJson(Map<String, dynamic> json) {
    final rawAreas = json['developmentAreas'] as List<dynamic>? ?? [];
    final areas = rawAreas
        .map((e) => DevelopmentAreaModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    final rawSkills = json['footballSkills'] as List<dynamic>? ?? [];
    final skills = rawSkills
        .map((e) => FootballSkillModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    final rawMonths = json['growthMonths'] as List<dynamic>? ?? [];
    final months = rawMonths.map((e) => e.toString()).toList();

    final rawValues = json['growthValues'] as List<dynamic>? ?? [];
    final values = rawValues.map((e) => (e as num).toDouble()).toList();

    return DeploymentModel(
      overallScore: (json['overallScore'] as num?)?.toDouble() ?? 8.2,
      maxScore: (json['maxScore'] as num?)?.toDouble() ?? 10.0,
      improvement: json['improvement'] ?? '+6.1%',
      status: json['status'] ?? 'Excellent',
      developmentAreas: areas,
      footballSkills: skills,
      growthMonths: months,
      growthValues: values,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'overallScore': overallScore,
      'maxScore': maxScore,
      'improvement': improvement,
      'status': status,
      'developmentAreas': developmentAreas
          .map((e) => (e as DevelopmentAreaModel).toJson())
          .toList(),
      'footballSkills': footballSkills
          .map((e) => (e as FootballSkillModel).toJson())
          .toList(),
      'growthMonths': growthMonths,
      'growthValues': growthValues,
    };
  }
}
