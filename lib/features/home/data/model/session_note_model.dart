import 'package:football_club/config/api/api_end_point.dart';
import 'package:football_club/features/home/domain/entity/session_note_entity.dart';

class SessionNoteModel extends SessionNoteEntity {
  const SessionNoteModel({
    required super.id,
    required super.category,
    required super.note,
    required super.coachName,
    required super.coachImage,
    required super.createdAt,
  });

  factory SessionNoteModel.fromJson(Map<String, dynamic> json) {
    final rawImg = (json['coachImage'] ?? json['coachAvatar'] ?? '').toString();

    return SessionNoteModel(
      id: json['_id'] ?? json['id'] ?? '',
      category: json['category'] ?? '',
      note: json['note'] ?? '',
      coachName: json['coachName'] ?? '',
      coachImage: ApiEndPoint.getFullImageUrl(rawImg),
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'note': note,
      'coachName': coachName,
      'coachImage': coachImage,
      'createdAt': createdAt,
    };
  }
}
