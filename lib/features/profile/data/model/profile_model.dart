import 'package:football_club/features/profile/domain/entity/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.playerName,
    required super.email,
    required super.dob,
    required super.parentName,
    required super.mobile,
    required super.position,
    required super.preferredFoot,
    required super.profileImagePath,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      playerName: json['playerName'] ?? 'James Thornton',
      email: json['email'] ?? 'james.thornton@example.com',
      dob: json['dob'] ?? '02-02-2000',
      parentName: json['parentName'] ?? 'Robert Thornton',
      mobile: json['mobile'] ?? '+44 7911 123456',
      position: json['position'] ?? 'Attacking Midfielder',
      preferredFoot: json['preferredFoot'] ?? 'Right',
      profileImagePath:
          json['profileImagePath'] ?? 'assets/images/profile_image.png',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'playerName': playerName,
      'email': email,
      'dob': dob,
      'parentName': parentName,
      'mobile': mobile,
      'position': position,
      'preferredFoot': preferredFoot,
      'profileImagePath': profileImagePath,
    };
  }
}
