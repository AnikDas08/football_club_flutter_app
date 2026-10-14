import 'package:football_club/config/api/api_end_point.dart';

class HomePlayerProfileModel {
  final String name;
  final String image;
  final String levelBadge;
  final String ageGroupStr;
  final String squadName;
  final String playingPosition;
  final double progress;

  const HomePlayerProfileModel({
    this.name = '',
    this.image = '',
    this.levelBadge = '',
    this.ageGroupStr = '',
    this.squadName = '',
    this.playingPosition = '',
    this.progress = 0.0,
  });

  String get subtitle {
    String headerText = '';
    if (ageGroupStr.isNotEmpty && squadName.isNotEmpty) {
      if (squadName.toLowerCase().startsWith(ageGroupStr.toLowerCase())) {
        headerText = squadName;
      } else {
        headerText = '$ageGroupStr $squadName';
      }
    } else if (ageGroupStr.isNotEmpty) {
      headerText = ageGroupStr;
    } else if (squadName.isNotEmpty) {
      headerText = squadName;
    }

    if (playingPosition.isNotEmpty) {
      return headerText.isNotEmpty ? '$headerText · $playingPosition' : playingPosition;
    }
    return headerText;
  }

  factory HomePlayerProfileModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const HomePlayerProfileModel();
    final attendanceRate = (json['attendanceRate'] ?? '').toString();
    final cleanRate = attendanceRate.replaceAll('%', '').trim();
    final progressVal = cleanRate.isNotEmpty
        ? ((double.tryParse(cleanRate) ?? 0.0) / 100.0)
        : 0.0;

    return HomePlayerProfileModel(
      name: json['name'] ?? '',
      image: ApiEndPoint.getFullImageUrl(json['image']),
      levelBadge: json['levelBadge'] ?? '',
      ageGroupStr: (json['ageGroupStr'] ?? '').toString().trim(),
      squadName: (json['squadName'] ?? '').toString().trim(),
      playingPosition: (json['playingPosition'] ?? '').toString().trim(),
      progress: progressVal,
    );
  }
}

class HomeOverallScoreModel {
  final double? overallScore;
  final String performanceBadge;

  const HomeOverallScoreModel({
    this.overallScore,
    this.performanceBadge = '',
  });

  double? get progress =>
      overallScore != null ? (overallScore! / 10.0).clamp(0.0, 1.0) : null;

  factory HomeOverallScoreModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const HomeOverallScoreModel();
    final score = (json['overallScore'] as num?)?.toDouble();
    return HomeOverallScoreModel(
      overallScore: score,
      performanceBadge: (json['performanceBadge'] ?? '').toString(),
    );
  }
}

class HomeDevelopmentStatsModel {
  final int sessions;
  final int goals;
  final int assists;
  final int potm;

  const HomeDevelopmentStatsModel({
    this.sessions = 0,
    this.goals = 0,
    this.assists = 0,
    this.potm = 0,
  });

  factory HomeDevelopmentStatsModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const HomeDevelopmentStatsModel();
    return HomeDevelopmentStatsModel(
      sessions: (json['sessions'] as num?)?.toInt() ?? 0,
      goals: (json['goals'] as num?)?.toInt() ?? 0,
      assists: (json['assists'] as num?)?.toInt() ?? 0,
      potm: (json['potm'] as num?)?.toInt() ?? 0,
    );
  }
}

class HomeUpcomingTrainingModel {
  final String title;
  final String daysRemainingText;
  final String formattedDateTime;
  final String venue;
  final String coachName;
  final String coachAvatar;

  const HomeUpcomingTrainingModel({
    this.title = 'Upcoming Training',
    this.daysRemainingText = '',
    this.formattedDateTime = '',
    this.venue = '',
    this.coachName = '',
    this.coachAvatar = '',
  });

  factory HomeUpcomingTrainingModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const HomeUpcomingTrainingModel();
    final coach = json['coach'] as Map<String, dynamic>?;

    return HomeUpcomingTrainingModel(
      title: 'Upcoming Training',
      daysRemainingText: json['daysRemainingText'] ?? '',
      formattedDateTime: json['formattedDateTime'] ?? '',
      venue: json['venue'] ?? '',
      coachName: coach?['name'] ?? '',
      coachAvatar: ApiEndPoint.getFullImageUrl(coach?['image']),
    );
  }
}
