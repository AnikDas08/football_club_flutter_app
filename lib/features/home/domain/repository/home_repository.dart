import 'package:football_club/features/home/domain/entity/home_entity.dart';
import 'package:football_club/features/home/domain/entity/session_note_entity.dart';

abstract class HomeRepository {
  Future<HomeEntity?> getHomeDashboardData();
  Future<({List<SessionNoteEntity> notes, int totalPage})> getSessionNotes({
    required String playerId,
    int page = 1,
    int limit = 10,
  });
}
