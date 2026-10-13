import 'package:flutter/foundation.dart';
import 'package:football_club/config/api/api_end_point.dart';
import 'package:football_club/services/api/api_response_model.dart';
import 'package:football_club/services/api/api_service.dart';
import 'package:football_club/services/storage/storage_services.dart';

import '../../../../services/storage/storage_keys.dart';

abstract class HomeRemoteDataSource {
  Future<ApiResponseModel> fetchHomeData();
  Future<ApiResponseModel> fetchSessionNotes({
    required String playerId,
    int page = 1,
    int limit = 10,
  });
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  String _resolveImageUrl(String? rawUrl) {
    return ApiEndPoint.getFullImageUrl(rawUrl);
  }

  String _monthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    if (month >= 1 && month <= 12) return months[month - 1];
    return '';
  }

  @override
  Future<ApiResponseModel> fetchHomeData() async {
    final Map<String, dynamic> homeDataMap = {
      'sessionsCount': 0,
      'goalsCount': 0,
      'assistsCount': 0,
      'potmCount': 0,
      'playerName': LocalStorage.myName.isNotEmpty ? LocalStorage.myName : 'Player',
      'playerLevel': '',
      'playerSubtitle': '',
      'playerProgress': 0.0,
      'playerImagePath': LocalStorage.myImage.isNotEmpty ? _resolveImageUrl(LocalStorage.myImage) : '',
      'trainingTitle': '',
      'daysLeftText': '',
      'trainingDateText': '',
      'trainingLocationText': '',
      'trainingCoachName': '',
      'trainingCoachAvatar': '',
      'goalCategoryTitle': '',
      'goalStatusText': '',
      'goalTitle': '',
      'goalDescription': '',
      'goalProgress': 0.0,
      'goalDueDate': '',
      'feedbackTitle': '',
      'feedbackCoachName': '',
      'feedbackDate': '',
      'feedbackContent': '',
      'feedbackAvatarPath': '',
      'allCoachFeedbacks': <Map<String, dynamic>>[],
      'achievementCategory': '',
      'achievementTitle': '',
      'matchInfo': '',
    };

    String playerId = LocalStorage.playerId.trim();

    try {
      final response = await ApiService.get(ApiEndPoint.userProfile);
      if (response.statusCode == 200) {
        final profileData = response.data['data'] as Map<String, dynamic>?;
        if (profileData != null) {
          final String uName = (profileData['name'] ?? '').toString().trim();
          if (uName.isNotEmpty) {
            homeDataMap['playerName'] = uName;
          }
          final String userImg = profileData['image'] ?? '';
          if (userImg.isNotEmpty) {
            homeDataMap['playerImagePath'] = _resolveImageUrl(userImg);
          }

          final pId = (profileData['playerId'] ?? '').toString().trim();
          if (pId.isNotEmpty) {
            playerId = pId;
            LocalStorage.playerId = pId;
            await LocalStorage.setString(LocalStorageKeys.playerId, pId);
          }

          final playersList = profileData['players'] as List<dynamic>? ?? [];
          if (playersList.isNotEmpty) {
            final player = playersList.first as Map<String, dynamic>;
            final String fName = player['firstName'] ?? '';
            final String lName = player['lastName'] ?? '';
            final String pName = '$fName $lName'.trim();
            final String pImg = player['image'] ?? '';

            if (pName.isNotEmpty) homeDataMap['playerName'] = pName;
            if (pImg.isNotEmpty) {
              homeDataMap['playerImagePath'] = _resolveImageUrl(pImg);
            }

            final otherDev = player['otherDevelopment'] as Map<String, dynamic>?;
            if (otherDev != null) {
              if (otherDev.containsKey('sessions')) {
                homeDataMap['sessionsCount'] = (otherDev['sessions'] as num?)?.toInt() ?? 0;
              }
              if (otherDev.containsKey('goals')) {
                homeDataMap['goalsCount'] = (otherDev['goals'] as num?)?.toInt() ?? 0;
              }
              if (otherDev.containsKey('assists')) {
                homeDataMap['assistsCount'] = (otherDev['assists'] as num?)?.toInt() ?? 0;
              }
              if (otherDev.containsKey('potm')) {
                homeDataMap['potmCount'] = (otherDev['potm'] as num?)?.toInt() ?? 0;
              }
            }
          }

          final resolvedImg = (homeDataMap['playerImagePath'] as String? ?? '').trim();
          debugPrint('📸 [HomeRemoteDataSource] Resolved playerImagePath from API: "$resolvedImg"');
          if (resolvedImg.isNotEmpty) {
            LocalStorage.myImage = resolvedImg;
            await LocalStorage.setString(LocalStorageKeys.myImage, resolvedImg);
          }
        }
      }
    } catch (_) {}

    if (playerId.isNotEmpty) {
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
            final String attendanceRate = (profileData['attendanceRate'] ?? '').toString();

            final cleanRate = attendanceRate.replaceAll('%', '').trim();
            final double progress = cleanRate.isNotEmpty ? ((double.tryParse(cleanRate) ?? 0.0) / 100.0) : 0.0;

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
            if (progress > 0) homeDataMap['playerProgress'] = progress;
            if (image.isNotEmpty) {
              homeDataMap['playerImagePath'] = _resolveImageUrl(image);
            }
          }
        }
      } catch (_) {}

      try {
        final response = await ApiService.get(ApiEndPoint.overallScore(playerId));
        if (response.statusCode == 200 && response.data['data'] != null) {
          final overallData = response.data['data'] as Map<String, dynamic>?;
          if (overallData != null) {
            final badge = (overallData['performanceBadge'] ?? '').toString();
            if (badge.isNotEmpty && (homeDataMap['playerLevel'] as String).isEmpty) {
              homeDataMap['playerLevel'] = badge;
            }
            final score = (overallData['overallScore'] as num?)?.toDouble();
            if (score != null && (homeDataMap['playerProgress'] as double) == 0.0) {
              homeDataMap['playerProgress'] = (score / 10.0).clamp(0.0, 1.0);
            }
          }
        }
      } catch (_) {}

      try {
        final response = await ApiService.get(ApiEndPoint.developmentStats(playerId));
        if (response.statusCode == 200) {
          final statsData = response.data['data'] as Map<String, dynamic>?;
          if (statsData != null) {
            if (statsData.containsKey('sessions')) {
              homeDataMap['sessionsCount'] = (statsData['sessions'] as num?)?.toInt() ?? 0;
            }
            if (statsData.containsKey('goals')) {
              homeDataMap['goalsCount'] = (statsData['goals'] as num?)?.toInt() ?? 0;
            }
            if (statsData.containsKey('assists')) {
              homeDataMap['assistsCount'] = (statsData['assists'] as num?)?.toInt() ?? 0;
            }
            if (statsData.containsKey('potm')) {
              homeDataMap['potmCount'] = (statsData['potm'] as num?)?.toInt() ?? 0;
            }
          }
        }
      } catch (_) {}

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
                homeDataMap['trainingCoachAvatar'] = _resolveImageUrl(coachImage);
              }
            }
            homeDataMap['trainingTitle'] = 'Upcoming Training';
          }
        }
      } catch (_) {}

      try {
        var response = await ApiService.get(ApiEndPoint.currentTarget(playerId));
        Map<String, dynamic>? targetData;
        if (response.statusCode == 200 && response.data['data'] != null) {
          final d = response.data['data'];
          if (d is Map<String, dynamic> && d.isNotEmpty) {
            targetData = d;
          } else if (d is List && d.isNotEmpty) {
            targetData = d.first as Map<String, dynamic>;
          }
        }

        if (targetData == null) {
          final myTargetsRes = await ApiService.get(ApiEndPoint.myTargets(playerId, page: 1, limit: 1));
          if (myTargetsRes.statusCode == 200 && myTargetsRes.data['data'] != null) {
            final td = myTargetsRes.data['data'];
            if (td is List && td.isNotEmpty) {
              targetData = td.first as Map<String, dynamic>;
            } else if (td is Map<String, dynamic> && td.isNotEmpty) {
              targetData = td;
            }
          }
        }

        if (targetData != null) {
          final String title = targetData['title'] ?? targetData['name'] ?? '';
          final String description = targetData['description'] ?? '';
          final String status = targetData['status'] ?? 'In Progress';
          final String dueFormatted = targetData['dueFormatted'] ?? targetData['dueDate'] ?? '';
          final dynamic rawProgress = targetData['progress'];

          double progressVal = 0.0;
          if (rawProgress is num) {
            progressVal = rawProgress > 1 ? rawProgress.toDouble() / 100.0 : rawProgress.toDouble();
          } else if (rawProgress is String) {
            final clean = rawProgress.replaceAll('%', '').trim();
            final parsed = double.tryParse(clean) ?? 0.0;
            progressVal = parsed > 1 ? parsed / 100.0 : parsed;
          }

          if (title.isNotEmpty) {
            homeDataMap['goalCategoryTitle'] = 'Current Target';
            homeDataMap['goalTitle'] = title;
            homeDataMap['goalDescription'] = description;
            homeDataMap['goalStatusText'] = status;
            homeDataMap['goalDueDate'] = dueFormatted;
            homeDataMap['goalProgress'] = progressVal;
          }
        }
      } catch (_) {}

      try {
        var response = await ApiService.get(ApiEndPoint.latestFeedback(playerId));
        Map<String, dynamic>? feedbackData;
        if (response.statusCode == 200 && response.data['data'] != null) {
          final d = response.data['data'];
          if (d is Map<String, dynamic> && d.isNotEmpty) {
            feedbackData = d;
          } else if (d is List && d.isNotEmpty) {
            feedbackData = d.first as Map<String, dynamic>;
          }
        }

        if (feedbackData == null) {
          final notesRes = await ApiService.get(ApiEndPoint.sessionNotes(playerId, page: 1, limit: 10));
          if (notesRes.statusCode == 200 && notesRes.data['data'] != null) {
            final nd = notesRes.data['data'];
            if (nd is List && nd.isNotEmpty) {
              feedbackData = nd.first as Map<String, dynamic>;
              final allNotes = nd.map((e) {
                final m = e as Map<String, dynamic>;
                return {
                  "coachName": m['coachName'] ?? '',
                  "date": m['createdAt'] ?? '',
                  "avatarPath": _resolveImageUrl(m['coachImage']),
                  "feedback": m['note'] ?? m['feedback'] ?? '',
                };
              }).toList();
              homeDataMap['allCoachFeedbacks'] = allNotes;
            } else if (nd is Map<String, dynamic> && nd.isNotEmpty) {
              feedbackData = nd;
            }
          }
        }

        if (feedbackData != null) {
          final String coachName = feedbackData['coachName'] ?? '';
          final String coachImage = feedbackData['coachImage'] ?? '';
          final String note = feedbackData['note'] ?? feedbackData['feedback'] ?? '';
          final String dateFormatted = feedbackData['dateFormatted'] ?? '';

          homeDataMap['feedbackTitle'] = 'Latest Coach Feedback';
          if (coachName.isNotEmpty) {
            homeDataMap['feedbackCoachName'] = coachName;
          }
          if (coachImage.isNotEmpty) {
            homeDataMap['feedbackAvatarPath'] = _resolveImageUrl(coachImage);
          }
          if (note.isNotEmpty) {
            homeDataMap['feedbackContent'] = note;
          }
          if (dateFormatted.isNotEmpty) {
            homeDataMap['feedbackDate'] = dateFormatted;
          } else if (feedbackData['createdAt'] != null) {
            final dt = DateTime.tryParse(feedbackData['createdAt'].toString());
            if (dt != null) {
              homeDataMap['feedbackDate'] = '${dt.day} ${_monthName(dt.month)}';
            }
          }
        }
      } catch (_) {}

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
            final String title = (firstAch['awardType'] ?? firstAch['title'] ?? firstAch['name'] ?? '').toString();
            final String event = (firstAch['matchEvent'] ?? firstAch['subtitle'] ?? firstAch['description'] ?? '').toString();
            final String date = (firstAch['formattedDate'] ?? firstAch['date'] ?? firstAch['value'] ?? '').toString();

            if (title.isNotEmpty) {
              homeDataMap['achievementCategory'] = 'RECENT ACHIEVEMENT';
              homeDataMap['achievementTitle'] = title;
              if (event.isNotEmpty && date.isNotEmpty) {
                homeDataMap['matchInfo'] = '$event · $date';
              } else if (event.isNotEmpty) {
                homeDataMap['matchInfo'] = event;
              } else if (date.isNotEmpty) {
                homeDataMap['matchInfo'] = date;
              }
            }
          }
        }
      } catch (_) {}
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
