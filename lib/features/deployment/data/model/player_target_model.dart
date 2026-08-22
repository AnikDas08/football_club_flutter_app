import 'package:football_club/features/deployment/domain/entity/player_target_entity.dart';

class PlayerTargetModel extends PlayerTargetEntity {
  const PlayerTargetModel({
    required super.id,
    required super.title,
    required super.description,
    required super.successCriteria,
    required super.coachName,
    required super.coachImage,
    required super.priority,
    required super.category,
    required super.dueDate,
    required super.dueFormatted,
    required super.progress,
    required super.status,
  });

  factory PlayerTargetModel.fromJson(Map<String, dynamic> json) {
    return PlayerTargetModel(
      id: json['_id'] ?? json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      successCriteria: json['successCriteria'] ?? '',
      coachName: json['coachName'] ?? '',
      coachImage: json['coachImage'] ?? '',
      priority: json['priority'] ?? '',
      category: json['category'] ?? '',
      dueDate: json['dueDate'] ?? '',
      dueFormatted: json['dueFormatted'] ?? '',
      progress: (json['progress'] as num?)?.toInt() ?? 0,
      status: json['status'] ?? 'In Progress',
    );
  }
}
