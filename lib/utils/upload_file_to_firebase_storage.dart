import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

/// Uploads a given file to the given storage path.<br />
/// @param file: The file to be uploaded.<br />
/// @param storagePath: The path in Firebase Storage to which the file should be uploaded.<br />
/// @return [Future<String>] - returns the URL link to the uploaded file.<br />
/// @throws Exception if it fails to upload the file.<br />
///<br />
/// Warning: This function may throw exceptions. Make sure to handle them in your code.
Future<String> uploadFileToFirebaseStorage({
  required File file,
  required String storagePath,
}) async {
  // Generate a unique name for the file.
  String originalFileName = path.basename(file.path);
  String time = DateTime.now().millisecondsSinceEpoch.toString();
  String fileName = "$time-$originalFileName";

  // Get a reference to the Firebase Storage instance.
  FirebaseStorage storage = FirebaseStorage.instance;
  Reference storageReference = storage.ref().child('$storagePath/$fileName');

  // Upload the file.
  String downloadUrl = await storageReference.putFile(file).then((taskSnapshot) {
    return taskSnapshot.ref.getDownloadURL();
  });

  // Return the successful image URL.
  return downloadUrl;
}
