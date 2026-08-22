import 'package:football_club/features/deployment/domain/entity/timeline_item_entity.dart';

class TimelineItemModel extends TimelineItemEntity {
  const TimelineItemModel({
    required super.title,
    required super.description,
    required super.date,
    required super.type,
  });

  factory TimelineItemModel.fromJson(Map<String, dynamic> json) {
    return TimelineItemModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      date: json['date'] ?? '',
      type: json['type'] ?? '',
    );
  }
}
