class UserEntity {
  final String? id;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? countryCode;
  final String? role;
  final String? accessToken;
  final String? refreshToken;

  const UserEntity({
    this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.countryCode,
    this.role,
    this.accessToken,
    this.refreshToken,
  });
}
