import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class MyImages {
  static const String logo = 'assets/images/logo.png';
  static const String slogan = 'assets/images/slogan.png';
  static const String iconLogo = 'assets/images/logo_img.png';
  static const String traveler = 'assets/images/traveler.png';
  static const String merchant = 'assets/images/merchant.png';
  static const String location = 'assets/images/location.png';
  static const String creditCard = 'assets/images/creditCard.png';
  static const String itemlList = 'assets/images/itemList.png';
  static const String profile = 'assets/images/profile.png';
  static const String emptyShops = 'assets/images/empty_shops.png';
  static const String items = 'assets/images/items.png';
  static const String traveller = 'assets/images/traveller.png';
  // Web images
  static const String noLocationImage =
      "https://img.freepik.com/free-vector/place-icon-gold-glossy-design_343694-2633.jpg?w=740&t=st=1698466710~exp=1698467310~hmac=ee8c5adfc2085b8a5e3eed8c15031aa39f7f0d25ac4dafdd5d300eebbdaf39d1";
}

class MyColors {
  static const Color pink = Color(0xFFFF5A6E);
  static const Color ash = Color(0xFF444452);
  static const Color black2 = Color(0xFF151515);
  static const LinearGradient backgrounGradient = LinearGradient(
    colors: [MyColors.black2, Colors.black],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class MyRegExps {
  static final RegExp email = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
}

class MyPrefTags {
  static const String userId = 'uid';
  static const String userRole = 'userRole';
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String profileImage = 'profileImage';
  static const String selectedLocationList = 'locationList';
  
}

class MyStrings {
  static const String traveler = 'traveler';
  static const String merchant = 'merchant';
  static const String host = 'host';
}

class MyErrorCodes {
  static const String firebaseInvalidLoginCredentials = "INVALID_LOGIN_CREDENTIALS";
  static const String firebaseInvalidEmail = "invalid-email";
  static const String firebaseEmailAlreadyInUse = "email-already-in-use";
}

class MyMap {
  static const Map<String, String> accessOptions = {
    'accessToken': 'pk.eyJ1IjoiaXQyMTAyMTUzNCIsImEiOiJjbG56eXd4djMwd2VqMmpxaDYwOHZjdzhmIn0.e4Ec6xvIyMbxcumHe9MDzg',
    'id': 'mapbox.mapbox-streets-v8',
  };
  static const String tileUrl =
      'https://api.mapbox.com/styles/v1/it21021534/clnzz2bdm00bk01qvfm5532ai/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaXQyMTAyMTUzNCIsImEiOiJjbG56eXd4djMwd2VqMmpxaDYwOHZjdzhmIn0.e4Ec6xvIyMbxcumHe9MDzg';
  static const LatLng initialCenter = LatLng(7.903092, 80.670837);
  static const double initialZoom = 7.7;
  static const String routeAuthKey = '5b3ce3597851110001cf6248211801968e064168aae20cd718432fc1';
}

class MyFirestore {
  static const String usersCollection = 'users';
}
