import 'package:football_club/features/profile/domain/entity/profile_entity.dart';
import 'package:football_club/services/storage/storage_services.dart';

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
    super.bloodGroup,
    super.allergies,
    super.medicalConditions,
    super.medications,
    super.emergencyContactName,
    super.emergencyPhone,
    super.medicalNotes,
    super.homeAddress,
    super.city,
    super.postcode,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final String userEmail = json['email'] ?? '';
    final String parentName = json['name'] ?? json['parentName'] ?? '';
    final String userImage = json['image'] ?? '';

    String playerName = '';
    String birthDate = json['dob'] ?? '';
    String phone = json['mobile'] ?? '';
    String pos = json['position'] ?? 'Forward';
    String foot = json['favouriteFoot'] ?? json['preferredFoot'] ?? 'Right';
    String img = userImage.isNotEmpty ? userImage : (json['profileImagePath'] ?? '');

    String blood = '';
    String allergyStr = '';
    String medConditions = '';
    String meds = '';
    String emgName = '';
    String emgPhone = '';
    String medNotes = '';

    String hAddr = '';
    String cCity = '';
    String pCode = '';

    final playersList = json['players'] as List<dynamic>? ?? [];
    if (playersList.isNotEmpty) {
      final player = playersList.first as Map<String, dynamic>;
      final String fName = player['firstName'] ?? '';
      final String lName = player['lastName'] ?? '';
      if (fName.isNotEmpty || lName.isNotEmpty) {
        playerName = '$fName $lName'.trim();
      } else if (player['name'] != null && (player['name'] as String).isNotEmpty) {
        playerName = player['name'];
      }

      final String rawDob = player['dateOfBirth'] ?? '';
      if (rawDob.isNotEmpty) {
        try {
          final DateTime parsed = DateTime.parse(rawDob);
          birthDate =
              "${parsed.day.toString().padLeft(2, '0')}-${parsed.month.toString().padLeft(2, '0')}-${parsed.year}";
        } catch (_) {
          birthDate = rawDob;
        }
      }

      final String playerPos = player['playingPosition'] ?? '';
      if (playerPos.isNotEmpty) pos = playerPos;

      final String playerFoot = player['favouriteFoot'] ?? '';
      if (playerFoot.isNotEmpty) foot = playerFoot;

      final String playerImg = player['image'] ?? '';
      if (playerImg.isNotEmpty) img = playerImg;

      final String altPhone = player['alternativePhone'] ?? '';
      if (altPhone.isNotEmpty) {
        phone = altPhone;
      }

      final medicalInfo = player['medicalInfo'] as Map<String, dynamic>?;
      if (medicalInfo != null) {
        blood = medicalInfo['bloodGroup'] ?? '';
        dynamic rawAllergies = medicalInfo['allergies'];
        if (rawAllergies is List) {
          allergyStr = rawAllergies.join(', ');
        } else if (rawAllergies != null) {
          allergyStr = rawAllergies.toString();
        }
        medConditions = medicalInfo['medicalConditions'] ?? '';
        meds = medicalInfo['medications'] ?? '';
        emgName = medicalInfo['emergencyContactName'] ?? '';
        emgPhone = medicalInfo['emergencyPhone'] ?? '';
        medNotes = medicalInfo['medicalNotes'] ?? '';

        if (phone.isEmpty && emgPhone.isNotEmpty) {
          phone = emgPhone;
        }
      }

      final addressInfo = player['address'] as Map<String, dynamic>?;
      if (addressInfo != null) {
        hAddr = addressInfo['homeAddress'] ?? '';
        cCity = addressInfo['city'] ?? '';
        pCode = addressInfo['postcode'] ?? '';
      }

      final String pId = player['_id'] ?? player['id'] ?? '';
      if (pId.isNotEmpty) {
        LocalStorage.playerId = pId;
      }
    }

    if (playerName.isEmpty) {
      playerName = json['playerName'] ?? parentName;
    }

    return ProfileModel(
      playerName: playerName,
      email: userEmail.isNotEmpty ? userEmail : (json['email'] ?? ''),
      dob: birthDate.isNotEmpty ? birthDate : (json['dob'] ?? '15-05-2010'),
      parentName: parentName.isNotEmpty ? parentName : (json['parentName'] ?? ''),
      mobile: phone.isNotEmpty ? phone : (json['mobile'] ?? ''),
      position: pos,
      preferredFoot: foot,
      profileImagePath: img,
      bloodGroup: blood,
      allergies: allergyStr,
      medicalConditions: medConditions,
      medications: meds,
      emergencyContactName: emgName,
      emergencyPhone: emgPhone,
      medicalNotes: medNotes,
      homeAddress: hAddr,
      city: cCity,
      postcode: pCode,
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
      'bloodGroup': bloodGroup,
      'allergies': allergies,
      'medicalConditions': medicalConditions,
      'medications': medications,
      'emergencyContactName': emergencyContactName,
      'emergencyPhone': emergencyPhone,
      'medicalNotes': medicalNotes,
      'homeAddress': homeAddress,
      'city': city,
      'postcode': postcode,
    };
  }
}
