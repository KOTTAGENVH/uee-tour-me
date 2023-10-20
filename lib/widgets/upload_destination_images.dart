import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

Future<String?> uploadImageToFirebase() async {
  final _picker = ImagePicker();
  final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    File imageFile = File(pickedFile.path);
    FirebaseStorage storage = FirebaseStorage.instance;

    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString(); // Unique file name
      Reference storageReference = storage.ref().child('images/$fileName');
print('storageReference: $storageReference');
      UploadTask uploadTask = storageReference.putFile(imageFile);

      await uploadTask.whenComplete(() async {
        // Get the download URL for the uploaded image
        String imageUrl = await storageReference.getDownloadURL();
print('imageUrl: $imageUrl'); 
        // Store the URL in Firestore
        CollectionReference _imagesCollection =
            FirebaseFirestore.instance.collection('images');
        DocumentReference docRef =
            await _imagesCollection.add({'url': imageUrl});
        String documentId = docRef.id;

        // Return the document ID where the URL is stored
        return documentId;
      });

      // Show a success toast message
      Fluttertoast.showToast(
        msg: 'Successfully uploaded image',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
      );
    } catch (e) {
      // Handle the error and show an error toast message
      print('Error uploading image: $e');
      Fluttertoast.showToast(
        msg: 'Error uploading image: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );
      return null;
    }
  } else {
    return null; // No image selected
  }
}
