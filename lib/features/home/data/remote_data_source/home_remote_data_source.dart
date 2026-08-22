import 'package:football_club/config/api/api_end_point.dart';
import 'package:football_club/services/api/api_response_model.dart';
import 'package:football_club/services/api/api_service.dart';
import 'package:football_club/services/storage/storage_services.dart';

abstract class HomeRemoteDataSource {
  Future<ApiResponseModel> fetchHomeData();
  Future<ApiResponseModel> fetchSessionNotes({
    required String playerId,
    int page = 1,
    int limit = 10,
  });
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<ApiResponseModel> fetchHomeData() async {
    final Map<String, dynamic> homeDataMap = {
      'sessionsCount': 42,
      'goalsCount': 18,
      'assistsCount': 11,
      'potmCount': 4,
      'playerName': 'James Thornton',
      'playerLevel': 'Advanced',
      'playerSubtitle': 'U14 Elite · Attacking Midfielder',
      'playerProgress': 0.87,
      'playerImagePath': 'assets/images/profile_image.png',
      'trainingTitle': 'Upcoming Training',
      'daysLeftText': '2 days',
      'trainingDateText': 'Tuesday, 18 Feb · 6:00 PM',
      'trainingLocationText': 'TFP Academy, Manchester',
      'trainingCoachName': 'Coach Jay Railton',
      'trainingCoachAvatar': 'assets/images/coach_image.png',
      'goalCategoryTitle': 'Current Target',
      'goalStatusText': 'In Progress',
      'goalTitle': 'Improve Left-Foot Finishing',
      'goalDescription':
          'Achieve 70% accuracy on left-foot shots from inside the box.',
      'goalProgress': 0.62,
      'goalDueDate': 'Due: 28 Feb 2025',
      'feedbackTitle': 'Latest Coach Feedback',
      'feedbackCoachName': 'Coach Jay Railton',
      'feedbackDate': '14 Feb',
      'feedbackContent':
          'Outstanding positioning in the second half.\nJames read the game brilliantly and created',
      'feedbackAvatarPath': 'assets/images/coach_image.png',
      'allCoachFeedbacks': [
        {
          "coachName": "Coach Jay Railton",
          "date": "14 Feb",
          "avatarPath": "assets/images/coach_image.png",
          "feedback":
              "Outstanding positioning in the second half. James read the game brilliantly and created key goal scoring opportunities for the team.",
        },
        {
          "coachName": "Coach Alex Morgan",
          "date": "10 Feb",
          "avatarPath": "assets/images/coach_image.png",
          "feedback":
              "Great stamina and high pressing intensity throughout the 90 minutes. Showed fantastic leadership on the pitch.",
        },
        {
          "coachName": "Coach Marcus Vance",
          "date": "05 Feb",
          "avatarPath": "assets/images/coach_image.png",
          "feedback":
              "Excellent ball distribution from defensive transitions. Keep working on weak foot passing accuracy during drills.",
        },
        {
          "coachName": "Coach Jay Railton",
          "date": "28 Jan",
          "avatarPath": "assets/images/coach_image.png",
          "feedback":
              "Solid tactical discipline and tracking back on set pieces. Showed remarkable improvement in aerial duels.",
        },
        {
          "coachName": "Coach Sarah Jenkins",
          "date": "20 Jan",
          "avatarPath": "assets/images/coach_image.png",
          "feedback":
              "Brilliant execution of quick one-touch passes in tight midfield spaces. Great decision making under pressure.",
        },
      ],
      'achievementCategory': 'RECENT ACHIEVEMENT',
      'achievementTitle': 'Player of the Match',
      'matchInfo': 'U14 League vs Riverside FC · 5 Feb 2025',
    };

    final playerId = LocalStorage.playerId.isNotEmpty
        ? LocalStorage.playerId
        : '9834348934';

    try {
      final response = await ApiService.get(ApiEndPoint.userProfile);
      if (response.statusCode == 200) {
        final profileData = response.data['data'] as Map<String, dynamic>?;
        if (profileData != null) {
          final String userImg = profileData['image'] ?? '';
          final playersList = profileData['players'] as List<dynamic>? ?? [];
          if (playersList.isNotEmpty) {
            final player = playersList.first as Map<String, dynamic>;
            final String fName = player['firstName'] ?? '';
            final String lName = player['lastName'] ?? '';
            final String pName = '$fName $lName'.trim();
            final String pImg = player['image'] ?? '';

            if (pName.isNotEmpty) homeDataMap['playerName'] = pName;
            if (pImg.isNotEmpty) {
              homeDataMap['playerImagePath'] = pImg;
            } else if (userImg.isNotEmpty) {
              homeDataMap['playerImagePath'] = userImg;
            }
          }
        }
      }
    } catch (_) {}

    try {
      final response = await ApiService.get(ApiEndPoint.playerProfile(playerId));
      if (response.statusCode == 200) {
        final profileData = response.data['data'] as Map<String, dynamic>?;
        if (profileData != null) {
          final String name = profileData['name'] ?? '';
          final String image = profileData['image'] ?? '';
          final String levelBadge = profileData['levelBadge'] ?? '';
          final String ageGroupStr = (profileData['ageGroupStr'] ?? '').toString().trim();
          final String squadName = (profileData['squadName'] ?? '').toString().trim();
          final String playingPosition = (profileData['playingPosition'] ?? '').toString().trim();
          final String attendanceRate = (profileData['attendanceRate'] ?? '0%').toString();

          final cleanRate = attendanceRate.replaceAll('%', '').trim();
          final double progress = (double.tryParse(cleanRate) ?? 0.0) / 100.0;

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

          String subtitle = headerText;
          if (playingPosition.isNotEmpty) {
            if (subtitle.isNotEmpty) {
              subtitle += ' · $playingPosition';
            } else {
              subtitle = playingPosition;
            }
          }

          if (name.isNotEmpty) homeDataMap['playerName'] = name;
          if (levelBadge.isNotEmpty) homeDataMap['playerLevel'] = levelBadge;
          if (subtitle.isNotEmpty) homeDataMap['playerSubtitle'] = subtitle;
          homeDataMap['playerProgress'] = progress;
          if (image.isNotEmpty) homeDataMap['playerImagePath'] = image;
        }
      }
    } catch (_) {
      // Fallback silently if profile API call fails
    }

    try {
      final response = await ApiService.get(ApiEndPoint.upcomingTraining(playerId));
      if (response.statusCode == 200) {
        final trainingData = response.data['data'] as Map<String, dynamic>?;
        if (trainingData != null) {
          final String daysRemainingText = trainingData['daysRemainingText'] ?? '';
          final String formattedDateTime = trainingData['formattedDateTime'] ?? '';
          final String venue = trainingData['venue'] ?? '';
          final Map<String, dynamic>? coach = trainingData['coach'] as Map<String, dynamic>?;

          if (daysRemainingText.isNotEmpty) {
            homeDataMap['daysLeftText'] = daysRemainingText;
          }
          if (formattedDateTime.isNotEmpty) {
            homeDataMap['trainingDateText'] = formattedDateTime;
          }
          if (venue.isNotEmpty) {
            homeDataMap['trainingLocationText'] = venue;
          }
          if (coach != null) {
            final String coachName = coach['name'] ?? '';
            final String coachImage = coach['image'] ?? '';
            if (coachName.isNotEmpty) {
              homeDataMap['trainingCoachName'] = coachName;
            }
            if (coachImage.isNotEmpty) {
              homeDataMap['trainingCoachAvatar'] = coachImage;
            }
          }
        }
      }
    } catch (_) {
      // Fallback silently if upcoming training API call fails
    }

    try {
      final response = await ApiService.get(ApiEndPoint.currentTarget(playerId));
      if (response.statusCode == 200) {
        final targetData = response.data['data'] as Map<String, dynamic>?;
        if (targetData != null) {
          final String title = targetData['title'] ?? '';
          final String description = targetData['description'] ?? '';
          final String status = targetData['status'] ?? '';
          final String dueFormatted = targetData['dueFormatted'] ?? '';
          final dynamic rawProgress = targetData['progress'];

          double progressVal = 0.0;
          if (rawProgress is num) {
            progressVal = rawProgress > 1 ? rawProgress.toDouble() / 100.0 : rawProgress.toDouble();
          } else if (rawProgress is String) {
            final clean = rawProgress.replaceAll('%', '').trim();
            final parsed = double.tryParse(clean) ?? 0.0;
            progressVal = parsed > 1 ? parsed / 100.0 : parsed;
          }

          if (title.isNotEmpty) homeDataMap['goalTitle'] = title;
          if (description.isNotEmpty) homeDataMap['goalDescription'] = description;
          if (status.isNotEmpty) homeDataMap['goalStatusText'] = status;
          if (dueFormatted.isNotEmpty) homeDataMap['goalDueDate'] = dueFormatted;
          homeDataMap['goalProgress'] = progressVal;
        }
      }
    } catch (_) {
      // Fallback silently if current target API call fails
    }

    try {
      final response = await ApiService.get(ApiEndPoint.latestFeedback(playerId));
      if (response.statusCode == 200) {
        final feedbackData = response.data['data'] as Map<String, dynamic>?;
        if (feedbackData != null) {
          final String coachName = feedbackData['coachName'] ?? '';
          final String coachImage = feedbackData['coachImage'] ?? '';
          final String note = feedbackData['note'] ?? '';
          final String dateFormatted = feedbackData['dateFormatted'] ?? '';

          if (coachName.isNotEmpty) {
            homeDataMap['feedbackCoachName'] = coachName;
          }
          if (coachImage.isNotEmpty) {
            homeDataMap['feedbackAvatarPath'] = coachImage;
          }
          if (note.isNotEmpty) {
            homeDataMap['feedbackContent'] = note;
          }
          if (dateFormatted.isNotEmpty) {
            homeDataMap['feedbackDate'] = dateFormatted;
          }
        }
      }
    } catch (_) {
      // Fallback silently if feedback API call fails
    }

    try {
      final response = await ApiService.get(ApiEndPoint.myAchievements(playerId));
      if (response.statusCode == 200) {
        dynamic rawData = response.data['data'];
        List<dynamic> achievementsList = [];

        if (rawData is Map<String, dynamic>) {
          if (rawData['achievements'] is List && (rawData['achievements'] as List).isNotEmpty) {
            achievementsList = rawData['achievements'] as List;
          } else if (rawData['grid'] is List && (rawData['grid'] as List).isNotEmpty) {
            achievementsList = rawData['grid'] as List;
          }
        } else if (rawData is List) {
          achievementsList = rawData;
        }

        if (achievementsList.isNotEmpty) {
          final firstAch = achievementsList.first as Map<String, dynamic>;
          final String title = (firstAch['awardType'] ?? firstAch['title'] ?? firstAch['name'] ?? 'Player of the Match').toString();
          final String event = (firstAch['matchEvent'] ?? firstAch['subtitle'] ?? firstAch['description'] ?? '').toString();
          final String date = (firstAch['formattedDate'] ?? firstAch['date'] ?? firstAch['value'] ?? '').toString();

          homeDataMap['achievementCategory'] = 'RECENT ACHIEVEMENT';
          if (title.isNotEmpty) {
            homeDataMap['achievementTitle'] = title;
          }
          if (event.isNotEmpty && date.isNotEmpty) {
            homeDataMap['matchInfo'] = '$event · $date';
          } else if (event.isNotEmpty) {
            homeDataMap['matchInfo'] = event;
          } else if (date.isNotEmpty) {
            homeDataMap['matchInfo'] = date;
          }
        }
      }
    } catch (_) {
      // Fallback silently if achievements API call fails
    }

    return ApiResponseModel(200, {'data': homeDataMap});
  }

  @override
  Future<ApiResponseModel> fetchSessionNotes({
    required String playerId,
    int page = 1,
    int limit = 10,
  }) async {
    return await ApiService.get(
      ApiEndPoint.sessionNotes(playerId, page: page, limit: limit),
    );
  }
}
