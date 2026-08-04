import 'package:football_club/features/home/domain/entity/home_entity.dart';

abstract class HomeRepository {
  Future<HomeEntity?> getHomeDashboardData();
}
