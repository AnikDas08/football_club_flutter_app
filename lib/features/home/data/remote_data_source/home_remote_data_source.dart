import 'package:football_club/services/api/api_response_model.dart';

abstract class HomeRemoteDataSource {
  Future<ApiResponseModel> fetchHomeData();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<ApiResponseModel> fetchHomeData() async {
    return ApiResponseModel(
      200,
      {
        'data': {
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
        }
      },
    );
  }
}
