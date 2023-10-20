import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:tour_me/widgets/loading_popup.dart';
import 'package:tour_me/widgets/message_popup.dart';

class ImageUpload {
  static Future<String?> _uploadImageToFirebase() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage == null) {
      // Image not selected
      return null;
    }

    FirebaseStorage storage = FirebaseStorage.instance;
    File imageFile = File(pickedImage.path);

    try {
      String originalFileName = path.basename(imageFile.path);
      String time = DateTime.now().millisecondsSinceEpoch.toString(); // Unique file name
      String fileName = "$time-$originalFileName";

      String? imageUrl;
      Reference storageReference = storage.ref().child('images/$fileName');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      await uploadTask.whenComplete(() async {
        imageUrl = await storageReference.getDownloadURL();
      });

      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  static Future<String?> save(BuildContext context) async {
    LoadingPopup().display(context);
    String? url = await _uploadImageToFirebase();
    LoadingPopup().remove();
    if (url == null) {
      // Failed to upload
      if (context.mounted) MessagePopUp.display(context);
    } else {
      // Success
      if (context.mounted) {
        MessagePopUp.display(
          context,
          title: "Success",
          icon: const Icon(
            Icons.check_circle_outline,
            color: Colors.green,
          ),
          message: 'Image has been Uploaded',
        );
      }
    }
    return url;
  }
}
