class ProfileEntity {
  final String playerName;
  final String email;
  final String dob;
  final String parentName;
  final String mobile;
  final String position;
  final String preferredFoot;
  final String profileImagePath;
  final String bloodGroup;
  final String allergies;
  final String medicalConditions;
  final String medications;
  final String emergencyContactName;
  final String emergencyPhone;
  final String medicalNotes;
  final String homeAddress;
  final String city;
  final String postcode;

  const ProfileEntity({
    required this.playerName,
    required this.email,
    required this.dob,
    required this.parentName,
    required this.mobile,
    required this.position,
    required this.preferredFoot,
    required this.profileImagePath,
    this.bloodGroup = '',
    this.allergies = '',
    this.medicalConditions = '',
    this.medications = '',
    this.emergencyContactName = '',
    this.emergencyPhone = '',
    this.medicalNotes = '',
    this.homeAddress = '',
    this.city = '',
    this.postcode = '',
  });
}
