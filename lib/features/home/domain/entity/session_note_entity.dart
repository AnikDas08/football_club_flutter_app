class SessionNoteEntity {
  final String id;
  final String category;
  final String note;
  final String coachName;
  final String coachImage;
  final String createdAt;

  const SessionNoteEntity({
    required this.id,
    required this.category,
    required this.note,
    required this.coachName,
    required this.coachImage,
    required this.createdAt,
  });
}
