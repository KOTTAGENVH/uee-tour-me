import 'package:flutter/material.dart';

class MyImages {
  static const String logo = 'assets/images/logo.png';
  static const String slogan = 'assets/images/slogan.png';
  static const String iconLogo = 'assets/images/logo_img.png';
  static const String traveler = 'assets/images/traveler.png';
  static const String merchant = 'assets/images/merchant.png';
  static const String location = 'assets/images/location.png';
}

class MyColors {
  static const Color pink = Color(0xFFFF5A6E);
  static const Color ash = Color(0xFF444452);
}

class MyRegExps {
  static final RegExp email = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
}

class MyPrefTags {
  static const String userId = 'uid';
  static const String userType = 'userRole';
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
}

class MyStrings{
  static const String traveler = 'traveler';
  static const String merchant = 'merchant';
  static const String host = 'host';
}

class MyErrorCodes {
  static const String firebaseInvalidLoginCredentials = "INVALID_LOGIN_CREDENTIALS";
}
