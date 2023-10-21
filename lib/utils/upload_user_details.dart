import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/models/app_user.dart';
import 'package:tour_me/utils/upload_file_to_firebase_storage.dart';

Future<bool> uploadUserDetails(BuildContext context) async {
  final SecureSharedPref pref = await SecureSharedPref.getInstance();

  final AppUser user = AppUser(
    uid: await pref.getString(MyPrefTags.userId, isEncrypted: true),
    userRole: await pref.getString(MyPrefTags.userRole, isEncrypted: true),
    firstName: await pref.getString(MyPrefTags.firstName),
    lastName: await pref.getString(MyPrefTags.lastName),
    profileImage: await pref.getString(MyPrefTags.profileImage),
  );

  if (user.uid == null || user.userRole == null || user.firstName == null) {
    return false;
  }

  if (user.profileImage != null && context.mounted) {
    final File file = File(user.profileImage!);
    user.profileImage = await uploadFileToFirebaseStorage(file: file, storagePath: 'profilePics');
    print(user.profileImage);
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference usersCollection = firestore.collection('users');

  final Map<String, dynamic> userDetails = user.toMap();
  await usersCollection.doc(user.uid).set(userDetails);

  return true;
}
