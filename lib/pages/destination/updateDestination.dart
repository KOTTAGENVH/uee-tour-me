// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/widgets/destination_owner_bottom_nav.dart';
import 'package:tour_me/widgets/labeled_divider.dart';
import 'package:tour_me/widgets/message_popup.dart';
import 'package:tour_me/widgets/next_back_button.dart';
import 'package:tour_me/widgets/upload_image_button.dart';
import 'package:tour_me/widgets/upload_multiple_images.dart';

class UpdateDestination extends StatefulWidget {
  final String destinationName;
  final String streetNo;
  final String streetName;
  final String city;
  final String weekstartTime;
  final String weekendTime;
  final String weekendstartTime;
  final String weekendendTime;
  final String description;
  final String location;
  final String destinationImage1;
  final String destinationImage2;
  final String cardNo;
  final String csv;
  final String expiryDate;
  final String token;
  final String userId;

  const UpdateDestination({
    super.key,
    required this.destinationName,
    required this.streetNo,
    required this.streetName,
    required this.city,
    required this.weekstartTime,
    required this.weekendTime,
    required this.weekendstartTime,
    required this.weekendendTime,
    required this.description,
    required this.location,
    required this.destinationImage1,
    required this.destinationImage2,
    required this.cardNo,
    required this.csv,
    required this.expiryDate,
    required this.token,
    required this.userId,
    required String documentId,
  });

  @override
  State<UpdateDestination> createState() => _UpdateState();
}

class _UpdateState extends State<UpdateDestination> {
  late TextEditingController _weekstartTimeController;
  late TextEditingController _weekendTimeController;
  late TextEditingController _weekendstartTimeController;
  late TextEditingController _weekendendTimeController;
  late TextEditingController _description;
  final TextEditingController _locationImage1 = TextEditingController();
  final TextEditingController _locationImage2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    _weekstartTimeController =
        TextEditingController(text: widget.weekstartTime);
    _weekendTimeController = TextEditingController(text: widget.weekendTime);
    _weekendstartTimeController =
        TextEditingController(text: widget.weekendstartTime);
    _weekendendTimeController =
        TextEditingController(text: widget.weekendendTime);
    _description = TextEditingController(text: widget.description);
  }

  @override
  void dispose() {
    _weekstartTimeController.dispose();
    // Dispose of other controllers...
    super.dispose();
  }

  final CollectionReference _destination =
      FirebaseFirestore.instance.collection('Destination');

  void showImageUploadToast(String? imageUrl, bool success) {
    if (imageUrl != null) {
      Fluttertoast.showToast(
        msg: 'Successfully uploaded image: $imageUrl',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Sorry, upload failed.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool imageUploaded = false;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          leading: Image.asset(MyImages.iconLogo),
          title:
              const Text('Update Destination', style: TextStyle(fontSize: 25)),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white.withOpacity(0.5),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 40),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const LabeledDivider(label: 'Image Upload'),
                UploadImageButton(
                  onPress: () async {
                    List<String> urls = await MultipleImageUpload.save(context);

                    if (urls.isNotEmpty) {
                      _locationImage1.text = urls[0];
                      _locationImage2.text = urls[1];
                      setState(() {
                        imageUploaded = true;
                      });
                      print('urls: ${urls}');
                      print('Image1: ${_locationImage1.text}');
                      print('Image2: ${_locationImage2.text}');
                      print('imageUploaded = $imageUploaded');
                      showImageUploadToast(
                          'Successfully Uploaded Images', true);
                    } else {
                      // Handle the case where no URLs were returned (e.g., upload failure)
                      showImageUploadToast('Failed to Upload Image1s', false);
                    }
                  },
                  text: imageUploaded
                      ? 'Destination Image! uploaded \u2713'
                      : 'Upload Destination Image',
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: 20), // Adjust the margin as needed
                  child: const LabeledDivider(label: 'Weekday Time'),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _weekstartTimeController,
                        decoration: InputDecoration(
                          labelText: 'Start Time',
                          labelStyle: const TextStyle(color: Colors.white),
                          prefixIcon: const Icon(
                            Icons.access_time,
                            color: Colors.white,
                          ),
                          filled: true,
                          fillColor: const Color(0xFF454452),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        controller: _weekendTimeController,
                        decoration: InputDecoration(
                          labelText: 'End Time',
                          labelStyle: const TextStyle(color: Colors.white),
                          prefixIcon: const Icon(
                            Icons.access_time,
                            color: Colors.white,
                          ),
                          filled: true,
                          fillColor: const Color(0xFF454452),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: 20, top: 20), // Adjust the margin as needed
                  child: const LabeledDivider(label: 'Weekend Time'),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _weekendstartTimeController,
                        decoration: InputDecoration(
                          labelText: 'Start Time',
                          labelStyle: const TextStyle(color: Colors.white),
                          prefixIcon: const Icon(
                            Icons.access_time,
                            color: Colors.white,
                          ),
                          filled: true,
                          fillColor: const Color(0xFF454452),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        controller: _weekendendTimeController,
                        decoration: InputDecoration(
                          labelText: 'End Time',
                          labelStyle: const TextStyle(color: Colors.white),
                          prefixIcon: const Icon(
                            Icons.access_time,
                            color: Colors.white,
                          ),
                          filled: true,
                          fillColor: const Color(0xFF454452),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(
                      bottom: 20, top: 20), // Adjust the margin as needed
                  child: const LabeledDivider(label: 'Description'),
                ),
                TextFormField(
                  controller: _description,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(
                      Icons.description,
                      color: Colors.white,
                    ),
                    filled: true,
                    fillColor: const Color(0xFF454452),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  maxLines: 4,
                ),
                const SizedBox(height: 30),
                NextButton(
                  onPress: () async {
                    print('Update Destination button pressed ${widget.token}');
                    final String token = widget.token;

                    // Query the destination by token
                    final QuerySnapshot querySnapshot = await _destination
                        .where("token", isEqualTo: token)
                        .limit(1)
                        .get();
        
                    if (querySnapshot.docs.isNotEmpty) {
                      final destinationId = querySnapshot.docs[0].id;
                          print('Update Destination button pressed ${destinationId}');
                      await _destination.doc(destinationId).update({
                        "description": _description.text,
                        "weekstartTime": _weekstartTimeController.text,
                        "weekendTime": _weekendTimeController.text,
                        "weekendstartTime": _weekendstartTimeController.text,
                        "weekendendTime": _weekendendTimeController.text,
                        // Check if _locationImage1 and _locationImage2 are not null before updating
                        if (_locationImage1.text.isNotEmpty)
                          "destinationImage1": _locationImage1.text,
                        if (_locationImage2.text.isNotEmpty)
                          "destinationImage2": _locationImage2.text,
                      });

                      MessagePopUp.display(
                        context,
                        title: "Success",
                        icon: const Icon(
                          Icons.check_circle_outline,
                          color: Colors.green,
                        ),
                        message: 'Destination details updated',
                      );
                    } else {
                      MessagePopUp.display(
                        context,
                        title: "Error",
                        icon: const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                        ),
                        message: 'Destination not found for the given token',
                      );
                    }
                  },
                  text: 'Update Destination',
                ),
              ],
            ),
          ),
        ]),
      ),
      backgroundColor: Colors.black,
      bottomNavigationBar: const DestinationBottomNav(),
    );
  }
}
