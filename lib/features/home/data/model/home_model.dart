import 'package:football_club/features/home/domain/entity/home_entity.dart';

class HomeModel extends HomeEntity {
  const HomeModel({
    super.sessionsCount,
    super.goalsCount,
    super.assistsCount,
    super.potmCount,
    super.playerName,
    super.playerLevel,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      sessionsCount: json['sessionsCount'] ?? 42,
      goalsCount: json['goalsCount'] ?? 18,
      assistsCount: json['assistsCount'] ?? 11,
      potmCount: json['potmCount'] ?? 4,
      playerName: json['playerName'] ?? 'James Thornton',
      playerLevel: json['playerLevel'] ?? 'Advanced',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sessionsCount': sessionsCount,
      'goalsCount': goalsCount,
      'assistsCount': assistsCount,
      'potmCount': potmCount,
      'playerName': playerName,
      'playerLevel': playerLevel,
    };
  }
}
