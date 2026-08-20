import 'package:football_club/features/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.id,
    super.playerId,
    super.fullName,
    super.email,
    super.phoneNumber,
    super.countryCode,
    super.role,
    super.accessToken,
    super.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? json['id'],
      playerId: json['playerId'],
      fullName: json['fullName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      countryCode: json['countryCode'],
      role: json['role'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'playerId': playerId,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'countryCode': countryCode,
      'role': role,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}
