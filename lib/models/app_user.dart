// ignore_for_file: constant_identifier_names

class AppUser {
  static const String ID = 'user_id';
  static const String USER_ROLE = 'user_role';
  static const String FIRST_NAME = 'first_name';
  static const String LAST_NAME = 'last_name';
  static const String PROFILE_IMAGE = 'profile_image';
  static const String TRAVELER_PREFERENCES = 'traveler_preferences';

  final String? uid;
  final String? userRole;
  final String? firstName;
  final String? lastName;
  String? profileImage;
  final List<String>? travelerPrefs;

  AppUser({
    this.uid,
    this.userRole,
    this.firstName,
    this.lastName,
    this.profileImage,
    this.travelerPrefs,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> userMap = {
      ID: uid,
      USER_ROLE: userRole,
      FIRST_NAME: firstName,
      LAST_NAME: lastName,
      PROFILE_IMAGE: profileImage,
      TRAVELER_PREFERENCES: travelerPrefs,
    };

    // Remove properties with null values to avoid adding nulls to Firestore
    userMap.removeWhere((key, value) => value == null);

    return userMap;
  }
}
