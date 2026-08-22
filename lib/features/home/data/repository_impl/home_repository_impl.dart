import 'package:football_club/features/home/data/model/home_model.dart';
import 'package:football_club/features/home/data/model/session_note_model.dart';
import 'package:football_club/features/home/data/remote_data_source/home_remote_data_source.dart';
import 'package:football_club/features/home/domain/entity/home_entity.dart';
import 'package:football_club/features/home/domain/entity/session_note_entity.dart';
import 'package:football_club/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({HomeRemoteDataSource? remoteDataSource})
      : remoteDataSource = remoteDataSource ?? HomeRemoteDataSourceImpl();

  @override
  Future<HomeEntity?> getHomeDashboardData() async {
    final response = await remoteDataSource.fetchHomeData();
    if (response.statusCode == 200) {
      final data = response.data['data'] ?? {};
      return HomeModel.fromJson(data);
    }
    return null;
  }

  @override
  Future<({List<SessionNoteEntity> notes, int totalPage})> getSessionNotes({
    required String playerId,
    int page = 1,
    int limit = 10,
  }) async {
    final response = await remoteDataSource.fetchSessionNotes(
      playerId: playerId,
      page: page,
      limit: limit,
    );

    if (response.statusCode == 200 && response.data != null) {
      final rawList = response.data['data'] as List<dynamic>? ?? [];
      final notes = rawList
          .map((e) => SessionNoteModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();

      final meta = response.data['meta'] as Map<String, dynamic>?;
      final totalPage = meta?['totalPage'] as int? ?? 1;

      return (notes: notes, totalPage: totalPage);
    }
    return (notes: <SessionNoteEntity>[], totalPage: 1);
  }
}
