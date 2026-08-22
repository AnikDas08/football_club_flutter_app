class PlayerTargetEntity {
  final String id;
  final String title;
  final String description;
  final String successCriteria;
  final String coachName;
  final String coachImage;
  final String priority;
  final String category;
  final String dueDate;
  final String dueFormatted;
  final int progress;
  final String status;

  const PlayerTargetEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.successCriteria,
    required this.coachName,
    required this.coachImage,
    required this.priority,
    required this.category,
    required this.dueDate,
    required this.dueFormatted,
    required this.progress,
    required this.status,
  });
}
