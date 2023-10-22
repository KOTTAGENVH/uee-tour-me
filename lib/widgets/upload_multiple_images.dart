import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:tour_me/widgets/loading_popup.dart';
import 'package:tour_me/widgets/message_popup.dart';

class MultipleImageUpload {
  static bool isImagePickerActive = false;

  static Future<List<String>> _uploadMultipleImagesToFirebase(List<File> imageFiles) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    List<String> imageUrls = [];

    for (File imageFile in imageFiles) {
      try {
        String originalFileName = path.basename(imageFile.path);
        String time = DateTime.now().millisecondsSinceEpoch.toString(); // Unique file name
        String fileName = "$time-$originalFileName";

        Reference storageReference = storage.ref().child('images/$fileName');
        UploadTask uploadTask = storageReference.putFile(imageFile);
        await uploadTask.whenComplete(() async {
          String imageUrl = await storageReference.getDownloadURL();
          imageUrls.add(imageUrl);
        });
      } catch (e) {
        print('Error uploading image: $e');
      }
    }

    return imageUrls;
  }

  static Future<List<String>> save(BuildContext context) async {
    if (isImagePickerActive) {
      // Return an empty list or handle it as you prefer
      return [];
    }

    isImagePickerActive = true;
    List<File> selectedImages = [];
    final ImagePicker picker = ImagePicker();

    try {
      for (int i = 0; i < 2; i++) { // Capture two images
        final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
        if (pickedImage != null) {
          selectedImages.add(File(pickedImage.path));
        }
      }
    } catch (e) {
      print('Error picking image: $e');
    } finally {
      isImagePickerActive = false;
    }

    if (selectedImages.length != 2) {
      // Not enough images selected
      return [];
    }

    LoadingPopup().display(context);
    List<String> imageUrls = await _uploadMultipleImagesToFirebase(selectedImages);
    LoadingPopup().remove();

    if (imageUrls.isEmpty) {
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
          message: 'Images have been Uploaded',
        );
      }
    }

    return imageUrls;
  }
}
